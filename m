From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Mar 2015 11:37:00 +0100
Subject: [PATCH RFC] ARM: BCM5301X: Add /device_id property including
 device ID string
In-Reply-To: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
References: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
Message-ID: <20150330103659.GD17971@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For DT patches, please send to devicetree at vger.kernel.org; this affects
more than just ARM.

On Sun, Mar 29, 2015 at 11:14:48PM +0100, Rafa? Mi?ecki wrote:
> Device vendors often assign IDs to their devices to allow comparing
> firmware image with device model. This is required to prevent users
> from flashing incompatible image and soft-bricking device.
> Add device_id property to DTs to allow user space (and optionally
> bootloader) verifying firmware images.

This sounds like exactly what the "model" property is meant to be (per
ePAPR) -- a string that specifices the manufacturer's model number of
the device, ideally in "manufacturer,model" format.

> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> Hi guys,
> 
> I think my commit message explains pretty well what I'm trying to do,
> however I'm not sure if I'm using a right place for that.
> I also didn't document this news property, as I can't find a place
> where root-properties are currenty described. Is there any such place?
> I couldn't find a file describing e.g. "model" property.

It's documented in ePAPR (embedded power achitecture platform
requirements), and possibly earlier device tree and/or open firmware
documents.

Unfortuantely ePAPR is now behind a registration page on power.org, and
I'm not sure where most other documents live (playground.sun.com and
other sources are dead).

Mark.

> ---
>  arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts    | 1 +
>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts    | 1 +
>  arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts | 1 +
>  arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts    | 1 +
>  arch/arm/boot/dts/bcm4709-netgear-r8000.dts    | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> index 8b62836..9d2fac4 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "asus,rt-ac68u", "brcm,bcm4708";
>  	model = "Asus RT-AC68U (BCM4708)";
> +	device_id = "RT-AC68U";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200";
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> index 2ed9e57..98c8d63 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "netgear,r6250v1", "brcm,bcm4708";
>  	model = "Netgear R6250 V1 (BCM4708)";
> +	device_id = "U12H245T00_NETGEAR";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200";
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> index 3991042..c43173a 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "netgear,r6300v2", "brcm,bcm4708";
>  	model = "Netgear R6300 V2 (BCM4708)";
> +	device_id = "U12H240T00_NETGEAR";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200";
> diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> index 0ee85ea..876e2c0 100644
> --- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> +++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "asus,rt-n18u", "brcm,bcm47081", "brcm,bcm4708";
>  	model = "Asus RT-N18U (BCM47081)";
> +	device_id = "RT-N18U";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200";
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> index ea26dd3..129df9a 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "netgear,r8000", "brcm,bcm4709", "brcm,bcm4708";
>  	model = "Netgear R8000 (BCM4709)";
> +	device_id = "U12H315T00_NETGEAR";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,115200";
> -- 
> 1.8.4.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
