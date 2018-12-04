Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DC220878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LW6Jsby0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DC220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xv/I39uQ6F8u+8mOY/qgela1XzsDBNxGZ5eXvnbzcJM=; b=LW6Jsby0/sRzS/
	X8SESJi604zgEK7V5ZpN9IL+eCbNCnAOjHjXMHhEROidSNJRwzQMXGDR5pWNM2R3dWx2itAIcpx4N
	ZV3UJPrlCygTRlV/RAWnrTKju61jwQQJx1qA6yatRSk+1evPkrqC4h0Ohfgy8PwFRJsQHvHH+2nU/
	ZOktzq44JrcaQyL4G4bLwL1gXv1+JV3/5x5JrpmxkrDivuWtK68XqB/vT+kmN8PyfS6j5OoTQXqjY
	vbLc7H2LH186lsncfukkK2jN1mPXNd9sl45fd45dp6brjZHkX0V9s283CKe2Op3W0hsRtK1t6KXjK
	IpzCl1Zp6KIPLy5KRpqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUA4t-00037K-Co; Tue, 04 Dec 2018 12:45:27 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUA4q-0002u6-GI
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 12:45:26 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2018 04:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; d="scan'208";a="126960776"
Received: from kuha.fi.intel.com ([10.237.72.189])
 by fmsmga001.fm.intel.com with SMTP; 04 Dec 2018 04:45:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 14:45:08 +0200
Date: Tue, 4 Dec 2018 14:45:08 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Yu Chen <chenyu56@huawei.com>
Subject: Re: [PATCH v1 12/12] dts: hi3660: Add support for usb on Hikey960
Message-ID: <20181204124508.GB10657@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-13-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-13-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_044524_591885_F3B565F7 
X-CRM114-Status: GOOD (  20.02  )
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
 Binghui Wang <wangbinghui@hisilicon.com>, suzhuangluan@hisilicon.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wei Xu <xuwei5@hisilicon.com>, kongfei@hisilicon.com,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 11:45:15AM +0800, Yu Chen wrote:
> This patch adds support for usb on Hikey960.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 56 ++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 72 +++++++++++++++++++++++
>  2 files changed, 128 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c98bcbc8dfba..066c558154ea 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	model = "HiKey960";
> @@ -196,6 +197,28 @@
>  			method = "smc";
>  		};
>  	};
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960_usb";
> +		typec-vbus-gpios = <&gpio25 2 0>;
> +		typc-vbus-enable-val = <1>;
> +		otg-switch-gpios = <&gpio25 6 0>;
> +		hub-vdd33-en-gpios = <&gpio5 6 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				device_type = "usb-role-switch";
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +	};
> +
>  };
>  
>  /*
> @@ -526,6 +549,39 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";
> +		reg = <0x4e>;
> +		status = "ok";
> +		interrupt-parent = <&gpio27>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +		};
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				device_type = "usb-role-switch";

device_type is deprecated, no?

In any case, I don't think we can use the endpoint subnode for
matching. To play it safe, I think we should use the remote port
parent for matching. See below..

> +				remote-endpoint = <&dwc3_role_switch>;
> +			};
> +		};
> +	};
> +
>  	adv7533: adv7533@39 {
>  		status = "ok";
>  		compatible = "adi,adv7533";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a88c65..e6583bd7efdb 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -349,6 +349,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		pmctrl: pmctrl@fff31000 {
> +			compatible = "hisilicon,hi3660-pmctrl", "syscon";
> +			reg = <0x0 0xfff31000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		pmuctrl: crg_ctrl@fff34000 {
>  			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
>  			reg = <0x0 0xfff34000 0x0 0x1000>;
> @@ -1122,5 +1128,71 @@
>  				};
>  			};
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +		};
> +
> +		usb_phy: usb-phy {
> +			compatible = "hisilicon,hi3660-usb-phy";
> +			#phy-cells = <0>;
> +			hisilicon,pericrg-syscon = <&crg_ctrl>;
> +			hisilicon,pctrl-syscon = <&pctrl>;
> +			hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> +			hisilicon,eye-diagram-param = <0x22466e4>;
> +		};
> +
> +		usb3: hisi_dwc3 {
> +			compatible = "hisilicon,hi3660-dwc3";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +
> +			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			assigned-clock-rates = <229000000>;
> +			resets = <&crg_rst 0x90 8>,
> +				 <&crg_rst 0x90 7>,
> +				 <&crg_rst 0x90 6>,
> +				 <&crg_rst 0x90 5>;
> +
> +			dwc3: dwc3@ff100000 {
> +				compatible = "snps,dwc3";

Can we use the compatible property?

        compatible = "snps,dwc3", "usb-role-switch"

> +				reg = <0x0 0xff100000 0x0 0x100000>;
> +				interrupts = <0 159 4>, <0 161 4>;
> +				phys = <&usb_phy>;
> +				phy-names = "usb3-phy";
> +				dr_mode = "otg";
> +				maximum-speed = "super-speed";
> +				phy_type = "utmi";
> +				snps,dis-del-phy-power-chg-quirk;
> +				snps,lfps_filter_quirk;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +				snps,tx_de_emphasis_quirk;
> +				snps,tx_de_emphasis = <1>;
> +				snps,dis_enblslpm_quirk;
> +				snps,gctl-reset-quirk;
> +
> +				port {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					dwc3_role_switch: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&rt1711h_ep>;
> +					};
> +
> +					dwc3_role_switch_notify: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&hikey_usb_ep>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> -- 
> 2.15.0-rc2

-- 
heikki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
