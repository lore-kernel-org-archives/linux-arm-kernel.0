Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1F7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:20:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EE120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBz8vf5l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uyXY7Z3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EE120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2mlBHPcaMDxMLs4OmSJi2QO8dGN/KXYBbRCioiHPRrA=; b=tBz8vf5lsnaVnv
	/MfqVrDRwo4QI/HQzmHx6ZZZiJrHFbjlQcv6KcqUDJmcIMIQlFncgDLqq8trnMVLO43AljyH6mHvj
	zcfwLgUJuFcwEVnJi0JFtzCQPHzTPLBYwpBaYiZY14I+nM4FdljZ2tlVc/FBQKz3MYbSs3T3Lzx4P
	9UYsnzo8PPWY34jYlPboqfSklYnLO/J5W/gfdzDU8npqDgx6sC9S2iu21oPCsNnjCv+UvDKeFTKjR
	TPPz6J2xsdTSaEjDFl1ATFaNJ5m3kC9GY2PwqqhIW0tqsVyJzWmlu0/yLKxtFCjb4kanhAI9Fr/qy
	CECTVHEKdk1mOuAuBtvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOfV-0002Qw-Rf; Wed, 05 Dec 2018 04:20:13 +0000
Received: from conssluserg-03.nifty.com ([210.131.2.82])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOfS-0001Bo-Bv
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:20:12 +0000
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id wB54JMFW030642
 for <linux-arm-kernel@lists.infradead.org>; Wed, 5 Dec 2018 13:19:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB54JMFW030642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1543983563;
 bh=L1UGMCWRVziP6ruWY2a+q7Zkn69D8SfEwAu5oIpxq/I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uyXY7Z3nx7xAHjIg2HFJLTTvBjXs0RObwXD/JqoSil2IV7cKKRVbGW+ATvSghtUx0
 VSf2lQqd7zyneFqqUBdcMkq7CoQwS+vip1NuOTFEsziTaC6TmnVzEweHgMYX9tFail
 kjcKEgM4+ukHWGVuajkpFk6iI/mivhWxMk7WEuYCAwFPBgdsNvLopXwNHQq+0ucLiC
 ZcyjEoWhtJwWu/aUbHEAOfgViElm1KZ7r5bwcxPGRLtfod2hw8b0lKzsvMy99tvSpD
 nz98m2n8Nle6TG9UWczar9OsmIzq7CEGrX3QqYE7IsQxEhbuYpr/Brc+MRVb/NYA+K
 o6lCs58N++fgA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id g68so11264462vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 20:19:23 -0800 (PST)
X-Gm-Message-State: AA+aEWaxiA6K9WAExvIcUFg78pdZa1i2+xZ82M71VwkYAVJUfSjh95HX
 1tOYVmBGLJZmfeX8iSeIX0VVWx5o9PBztlTjbmg=
X-Google-Smtp-Source: AFSGD/WCyBwFTeubqOQ8Uxsr9/rawR+mxiLil9zcremLLpHqWGbD4xA1awDw8CygwSY88nl4Gk0YXKKvDdoj4xWJUdc=
X-Received: by 2002:a67:a858:: with SMTP id r85mr9806394vse.215.1543983562455; 
 Tue, 04 Dec 2018 20:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
