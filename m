Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB68C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5552084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edfCWgyV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrJVJ6GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5552084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5RqXGVlUg6UJuDukLziEouaFnd1R4HE3EXSC6a9l7g4=; b=edfCWgyVFfgPPc
	fBocR05GLlD18LTuAOQMZ7bVwQiAeVOa/+UuU/0JZTd9IgAPJ+K+BW1RGNRgsjpcv89N54zWHEcdu
	92P6SxzOETzTAAproICFqx0axRg/rnhjMCTWD1NH0W1RQWTCqfayu+eswN5nuZ3BZ1DBU0b4EnUzh
	fEqsvTQG/+tp3xGtA9KGxWMZgAlD+vB1CgDl0nBPu/6ZSVSH2Hml2LkX2St0g+s/JioM3oy1kzqsd
	JTmz7wmIu9WOeIjuF3svXVu5uzTm8QIDXPpl0uTmm0bkjuVl27GOuVwAJA0BooTEDx07rN0oXrJzc
	aBdItTBaSx1e8x0alywQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghmj3-0000q8-B1; Fri, 11 Jan 2019 02:39:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghmiz-0000pe-HV
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 02:39:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5385D2084C;
 Fri, 11 Jan 2019 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547174348;
 bh=ZN2zG57NMgyO+AiT04iy7pPNV8he3HH6tN5liEMzN4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OrJVJ6GCEVgymv2pvTOVxs3gph39lCTbuicneX+rTrtRThtmEIyDzRg8z/qmFLXkg
 ZJzrFrOUqFa//zkphrib5BCFpcBCv4pZco8lmSN1kZ9Hj23Y98huQwyWYilFXxjZKZ
 zj4fMrlUcUcpj+OIofARQmLQyYGTldcgPS1qi+vY=
Date: Fri, 11 Jan 2019 10:38:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH 1/3] dts: arm64: fsl: lsch2: fix status field of serdes
 controlled devices
Message-ID: <20190111023856.GG25218@dragon>
References: <20181212123505.32415-1-pankaj.bansal@nxp.com>
 <20181212123505.32415-2-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212123505.32415-2-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_183909_617565_7590FD36 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 07:09:54AM +0000, Pankaj Bansal wrote:
> This patch disables that devices that are controlled by serdes
> (pcie, sata, ethernet macs) in SOC dtsi files and enables the
> interfaces in board dts file.
> 
> Actually this practise should be followed for all the devices and
> not for only serdes controlled devices.
> 
> refer https://elinux.org/Device_Tree_Linux#disabled_nodes
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>

The subject prefix should be 'arm64: dts: ...'

