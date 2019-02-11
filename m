Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B35C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:00:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230792084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hIJpuDgl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQcHsTlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230792084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ixESmqquQCyuHFMXjHDwSUVfNF6ebApq9Zno/ByIK3Q=; b=hIJpuDglr0Xgrb
	you97gm39ncs2cLvf0GefrhmqxAXblc9SHXfLH/DgL4kCRViPgEYgVpw/woeNqBKkUk7c/XoAufOJ
	DLBPX5cyK2l2Pv4IM7pg/SaeVrv+NKj1iPF7O/6CxARKUghIa+XVac2EyD530QX8VifS+D6TMGUTS
	PI/BObMnSSnwa6l1YIYvXgDG1J8YNCRqH1SiFFu9DshR1XuhxJQEUZkF32Fifk4fF3AmIkbY2ZBg7
	yBIlS6u1qm6Wfv0ErEv28wz8D4bqKQF2WXZs6Xv8esITasIB+GdDrlvzFM7lJ+5xKbvd9rqkiLGg4
	aGhLHaPsdDaSktKA/o/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1pa-0004kB-Ld; Mon, 11 Feb 2019 03:00:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1pX-0004jo-3D
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 03:00:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D39602084D;
 Mon, 11 Feb 2019 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549854022;
 bh=jFFdUdmZR+8+pklJInfAS48rz7z5gLoq/q7RU4qL4Oc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WQcHsTlQCgDdoDHMmgcp/KlgHGu7JeHRn2Huseld7EzXr4sZIrH/zGPdNOy7Qpfj/
 4AUek1Dr4GO0nHGVpYPtGnX0q2Ok165BVcOOf7j94xQqzcQ5KdMpNYYdbzwPuajeqC
 Ak5xaLR41ecqKUAWuDlHVk+E3UVokemJHueblwqg=
Date: Mon, 11 Feb 2019 11:00:12 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Message-ID: <20190211030010.GI22487@dragon>
References: <20190206150520.9683-1-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206150520.9683-1-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_190023_173142_D14638E5 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 09:40:33AM +0000, Pankaj Bansal wrote:
> The two external MDIO buses used to communicate with phy devices that are
> external to SOC are muxed in LX2160AQDS board.
> 
> These buses can be routed to any one of the eight IO slots on LX2160AQDS
> board depending on value in fpga register 0x54.
> 
> Additionally the external MDIO1 is used to communicate to the onboard
> RGMII phy devices.
> 
> The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> controlled by bits 0-3 of fpga register.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     V3:
>     - Add status = disabled in soc file and status = okay in board file
>       for external MDIO nodes
>     - Add interrupts property in external mdio nodes in soc file
>     V2:
>     - removed unnecassary TODO statements
>     - removed device_type from mdio nodes
>     - change the case of hex number to lowercase
>     - removed board specific comments from soc file
> 
>  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
>  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
>  2 files changed, 145 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22abbe725..079264b391a2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -35,6 +35,14 @@
>  	status = "okay";
>  };
>  
> +&emdio1 {
> +	status = "okay";
> +};
> +
> +&emdio2 {
> +	status = "okay";
> +};
> +
>  &esdhc0 {
>  	status = "okay";
>  };
> @@ -46,6 +54,121 @@
>  &i2c0 {
>  	status = "okay";
>  
> +	fpga@66 {
> +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> +		reg = <0x66>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		mdio-mux-1@54 {
> +			mdio-parent-bus = <&emdio1>;
> +			reg = <0x54>;		 /* BRDCFG4 */
> +			mux-mask = <0xf8>;      /* EMI1_MDIO */
> +			#address-cells=<1>;
> +			#size-cells = <0>;
> +
> +			mdio@0 {
> +				reg = <0x00>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};

Please have a newline between nodes.  It doesn't deserve a respin
though.  I can fix them up when applying if Leo is fine with this
version.

Shawn

> +			mdio@40 {
> +				reg = <0x40>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@c0 {
> +				reg = <0xc0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@c8 {
> +				reg = <0xc8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@d0 {
> +				reg = <0xd0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@d8 {
> +				reg = <0xd8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@e0 {
> +				reg = <0xe0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@e8 {
> +				reg = <0xe8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@f0 {
> +				reg = <0xf0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@f8 {
> +				reg = <0xf8>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		mdio-mux-2@54 {
> +			mdio-parent-bus = <&emdio2>;
> +			reg = <0x54>;		 /* BRDCFG4 */
> +			mux-mask = <0x07>;      /* EMI2_MDIO */
> +			#address-cells=<1>;
> +			#size-cells = <0>;
> +
> +			mdio@0 {
> +				reg = <0x00>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@1 {
> +				reg = <0x01>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@2 {
> +				reg = <0x02>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@3 {
> +				reg = <0x03>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@4 {
> +				reg = <0x04>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@5 {
> +				reg = <0x05>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@6 {
> +				reg = <0x06>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +			mdio@7 {
> +				reg = <0x07>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +
>  	i2c-mux@77 {
>  		compatible = "nxp,pca9547";
>  		reg = <0x77>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..7def5252ac1a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,27 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> +		emdio1: mdio@8b96000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8b96000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			little-endian;	/* force the driver in LE mode */
> +			status = "disabled";
> +		};
> +
> +		/* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> +		emdio2: mdio@8b97000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8b97000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			little-endian;	/* force the driver in LE mode */
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
