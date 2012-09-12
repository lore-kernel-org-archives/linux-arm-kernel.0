From: davidb@codeaurora.org (David Brown)
Date: Wed, 12 Sep 2012 09:09:00 -0700
Subject: [PATCH 8/9] ARM: msm: Add DT support for 8960
In-Reply-To: <1346873339-10927-9-git-send-email-sboyd@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
 <1346873339-10927-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120912160900.GB21878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 12:28:58PM -0700, Stephen Boyd wrote:

> diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
> +
> +	intc: interrupt-controller at 02000000 {
> +		compatible = "qcom,msm-qgic2";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = < 0x02000000 0x1000 >,
> +		      < 0x02002000 0x1000 >;
> +	};

> +	timer at 0200a004 {
	...
> +	timer at 0200a024 {

Likewise here, the leading zeros need to be removed on the names.  I
can also take care of this one when I pull it in.

David


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
