Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5656F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMoGutqo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="UxjRREB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5656F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TIwQI5Q9tNNLuGbQWBUTb36eX6CU3vm3z2aHOWCo2ng=; b=tMoGutqoGE2YzO
	CYG/fPmAVblTQc0UvzCvx9Dl+depaja+JLJTmowSzSkl3c7iCTL8vJDBA4BAMVpu6DGn4o8L+V+8N
	x6nacLiEQtwNVoNfFC4r+TZr/uXRlNOI/ZosexqbcHRjufp2Qhdc4U3+8frBoh1U4UDa9c+BN2q8G
	8t12gqpaA3Stfoq4U4SpcC+3WIuOB1FME3COhEug98rxB7rVPlfRgwyLQjYlQh/+Lqm5ivdcLRbZa
	L+g1F35iJigBPj52nzAFUIba+srMu36vnG9L4iy9XravRDG1FfmF/oofs79ach+YZZYjNcqR2v39I
	XJ/Yb+u914vsEp7UK0Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJ55-0001u4-AU; Tue, 04 Dec 2018 22:22:15 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJ51-0001tF-Cy
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:22:13 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 3350F25B799;
 Wed,  5 Dec 2018 09:21:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1543962118; bh=n3J/JWDw/meZRSzN3iwwvTG36kSfQNJvMs1ee0z6hZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UxjRREB5+rDctanZzreVMjoJ5DnVGU8aEth5nr10VxBKceS0j1XXqxJBRLz35lvsR
 iqT1O3Hddb64KpjamucJ6kL+d2fBS1sNrtdW0Z2LJOWpMTyXIRlz6kpn6vAC4cEc5+
 ETZv7iv4WUzYo6BmSdiL6AMlcRBHjuUUepHFhTFQ=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 1D4D3E22092; Tue,  4 Dec 2018 14:21:57 -0800 (PST)
Date: Tue, 4 Dec 2018 14:21:57 -0800
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181204222156.4wy3qk5yv23o5d4k@verge.net.au>
References: <20181204183649.GA5716@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204183649.GA5716@bogus>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_142211_641706_843C005A 
X-CRM114-Status: GOOD (  21.10  )
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
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm@kernel.org, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 12:36:49PM -0600, Rob Herring wrote:
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

The above 'r' prefixes could be a bit longer if desired.

e.g.:
      'r7s'
      'r8a'
      'r9a'

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

For renesas I believe you also want:

	'emev2'
	'gr-peach'
	'iwg20d-q7'
	'sh'


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
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
