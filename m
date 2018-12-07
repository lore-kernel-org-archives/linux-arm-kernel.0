Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B18C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:34:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7024C20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMdC5m1O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB32tHBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7024C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a3rc5WLz+KhXXdrS317wqJqZ2y8rseDhOIHAEjWjv+Y=; b=bMdC5m1OFirI82
	C4sjQc7xXJrfSusFi8yFBjG7HSIgPqXOARP7Y02sgeyDe4gjjUxpFjUxbPm1pw3Ykv7qbTN36uH1B
	o8e76tofALuFGZ9dKeq+2RzpxHou49gW13kcg5TlooAkJAZvSmO1xU/diZn5g9MnM6dfEAkTPUv32
	5x9PG6oLeiG88me3dEvIpz9FQ8BrO+6rujMWHi+IiiP+1D7BVj7RSJnjLEveDNySBYwUCXpYJerer
	I1Zka51TAgOcrqb8LljZ4QJrohjfy7vB0oSJ5BtVq6aDx3m9UIwY+Y/GpZ5bu5Akh2Nh3gph4KR2e
	cXfHtg7Jd0/irUwbiygA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVOhE-0006jr-QF; Fri, 07 Dec 2018 22:34:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVOhB-0006hJ-4o
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 22:34:06 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 383D6214DE
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  7 Dec 2018 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544222034;
 bh=B7Q1t/mtMpyOYgsDuWVwjbnR0rh/2mSFhQPwF3ZxuSM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NB32tHBTlzMlYqUHhhzgjFZoh6RhlxjeHm9e749Qq/o/s3F1alceCamg8gXJJNAZS
 tDZVtvPdIehnX66qKCsvcGNeHXy2WLz4Zk3rWp7KKaz03cz0z5R3QWpvtB6meT6Puw
 Mdwgh9NEYQW2Ti3iRyoZaew7V8PyM7kS32o7gj/g=
Received: by mail-qt1-f170.google.com with SMTP id l11so6319684qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 14:33:54 -0800 (PST)
X-Gm-Message-State: AA+aEWYM1LdSsi2xV05ORBGhC4BzNFY0pqvs7ZuBaDjVpPXcEesjGJFo
 i+VMPXiDW+LmD9u/VxkJTGki+mXUj4htUN/79w==
X-Google-Smtp-Source: AFSGD/VkWzUzXUEs09bmsIo+2IEXNLO68gXAvY1GxxrAtnOY7a9Mp0tA6weqoK3or43C9kk8cipbNlRmVLpg1ZkhQ28=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr3840280qvl.77.1544222033276; 
 Fri, 07 Dec 2018 14:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
In-Reply-To: <20181204183649.GA5716@bogus>
From: Rob Herring <robh@kernel.org>
Date: Fri, 7 Dec 2018 16:33:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
Message-ID: <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: ARM-SoC Maintainers <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_143405_221264_C2F50400 
X-CRM114-Status: GOOD (  19.33  )
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
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 12:36 PM Rob Herring <robh@kernel.org> wrote:
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

Here's an updated mapping filled out with the rest of the platforms
and using SoC family names in some cases as discussed. The move is
completely scripted now including include fixups (though any new
includes could break things). So mainly just need to bikeshed the
directory mapping. Not sure if marvell should be split up more or not.
I split out pxa2xx and pxa3xx, but then there's other pxa chips I
think aren't really related. TI is still all one directory except
nspire. I was going to split out davinci too, but it's only a couple
of files. Sub-arch maintainers need to chime in with what they want.

A branch is here including a fix to dtbs_install:
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-move

vendor_map = {
    'alphascale' : 'alphascale',
    'alpine' : 'alpine',
    'artpec' : 'axis',
    'atlas' : 'sirf',
    'prima' : 'sirf',
    'axm' : 'lsi',
    'cx9' : 'cnxt',
    'ecx' : 'calxeda',
    'highbank' : 'calxeda',
    'efm' : 'efm32',
    'ep7' : 'cirrus',
    'mxs': 'mxs',
    'imx23': 'mxs',
    'imx28': 'mxs',
    'imx': 'imx',
    'ls': 'fsl',
    'vf': 'fsl',
    'qcom': 'qcom',
    'am3' : 'ti',
    'am4' : 'ti',
    'am5' : 'ti',
    'dra' : 'ti',
    'keystone' : 'ti',
    'omap' : 'ti',
    'compulab' : 'ti',
    'logicpd' : 'ti',
    'elpida' : 'ti',
    'motorola-cpcap' : 'ti',
    'twl' : 'ti',
    'da' : 'ti',
    'dm' : 'ti',
    'nspire' : 'nspire',
    'armada' : 'marvell',
    'dove' : 'marvell',
    'kirkwood' : 'marvell',
    'orion' : 'marvell',
    'mvebu' : 'marvell',
    'mmp2' : 'marvell',
    'berlin' : 'berlin',
    'pxa2' : 'pxa',
    'pxa3' : 'pxa',
    'pxa' : 'marvell',
    'arm-' : 'arm',
    'integ' : 'arm',
    'mps' : 'arm',
    've' : 'arm',
    'aspeed' : 'aspeed',
    'at91' : 'at91',
    'sama' : 'at91',
    'usb_' : 'at91',
    'tny_' : 'at91',
    'mpa1600' : 'at91',
    'animeo_ip' : 'at91',
    'aks-cdu' : 'at91',
    'ethernut5' : 'at91',
    'evk-pro3' : 'at91',
    'pm9g45' : 'at91',
    'ge86' : 'at91',
    'bcm' : 'brcm',
    'exynos' : 'exynos',
    's3c' : 'samsung',
    's5p' : 'samsung',
    'gemini' : 'gemini',
    'hi3' : 'hisilicon',
    'hip' : 'hisilicon',
    'hisi' : 'hisilicon',
    'mt' : 'mediatek',
    'meson' : 'meson',
    'moxa' : 'moxa',
    'nuvo' : 'nuvoton',
    'lpc' : 'lpc',
    'owl' : 'actions',
    'ox8' : 'oxsemi',
    'picox' : 'picoxcell',
    'r7' : 'renesas',
    'r8' : 'renesas',
    'r9' : 'renesas',
    'emev2' : 'renesas',
    'sh73a' : 'renesas',
    'gr-' : 'renesas',
    'iwg' : 'renesas',
    'rk' : 'rockchip',
    'rv11' : 'rockchip',
    'socfpga' : 'socfpga',
    'stm' : 'stm32',
    'sti' : 'sti',
    'st-pin' : 'sti',
    'ste' : 'st-ericsson',
    'spear' : 'spear',
    'sun' : 'allwinner',
    'axp' : 'allwinner',
    'tango' : 'sigma',
    'tegra' : 'nvidia',
    'uniph' : 'socionext',
    'vt8500' : 'vt8500',
    'wm8' : 'vt8500',
    'xen' : 'xen',
    'zx' : 'zte',
    'zynq' : 'xilinx',
}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
