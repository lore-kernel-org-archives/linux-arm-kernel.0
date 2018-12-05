Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:36:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF552084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WI09/dlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF552084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x1qeLZ6RqxTV6mb6L28JRL5yYYlXPjuhDmCd5DYC/34=; b=WI09/dlIHfyO+f
	zpzKRHDZNEoffvN2cxeqWEIN/CpBM7GNi4dLMhjxMpoPA1apjXp1gT18lv2PAFXBIVwNPV0aAwMpz
	fgcExemrpR6DaXiU67U/UU28dsTAbhZQDwUKQie12jgXbGvu632YtWVWruN19T2Ao7/qGa4ci7OYx
	aO6zv8TuzWZ/QzdcxzWlCPB/AbsfYt3h27H4DUtglzlh2o+z513mMGDg4r8+vNQ44DTiDIEmQMHTY
	x/gEFa02zzxeM1b4x6FeKyqRUdXOjw4/XMsZqF2CpHawHjZva5RO3hjCagIGG9RC9lwVypWAgrlTq
	mUY83xY0RhAEABzj/ZuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUb6B-0001iZ-6p; Wed, 05 Dec 2018 17:36:35 +0000
Received: from mail-oi1-f169.google.com ([209.85.167.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUb68-0001hz-3v
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:36:33 +0000
Received: by mail-oi1-f169.google.com with SMTP id x202so18213583oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L2kmX5EF88i4shBwlZUMUak2wEocuQRRe1jZalCmsMo=;
 b=aJcA7sch4fB3ae7MW+QefXalxRvQ5HgwcHrWRYtzKZdT+Ur/s3oEMnGerxY8Tj+dgW
 YQQnRzNvwHhR+CXIdzXgjbWb1SB6XwjGJvNJc0J0tCCVSiGv1pJ7JR2fFRe9pbcF+d4U
 ms2RRfFfGYha00zqjUvH26ZVB3rYZWkh0BKtpys+AgWn0sez8dU+yqGH4ilw+8/At0Mi
 K1ewqM5RKQg2eXoOTd2Fud/NZZAeImJkgyAlQZ23HASJt9SmyuwewBHhOTBosRtGXyIv
 oFNcAAA4iyVWL9pfFRyi4SEXn2Iv8YHzOtWm+NGNQ50PbbpvxQX3xLG7fQlrc6akkrNS
 6Lhw==
X-Gm-Message-State: AA+aEWbrBO7c6O1xBZqfOjZOfjFjlOn3kU/ai32tYxvP9kkaU1ijac87
 rAQ9AVTrTZcoGKbqa1rQOMPhL1lCJL4=
X-Google-Smtp-Source: AFSGD/Uoz89fk5og8DDGgEZQwzpWaioth9cLEIeSyjCkaqIWczMVdo5wQyxnmq3CbxxpXkR4DgzezA==
X-Received: by 2002:aca:308f:: with SMTP id w137mr16268568oiw.49.1544031380291; 
 Wed, 05 Dec 2018 09:36:20 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com.
 [209.85.167.169])
 by smtp.gmail.com with ESMTPSA id 52sm36898751oti.30.2018.12.05.09.36.19
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 09:36:20 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id j21so18230739oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:36:19 -0800 (PST)
X-Received: by 2002:aca:654a:: with SMTP id j10mr14848906oiw.301.1544031379195; 
 Wed, 05 Dec 2018 09:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
In-Reply-To: <20181204183649.GA5716@bogus>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 11:36:07 -0600
X-Gmail-Original-Message-ID: <CADRPPNRYr1iULKtDHvzGcMmXqnMSKrLy5h-S=JVae+d5LFxP3Q@mail.gmail.com>
Message-ID: <CADRPPNRYr1iULKtDHvzGcMmXqnMSKrLy5h-S=JVae+d5LFxP3Q@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_093632_161620_B7D92215 
X-CRM114-Status: GOOD (  21.02  )
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
Cc: andrew@lunn.ch, alexandre.belloni@bootlin.com, tony@atomide.com,
 Linus Walleij <linus.walleij@linaro.org>, liviu.dudau@arm.com,
 yamada.masahiro@socionext.com, Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, khilman@kernel.org,
 gregory.clement@bootlin.com, Michal Simek <michal.simek@xilinx.com>,
 krzk@kernel.org, arm@kernel.org, joel@jms.id.au,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 horms@verge.net.au,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, mcoquelin.stm32@gmail.com,
 Shawn Guo <shawnguo@kernel.org>, afaerber@suse.de,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 12:37 PM Rob Herring <robh@kernel.org> wrote:
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

Probably we can update "fsl" to "nxp" now since you are at it.  :)  We
didn't try to update this previously because for the past two years we
were thinking that it will need to be updated to qcom again soon.

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
