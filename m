Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF7C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41F72184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Df1DMKfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41F72184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D5iq4+1v6Gh3mYIFPTL+s8UX/12vCz08cA0PxE0VWck=; b=Df1DMKfiwq3+S+
	Wc+qqJPYHP+F9QNOtGXZKnjy+0Dh96d/Evzn4yAtgH1QAkRqGE2evJaKBfeKWxIudS+jBMSeEwP/6
	oSfjiSP++iLGhcvYuRCA/xJT9XiAWgEYCDE3H3plAoL/1AxQiEO68Lfm1YlbJ4Aa3YC44+SmUMaq6
	TS3dAf31XL6nGc2BPtvG15PNJ0QD3g0UPyDwFY6hbIhmUEPtHgOzxfRYa64Q30rl8kaHLWBugTSNJ
	VZoXTB790HLi2hknaea25/owzWHee9gts0B4Rhz8bDgxL7hcxMOSADFXY8Kq14phB6n0jIh/GT3Jg
	wpwQNVxf9bxuWp5so0+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLxo-0005sC-AB; Wed, 23 Jan 2019 17:05:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLxk-0005r2-65
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:05:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07DEEBD;
 Wed, 23 Jan 2019 09:05:14 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FF53F237;
 Wed, 23 Jan 2019 09:05:11 -0800 (PST)
Date: Wed, 23 Jan 2019 17:05:09 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_090516_235923_EF081A2D 
X-CRM114-Status: GOOD (  26.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 05:24:25PM +0100, Miquel Raynal wrote:
> Hello,
> 
> As part of an effort to bring suspend to RAM support to Armada 3700
> SoCs (main target: ESPRESSObin), this series handles the work around
> the PCIe IP.
> 
> First, more configuration is done in the 'setup' helper as inspired
> from the U-Boot driver. This is needed to entirely initialize the IP
> during future resume operation (patch 1).
> 
> Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> current device trees do not provide the corresponding properties, not
> finding one of these properties is not an error and just produces a
> warning. However, if the property is present, an error during PHY
> initialization will fail the probe of the driver.
> 
> Note: To be sure the clock will be resumed before this driver, a first
> series adding links between clocks and consumers has been submitted,
> see [1]. Anyway, having the clock series applied first is not needed.

I do not understand what this means, in particular in relation
to the blocking clock calls in the suspend/resume NOIRQ hooks.

Thanks,
Lorenzo

> Patch 5 adds suspend/resume hooks, re-using all the above.
> 
> Finally, bindings and device trees are updated to reflect the hardware
> (patch 6-12). While the clock depends on the SoC, the reset GPIO and
> the PHY depends on the board so the clock is added in the
> armada-37xx.dtsi file while the two other properties are added in
> armada-3720-espressobin.dts.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623885.html
> 
> Thanks,
> Miqu??l
> 
> 
> Changes since v2:
> =================
> * Minor patches reordering.
> * Added pinctrl patches from Gregory Clement fixing the PCIe pins. His
>   changes implied modifications in the DT/bindings patches adding PCIe
>   reset pin support.
> * Added a new patch that enlarges the PIO timeout of the driver
>   (explanations in the commit log).
> * With the timeout changed, removed the "experimental delay" that was
>   needed at resume time before accessing any register.
> 
> Changes since v1:
> =================
> * Change the capitalization in commit titles to follow the PCI
>   subsystem rules.
> * Added Suggested-by tag to the patch adding PHY support and to the
>   patch adding the PHY property in the DT.
> * Added Rob's Reviewed-by tags on bindings.
> * I am following the discussion about calling functions that might
>   sleep in a NOIRQ context. As there is no real problem yet (as per my
>   understanding), I did not change anything on this regard.
> 
> 
> Miquel Raynal (15):
>   PCI: aardvark: Enlarge PIO timeout
>   PCI: aardvark: Configure more registers in the configuration helper
>   PCI: aardvark: Add clock support
>   PCI: aardvark: Add PHY support
>   PCI: aardvark: Add PCIe warm reset support
>   PCI: aardvark: Add external reset GPIO support
>   PCI: aardvark: Add suspend to RAM support
>   dt-bindings: PCI: aardvark: Describe the clocks property
>   dt-bindings: PCI: aardvark: Describe the PHY property
>   dt-bindings: PCI: aardvark: Describe the PCIe endpoint card reset pins
>   dt-bindings: PCI: aardvark: Describe the reset-gpios property
>   ARM64: dts: marvell: armada-37xx: declare PCIe clock
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe PHY
>   ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe warm reset
>     pin
> 
>  .../devicetree/bindings/pci/aardvark-pci.txt  |  14 ++
>  .../dts/marvell/armada-3720-espressobin.dts   |   3 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  10 +
>  drivers/pci/controller/pci-aardvark.c         | 217 +++++++++++++++++-
>  4 files changed, 243 insertions(+), 1 deletion(-)
> 
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