> ---
>  .../boot/dts/freescale/fsl-ls1043a-qds.dts   | 18 +++++++++++++
>  .../boot/dts/freescale/fsl-ls1043a-rdb.dts   | 17 +++++++++++++
>  .../boot/dts/freescale/fsl-ls1043a.dtsi      |  1 +
>  .../boot/dts/freescale/fsl-ls1046a-qds.dts   | 18 +++++++++++++
>  .../boot/dts/freescale/fsl-ls1046a-rdb.dts   | 24 ++++++++++++++++++
>  .../boot/dts/freescale/fsl-ls1046a.dtsi      |  1 +
>  .../dts/freescale/qoriq-fman3-0-10g-0.dtsi   |  1 +
>  .../dts/freescale/qoriq-fman3-0-10g-1.dtsi   |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-0.dtsi    |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-1.dtsi    |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-2.dtsi    |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-3.dtsi    |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-4.dtsi    |  1 +
>  .../dts/freescale/qoriq-fman3-0-1g-5.dtsi    |  1 +
>  14 files changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> index dff3d648172e..384b21f8a606 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> @@ -65,6 +65,20 @@
>  		compatible = "fsl,ls1043aqds-fpga", "fsl,fpga-qixis";
>  		reg = <0x2 0x0 0x0000100>;
>  	};
> +
> +	soc {
> +		pcie@3400000 {

Can we label these devices in <soc>.dtsi and flip the 'status' using
labeling node, just like &sata below?

Shawn

> +			status = "okay";
> +		};
> +
> +		pcie@3500000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3600000 {
> +			status = "okay";
> +		};
> +	};
>  };
>  
>  &i2c0 {
> @@ -147,4 +161,8 @@
>  	};
>  };
>  
> +&sata {
> +	status = "okay";
> +};
> +
>  #include "fsl-ls1043-post.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index 17ca357e854f..50a744c3c428 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -25,6 +25,16 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	soc {
> +		pcie@3500000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3600000 {
> +			status = "okay";
> +		};
> +	};
>  };
>  
>  &i2c0 {
> @@ -111,36 +121,43 @@
>  	ethernet@e0000 {
>  		phy-handle = <&qsgmii_phy1>;
>  		phy-connection-type = "qsgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@e2000 {
>  		phy-handle = <&qsgmii_phy2>;
>  		phy-connection-type = "qsgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@e4000 {
>  		phy-handle = <&rgmii_phy1>;
>  		phy-connection-type = "rgmii-txid";
> +		status = "okay";
>  	};
>  
>  	ethernet@e6000 {
>  		phy-handle = <&rgmii_phy2>;
>  		phy-connection-type = "rgmii-txid";
> +		status = "okay";
>  	};
>  
>  	ethernet@e8000 {
>  		phy-handle = <&qsgmii_phy3>;
>  		phy-connection-type = "qsgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@ea000 {
>  		phy-handle = <&qsgmii_phy4>;
>  		phy-connection-type = "qsgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@f0000 { /* 10GEC1 */
>  		phy-handle = <&aqr105_phy>;
>  		phy-connection-type = "xgmii";
> +		status = "okay";
>  	};
>  
>  	mdio@fc000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 70057b4e46e8..eea23b84daee 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -639,6 +639,7 @@
>  			interrupts = <0 69 0x4>;
>  			clocks = <&clockgen 4 0>;
>  			dma-coherent;
> +			status = "disabled";
>  		};
>  
>  		msi1: msi-controller1@1571000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> index e58a8ca1386c..1c3ccf17a554 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> @@ -30,6 +30,20 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	soc {
> +		pcie@3400000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3500000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3600000 {
> +			status = "okay";
> +		};
> +	};
>  };
>  
>  &dspi {
> @@ -176,4 +190,8 @@
>  	};
>  };
>  
> +&sata {
> +	status = "okay";
> +};
> +
>  #include "fsl-ls1046-post.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index a59b48203688..65ea27c8341a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -25,6 +25,20 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	soc {
> +		pcie@3400000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3500000 {
> +			status = "okay";
> +		};
> +
> +		pcie@3600000 {
> +			status = "okay";
> +		};
> +	};
>  };
>  
>  &duart0 {
> @@ -120,37 +134,47 @@
>  	};
>  };
>  
> +&sata {
> +	status = "okay";
> +};
> +
>  #include "fsl-ls1046-post.dtsi"
>  
>  &fman0 {
>  	ethernet@e4000 {
>  		phy-handle = <&rgmii_phy1>;
>  		phy-connection-type = "rgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@e6000 {
>  		phy-handle = <&rgmii_phy2>;
>  		phy-connection-type = "rgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@e8000 {
>  		phy-handle = <&sgmii_phy1>;
>  		phy-connection-type = "sgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@ea000 {
>  		phy-handle = <&sgmii_phy2>;
>  		phy-connection-type = "sgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@f0000 { /* 10GEC1 */
>  		phy-handle = <&aqr106_phy>;
>  		phy-connection-type = "xgmii";
> +		status = "okay";
>  	};
>  
>  	ethernet@f2000 { /* 10GEC2 */
>  		fixed-link = <0 1 1000 0 0>;
>  		phy-connection-type = "xgmii";
> +		status = "okay";
>  	};
>  
>  	mdio@fc000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 9a2106e60e19..49a363abf2ad 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -599,6 +599,7 @@
>  			reg-names = "ahci", "sata-ecc";
>  			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 1>;
> +			status = "disabled";
>  		};
>  
>  		msi1: msi-controller@1580000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
> index dbd2fc3ba790..515be7448e3e 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
> @@ -27,6 +27,7 @@ fman@1a00000 {
>  		reg = <0xf0000 0x1000>;
>  		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
>  		pcsphy-handle = <&pcsphy6>;
> +		status = "disabled";
>  	};
>  
>  	mdio@f1000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
> index 6fc5d2560057..3fc43b0faa3f 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
> @@ -27,6 +27,7 @@ fman@1a00000 {
>  		reg = <0xf2000 0x1000>;
>  		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
>  		pcsphy-handle = <&pcsphy7>;
> +		status = "disabled";
>  	};
>  
>  	mdio@f3000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
> index 4e02276fcf99..fa16a914e53b 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy0>;
> +		status = "disabled";
>  	};
>  
>  	mdio@e1000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
> index 0312fa43fa77..8813d433d891 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy1>;
> +		status = "disabled";
>  	};
>  
>  	mdio@e3000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
> index af2df07971dd..65663d449430 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy2>;
> +		status = "disabled";
>  	};
>  
>  	mdio@e5000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
> index 4ac98dc8b227..8ae370f11518 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy3>;
> +		status = "disabled";
>  	};
>  
>  	mdio@e7000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
> index bd932d8b0160..3ff5a97e0a58 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy4>;
> +		status = "disabled";
>  	};
>  
>  	mdio@e9000 {
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
> index 7de1c5203f3e..4e9bd0b25499 100644
> --- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
> @@ -26,6 +26,7 @@ fman@1a00000 {
>  		fsl,fman-ports = <&fman0_rx_0x0d &fman0_tx_0x2d>;
>  		ptp-timer = <&ptp_timer0>;
>  		pcsphy-handle = <&pcsphy5>;
> +		status = "disabled";
>  	};
>  
>  	mdio@eb000 {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
