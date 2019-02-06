Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E13C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:00:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C6420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SnLqQ3r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C6420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5O5xopYs9TAsJvWeH1nSRdxFCYbOEGpEacREoqWujhQ=; b=SnLqQ3r/juA/R2
	03j8B7tI/sQpJ/Lhg5u9Sm9+Ij7+ev0cMESuoF1Uj4xHCYmOXWLcCGuKjAzu5Rbgs/BXW++vVDreg
	AwQ7ybCakZfsDnqLa+AYRN+BMURQMyEF2Z0oVfWmjNkr/bp6N5dPf9l8KXEyRYOSU72ehhtA+H31C
	Xhzwc/yZQYafICIMBzLNt52RQaFLaXi+3hQL9pARkeBQuZW8SiFHXymky2zWW/2JkzGhvjJZgFkd0
	f5b5Mgp1Tg3OkKImdKG+xA8CjP4U5KjJEE0/JOYNyCP1sNKkUhNs05b2xIhTjsQtJLvNbLXrv438k
	3Zkzj4j4zfm1A6RuNz4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNkk-0007q8-CB; Wed, 06 Feb 2019 14:00:38 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNkg-0007pW-7v
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:00:36 +0000
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 53F05C0008;
 Wed,  6 Feb 2019 14:00:21 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 7/7] ARM64: dts: marvell: armada-37xx: declare the
 COMPHY node
In-Reply-To: <20190108163124.6409-8-miquel.raynal@bootlin.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
 <20190108163124.6409-8-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 15:00:20 +0100
Message-ID: <87ef8l6mq3.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_060034_459200_823361E0 
X-CRM114-Status: GOOD (  14.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Describe the A3700 COMPHY node. It has three PHYs that can be
> configured as follow:
> * PCIe or GbE
> * USB3 or GbE
> * SATA or USB3
> Each of them has its own memory area.
>
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index e7405931f381..036d6fd6c9ef 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -242,6 +242,35 @@
>  				reg = <0x14000 0x60>;
>  			};
>  
> +			comphy: phy@18300 {
> +				compatible = "marvell,comphy-a3700";
> +				reg = <0x18300 0x300>,
> +				      <0x1F000 0x400>,
> +				      <0x5C000 0x400>,
> +				      <0xe0178 0x8>;
> +				reg-names = "comphy",
> +					    "lane1_pcie_gbe",
> +					    "lane0_usb3_gbe",
> +					    "lane2_sata_usb3";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				comphy0: phy@0 {
> +					reg = <0>;
> +					#phy-cells = <1>;
> +				};
> +
> +				comphy1: phy@1 {
> +					reg = <1>;
> +					#phy-cells = <1>;
> +				};
> +
> +				comphy2: phy@2 {
> +					reg = <2>;
> +					#phy-cells = <1>;
> +				};
> +			};
> +
>  			pinctrl_sb: pinctrl@18800 {
>  				compatible = "marvell,armada3710-sb-pinctrl",
>  					     "syscon", "simple-mfd";
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
