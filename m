From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 1 Jun 2017 22:37:47 -0700
Subject: [PATCH v5 04/11] arm64: dts: Initial DTS files for Broadcom
 Stingray SOC
In-Reply-To: <1495790704-2438-5-git-send-email-anup.patel@broadcom.com>
References: <1495790704-2438-1-git-send-email-anup.patel@broadcom.com>
 <1495790704-2438-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <abeca9ac-487c-b6dc-1397-4134b0442909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/26/2017 02:24 AM, Anup Patel wrote:
> The Broadcom Stingray SoC is a new member in Broadcom iProc
> SoC family.
> 
> This patch adds initial DTS files for Broadcom Stingray SoC
> and two of its reference boards (bcm958742k and bcm958742t).
> 
> We have lot of reference boards and large number of devices
> in Broadcom Stingray SoC so eventually we will have quite
> a few DTS files for Stingray. To tackle, we have added a
> separate directory for Stingray DTS files.

So I was going to apply this, but...


> +	scr {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x61000000 0x05000000>;

So you corrected the ranges property here...

> +
> +		gic: interrupt-controller at 63c00000 {

but you kept the original unit address here, which does not match the
reg property, could you fix that through your entire submission?

> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			interrupt-controller;
> +			reg = <0x02c00000 0x010000>, /* GICD */
> +			      <0x02e00000 0x600000>; /* GICR */

> +	hsls {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x68900000 0x17700000>;

Same here.

> +
> +		uart0: uart at 68a00000 {
> +			device_type = "serial";
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x00100000 0x1000>;

and here and all other sub nodes
-- 
Florian
