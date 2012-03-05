From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 14:46:14 +0000
Subject: [PATCH v2 7/7] Document: devicetree: add OF documents for arch-mmp
In-Reply-To: <1330950111-30797-8-git-send-email-haojian.zhuang@marvell.com>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201203051446.14600.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 March 2012, Haojian Zhuang wrote:
> Add OF support in Document/devicetree directory.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

One question for Benoit, Grant or Rob:

> +Required properties:
> +- compatible: should be "mrvl,sa1100-rtc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should be two. The first interrupt number is the rtc alarm
> +  interrupt and the second interrupt number is the rtc hz interrupt.
> +- interrupt-names: Assign name of irq resource.
> +
> +Example:
> +	rtc: rtc at d4010000 {
> +		compatible = "mrvl,mmp-rtc";
> +		reg = <0xd4010000 0x1000>;
> +		interrupts = <5>, <6>;
> +		interrupt-name = "rtc 1Hz", "rtc alarm";
> +	};

When the binding for a device lists the interrupt-names property, should it
also list the specific values for it? This one says that which ones they are,
but I think we should actually mandate the exact string in the binding if
we want to allow drivers to get the resource by its name.

	Arnd
