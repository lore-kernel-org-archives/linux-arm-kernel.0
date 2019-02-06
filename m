Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C562184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M96iZZjJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfkW3BTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C562184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1D1/0oqao9ZBKyJQCgMFDIdYLEXFwnDdEsN1ENu8qtc=; b=M96iZZjJo4TCy+
	EcZaYITxG7Z86I4XYGBDQh+XcEkVYHkROaxdZjFZgiYXjiF1CIrTXFWi/4GAScnhtny+60kfJhVgx
	uJIf98OCONOVozMSA/54Jq6eq5CwtkqvBN9L9Thki/AucfqA94sEjUc7a11JHhNNBIq8lYt1ro+1I
	JdZMUim3Hb7jqzxmUKwjZWUBiBWT36I7gd7FllN3BmGgNpUGjdGENWQwnFlKYAynA0Yo+OKOoQBn3
	sVNl6eU7C4nqg5BECg78f1WRkBzy6gFOGuXl8WEH/SQhM3DE18ZACg+NWXF3cPXqhdopa3t4y0Rpz
	LWTCOpg7RraJ3AZ7aKAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grL6i-0006tF-I4; Wed, 06 Feb 2019 11:11:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grL6h-0006t4-CG
 for linux-arm-kernel@bombadil.infradead.org; Wed, 06 Feb 2019 11:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFIKABJz3EXRv7K0LXMzu1IAg5KkKUwUe29Va05VkcE=; b=VfkW3BTgMUkA1+IR34mikY80f
 3b8XDfjaqMI59nlAv8DIdEJ06UXIn3zZo6UCkHux07Aeh+YcUgoZTkOcN1tF+lmGEqA+2JB1Qqmox
 cfFezuZsv7DXwzqQaYaFG8aiETdfMZJ9jcBgqMHLOZRvWHVJu/j6DZEyu7ylS5Y9EAqGt6BhzfTMG
 pY/9PpJi/B9jn/rrcg4zAkCCVLRD8emsk8WwMmbpwoK2ESTovQ5KhaZVDHDuYcUthgpiC7R6tHvjV
 9N7RaDzGJgeP3UhiudrUnbR90PWdekpq+NNT3Pob9j3RvKUwVXgmGZ0nxFvt79UOOYAvncfxYtWvB
 iBPeD4zZw==;
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grL6e-0002eU-Jq
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:11:05 +0000
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1E5BE24000A;
 Wed,  6 Feb 2019 11:10:32 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 5/6] ARM64: dts: marvell: armada-37xx: declare USB2
 UTMI PHYs
In-Reply-To: <20190129093635.4321-6-miquel.raynal@bootlin.com>
References: <20190129093635.4321-1-miquel.raynal@bootlin.com>
 <20190129093635.4321-6-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 12:10:32 +0100
Message-ID: <87womd6ul3.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_061104_780830_DF781A8C 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On mar., janv. 29 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> On Marvell Armada 3700 SoCs there are two USB2 UTMI PHYs. They are
> both very similar but only one has OTG/charging capabilities.
>
> Because there are USB host registers and PHY registers mixed in a
> single area, a system controller is also created and referenced from
> both the USB host node and the PHY node.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 5cfd1b920f31..d2d8ef00c592 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -344,18 +344,46 @@
>  				compatible = "marvell,armada3700-xhci",
>  				"generic-xhci";
>  				reg = <0x58000 0x4000>;
> +				marvell,usb-misc-reg = <&usb32_syscon>;
>  				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&sb_periph_clk 12>;
>  				status = "disabled";
>  			};
>  
> +			usb2_utmi_otg_phy: phy@5d000 {
> +				compatible = "marvell,a3700-utmi-otg-phy";
> +				reg = <0x5d000 0x800>;
> +				marvell,usb-misc-reg = <&usb32_syscon>;
> +				#phy-cells = <0>;
> +			};
> +
> +			usb32_syscon: system-controller@5d800 {
> +				compatible = "marvell,armada-3700-usb2-host-device-misc",
> +				"syscon";
> +				reg = <0x5d800 0x800>;
> +			};
> +
>  			usb2: usb@5e000 {
>  				compatible = "marvell,armada-3700-ehci";
>  				reg = <0x5e000 0x1000>;
> +				marvell,usb-misc-reg = <&usb2_syscon>;
>  				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
>  
> +			usb2_utmi_host_phy: phy@5f000 {
> +				compatible = "marvell,a3700-utmi-host-phy";
> +				reg = <0x5f000 0x800>;
> +				marvell,usb-misc-reg = <&usb2_syscon>;
> +				#phy-cells = <0>;
> +			};
> +
> +			usb2_syscon: system-controller@5f800 {
> +				compatible = "marvell,armada-3700-usb2-host-misc",
> +				"syscon";
> +				reg = <0x5f800 0x800>;
> +			};
> +
>  			xor@60900 {
>  				compatible = "marvell,armada-3700-xor";
>  				reg = <0x60900 0x100>,
> -- 
> 2.19.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
