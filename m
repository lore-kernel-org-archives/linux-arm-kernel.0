From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 07:50:43 +0000
Subject: [PATCH V4 1/5] ARM: add infra-structure for BCM2835 and Raspberry
 Pi
In-Reply-To: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
References: <1347597684-30805-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209140750.44039.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> The BCM2835 is an ARM SoC from Broadcom. This patch adds very basic
> support for this SoC.
> 
> http://www.broadcom.com/products/BCM2835
> http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pd

Just looked at that document. Funny how they actually put details about
the kernel implementation (the static mapping address) into a hardware
manual.

> Note that the documentation in the latter .pdf assumes the MMU setup
> that's used on the "VideoCore" companion processor, and does not document
> physical peripheral addresses. Subtract 0x5e000000 to obtain the physical
> addresses.

This had escaped me so far. I think we should put this into the device tree
so that the representation of devices in the .dts file matches the one in
the manual, like this

	vc-bus {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x20000000 0x7e000000 0x02000000>;

		other devices {

		};
	};


	Arnd
