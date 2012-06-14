From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jun 2012 09:39:04 +0100
Subject: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
In-Reply-To: <20120614081758.GA19648@mail.gnudd.com>
References: <201206140804.39083.arnd@arndb.de>
 <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
 <20120614081758.GA19648@mail.gnudd.com>
Message-ID: <4FD9A328.9080000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/12 09:17, Alessandro Rubini wrote:
>> You change only one half of ux500 here: the part where the device
>> gets defined statically, but not not the definition in the
>> device-tree.
>
> Yes, I'm aware. That's why I added Lee Jones as Cc:, on Linusw's
> suggestion.  Lee told me to go ahead and he'll fix the DT stuff.

I did?

I have already DT:ed this driver. There are 3 patches on the MLs currently.

> [PATCH 1/3] i2c: Add Device Tree support to the Nomadik I2C driver
> [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree for DB8500 based devices
> [PATCH 3/3] Documentation: Device Tree binding information for i2c-nomadik driver

I'm more than happy for you to base your patches on these and make the 
necessary changes. Off hand, I think the only changes you'll need to 
make is the probing from DT itself.

So something like:

> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -449,7 +449,7 @@
>                 };
>
>                 i2c at 80004000 {
> -                       compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
> +                       compatible = "st,nomadik-i2c", "arm,primecell";
>                         reg = <0x80004000 0x1000>;
>                         interrupts = <0 21 0x4>;
>                         #address-cells = <1>;

... for each of the controllers.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
