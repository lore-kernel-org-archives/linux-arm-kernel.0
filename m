Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E467C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63440206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dn/kQUyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63440206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yyRn6gb7MdbScRh5KNNIgl9Ol/12KFSnPHVsBpegwRU=; b=dn/kQUyz3at4L+
	nykzd3esAaZmhbFHZ3nl9YlQ/VPNOUhOK7+obMrhh3ftVEwYyITO1QXrTW8MmOKfNebaFWN2Cvwkw
	gmgSNANHS5n1vFrOo2xSUE+lPZB2zVlSGFhcRdE0VV/qOBzqormDYBUNb6Y5/h2awe2TrguZMCxR9
	SZxKRAhp9EpJExVUptINfd2RherO+1CnAB2iq3lcDV5AwQftCuf0UCsr6xLfIqpZflJbhQ4Z4o3OZ
	kTbxcbf0WqgNoEzU6QpZrrXICNrorALOs4FIAmDjQgnbumYyzetqS1OsjL/I5sYbAk28gPTrDK5f8
	+9f4d0VOQY3cG/7Fka0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFjz-0003b1-Q3; Tue, 04 Dec 2018 18:48:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFju-0003Zd-O7
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:48:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 41578207AD; Tue,  4 Dec 2018 19:47:56 +0100 (CET)
Received: from localhost (rytm-gw1.ter1.ncp1.par.cust.as8218.eu [83.167.32.99])
 by mail.bootlin.com (Postfix) with ESMTPSA id 189A72074D;
 Tue,  4 Dec 2018 19:47:46 +0100 (CET)
Date: Tue, 4 Dec 2018 19:47:45 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181204184745.GS8952@piout.net>
References: <20181204183649.GA5716@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204183649.GA5716@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_104810_931239_60A0A4B5 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm@kernel.org, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Rob,

On 04/12/2018 12:36:49-0600, Rob Herring wrote:
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

Unfortunately, we have many boards without a proper prefix. Wouldn't it
be better to use arch/arm/boot/dts/Makefile and map dtb-$(CONFIG_*) to a
vendor directory?

This way you would be sure to not miss any. This would also ease the
creation of subdirs if we decide to do that.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
