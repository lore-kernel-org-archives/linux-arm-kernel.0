From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 31 Aug 2009 11:24:58 -0500
Subject: Beagleboard B6 woes
In-Reply-To: <20090831093810.GE4927@fitfioullt278>
References: <20090831093810.GE4927@fitfioullt278>
Message-ID: <4A9BF95A.8000404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mikko Rapeli wrote:
> Hello,
> 
> I'd like to test out newer kernel on a Beagleboard B6 but latest
> trees from Linus, linux-omap and linux-omap/for-next seem to be failing at
> early boot [1] with omap3_beagle_defconfig.
> 
> Some bisecting shows that ARM_UNWIND broke something in the defconfig since
> kernels before adf8b37bafc1495393201a2ae4235846371870d0 "[ARM] 5386/2:
> unwind: Add Makefile and Kconfig entries for ARM stack unwinding" work.

If UNWIND is breaking it, then the most likely cause is that you are 
using an older toolchain, such as code-sourcery 2007q3. If you are using 
  2007q3, upgrade to a 2008 or 2009 release. More details here:

http://marc.info/?l=linux-omap&m=124175324604568&w=2

> On the other hand, setting ARM_UNWIND to n which falls back to FRAME_POINTERs
> work until 84e250ffa76dddc1bad84e04248a27f442c25986 "musb: proper hookup to 
> transceiver drivers".

You could trying enabling "CONFIG_TWL4030_USB" to see if this helps.

Jon