In-Reply-To: <20181204183649.GA5716@bogus>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 5 Dec 2018 13:18:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-O0Xnkb3egp-B8+0hFaeBM_pzn0f0XQJ3+FLgBwNCaQ@mail.gmail.com>
Message-ID: <CAK7LNAQ-O0Xnkb3egp-B8+0hFaeBM_pzn0f0XQJ3+FLgBwNCaQ@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_202010_760812_2AC60F2A 
X-CRM114-Status: GOOD (  23.33  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 gregory.clement@bootlin.com, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, arm-soc <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 DTML <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 3:37 AM Rob Herring <robh@kernel.org> wrote:
>
> Olof, Arnd,
>
> I've put together a script to move the dts files and update the
> makefiles. It doesn't handle files not following a common prefix which
> isn't many and some includes within the dts files will need some fixups
> by hand.
>
> MAINTAINERS will also need updating.
>
> A few questions:
>
> Do we want to move absolutely everything to subdirs? There's quite a
> few platforms with only 1-2 platforms. I haven't added these to the
> list yet, but can.
>
> Do any vendors need another level of directories? davinci, omap, nspire,
> etc. for TI for example.
>
> What to do with armv7m.dtsi? I guess it should remain and we just fixup
> the include. There may be a few other cross vendor things.
>
>
> Sub-arch maintainers,
> 'vendor_map' below is the mapping of file prefix to new subdirectory
> (the SoC vendor prefix). Please comment if there are any issues.
>
> Rob
>
> 8<-----------------------------------------------------------
> #!/usr/bin/env python3
>
> import os
> import re
> from git import Git
> import glob
>
> vendor_map = {
>     'imx': 'fsl',
>     'ls': 'fsl',
>     'vf': 'fsl',
>     'qcom': 'qcom',
>     'am3' : 'ti',
>     'am4' : 'ti',
>     'am5' : 'ti',
>     'da' : 'ti',
>     'dm' : 'ti',
>     'dra' : 'ti',
>     'keystone' : 'ti',
>     'omap' : 'ti',
>     'nspire' : 'ti',
>     'armada' : 'marvell',
>     'berlin' : 'marvell',
>     'dove' : 'marvell',
>     'kirkwood' : 'marvell',
>     'orion' : 'marvell',
>     'pxa' : 'marvell',
>     'mvebu' : 'marvell',
>     'mmp2' : 'marvell',
>     'arm-' : 'arm',
>     'integ' : 'arm',
>     've' : 'arm',
>     'aspeed' : 'aspeed',
>     'at91' : 'atmel',
>     'sama' : 'atmel',
>     'bcm' : 'brcm',
>     'exynos' : 'samsung',
>     's3c' : 'samsung',
>     's5p' : 'samsung',
>     'gemini' : 'cortina',
>     'hi3' : 'hisilicon',
>     'hip' : 'hisilicon',
>     'hisi' : 'hisilicon',
>     'mt' : 'mediatek',
>     'meson' : 'amlogic',
>     'owl' : 'actions',
>     'r7' : 'renesas',
>     'r8' : 'renesas',
>     'r9' : 'renesas',
>     'rk' : 'rockchip',
>     'socfpga' : 'altera',
>     'st' : 'st',
>     'spear' : 'st',
>     'sun' : 'allwinner',
>     'tegra' : 'nvidia',
>     'zynq' : 'xilinx',
>     'wm' : 'wm',
>     'uniph' : 'socionext',


I tested this script, and
I confirmed all of my DT files were moved to the socionext subdirectory.

However, this would break arm64 build
because some of my arm64 DT files include arm32 ones.

I think it is common to share base platform boards between arm and arm64.

Of course, It will be pretty easy to fix it up by hand later, though.





>     'zx' : 'zte',
> }
>
> if __name__ == "__main__":
>     g = Git('.')
>
>     g.checkout("HEAD", "arch/arm/boot/dts/Makefile")
>     dts_make = open("arch/arm/boot/dts/Makefile", "r").read()
>
>     # make entries 1 line
>     make2 = re.sub(r'\\\n', '', dts_make)
>
>     for k,v in vendor_map.items():
>         for f in glob.iglob("arch/arm/boot/dts/" + k + "*.*"):
>             new_dir = "arch/arm/boot/dts/" + v + "/"
>             base = os.path.splitext(os.path.basename(f))[0]
>
>             os.makedirs(new_dir, exist_ok=True)
>             g.mv(f, new_dir)
>
>             # Remove the file from the makefile
>             dts_make = re.sub('.*' + base + r'\.dtb.*\\\n', '', dts_make)
>             dts_make = re.sub('.*' + base + r'\.dtb', '', dts_make)
>
>             # extract the matching makefile entry
>             reg = re.search(r'.*' + base + r'.*', make2)
>             if not reg:
>                 continue
>
>             entry = reg.group(0)
>             make2 = re.sub(r'.*' + base + r'.*', '', make2)
>             if entry:
>                 makefile = open(new_dir + 'Makefile', 'a+')
>                 print(entry, file=makefile)
>                 makefile.close()
>
>
>     for d in sorted(glob.iglob("arch/arm/boot/dts/*/")):
>         dts_make += 'subdir-y += ' + d.split(os.path.sep)[-2] + '\n'
>
>         # Add license and sort entries of sub-dir makefile
>         vendor_make = '# SPDX-License-Identifier: GPL-2.0\n'
>         make_lines = open(d + 'Makefile', 'r').readlines()
>         for l in sorted(make_lines):
>             vendor_make += l
>
>         vendor_make = re.sub(r'\t', r'\\\n\t', vendor_make)
>
>         f = open(d + 'Makefile', 'w')
>         f.write(vendor_make)
>         f.close()
>         g.add(d + 'Makefile')
>
>     # Remove entries with no dtbs left
>     dts_make = re.sub(r'.*\+= \\\n\n', '', dts_make)
>
>     open("arch/arm/boot/dts/Makefile", "w").write(dts_make)
>     g.add("arch/arm/boot/dts/Makefile")



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
