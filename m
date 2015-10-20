From: eric@anholt.net (Eric Anholt)
Date: Tue, 20 Oct 2015 01:53:38 -0700
Subject: [PATCH RFT] ARM: bcm2835: dt: fix memory of Raspberry Pi B+
In-Reply-To: <1444942124-23122-1-git-send-email-stefan.wahren@i2se.com>
References: <1444942124-23122-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <8737x5ncod.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since the Raspberry Pi models differ in memory amount we
> better define it at board level. After that we are able
> to fix the memory node of the Raspberry Pi B+ .
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi-b.dts      |    4 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi       |    4 ----
>  5 files changed, 16 insertions(+), 4 deletions(-)
>
> This patch is only compile-tested.
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> index b2bff43..c08dff2 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
> @@ -5,6 +5,10 @@
>  	compatible = "raspberrypi,model-a-plus", "brcm,bcm2835";
>  	model = "Raspberry Pi Model A+";
>  
> +	memory {
> +		reg = <0 0x10000000>; /* 256 MB */
> +	};
> +
>  	leds {
>  		act {
>  			gpios = <&gpio 47 0>;
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> index 668442b..b4a1e56 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> @@ -5,6 +5,10 @@
>  	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
>  	model = "Raspberry Pi Model B+";
>  
> +	memory {
> +		reg = <0 0x20000000>; /* 512 MB */
> +	};
> +
>  	leds {
>  		act {
>  			gpios = <&gpio 47 0>;
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> index eab8b591..e6ccfab 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
> @@ -5,6 +5,10 @@
>  	compatible = "raspberrypi,model-b-rev2", "brcm,bcm2835";
>  	model = "Raspberry Pi Model B rev2";
>  
> +	memory {
> +		reg = <0 0x10000000>; /* 256 MB */
> +	};
> +
>  	leds {
>  		act {
>  			gpios = <&gpio 16 1>;
> diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
> index ff6b2d1..bfd917c 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
> @@ -5,6 +5,10 @@
>  	compatible = "raspberrypi,model-b", "brcm,bcm2835";
>  	model = "Raspberry Pi Model B";
>  
> +	memory {
> +		reg = <0 0x10000000>; /* 256 MB */
> +	};
> +
>  	leds {
>  		act {
>  			gpios = <&gpio 16 1>;

Seems like a good idea.  The closed firmware passes us an edited
devicetree with good memory fields, but I don't think U-Boot is up to it
if you chainload it.

However, isn't the rpi-b-rev2 the 512MB variant of the rpi-b?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/2a404502/attachment.sig>
