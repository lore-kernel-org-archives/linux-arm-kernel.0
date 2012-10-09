From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 9 Oct 2012 13:54:05 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <50739074.8000001@wwwdotorg.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <50739074.8000001@wwwdotorg.org>
Message-ID: <20121009115405.GC28817@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 08:48:20PM -0600, Stephen Warren wrote:
> On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> > BCM476x's minimal infrastructure, Kernel's great reuse.
> 
> > Index: b/arch/arm/boot/dts/bcm476x.dtsi
> 
> > +	chosen {
> > +		bootargs = "earlyprintk";
> > +	};
> 
> > Index: b/arch/arm/configs/bcm476x_defconfig
> 
> > +CONFIG_CMDLINE="root=/dev/mmcblk0p2 ro console=ttyAMA1,115200 rootwait init=/bin/bash"
> > +CONFIG_CMDLINE_FROM_BOOTLOADER=y
> 
> I'm not sure you need to specify a default command-line in both those
> places. I would be inclined to leave out the root= option as well; it's
> pretty specific to however the user's SD card was partitioned, so there
> could be quite some variation there I think? Oh, especially since I
> think you said there was no SD driver yet anyway?

Right, I'll drop both. Thanks.

Dome
