From: alex.aring@gmail.com (Alexander Aring)
Date: Tue, 22 Dec 2015 15:26:49 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <874mfbflj3.fsf@eliezer.anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <20151218100826.GB1145@omega> <20151220221158.GA6416@omega>
 <874mfbflj3.fsf@eliezer.anholt.net>
Message-ID: <20151222142643.GB29335@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 03:07:44PM -0800, Eric Anholt wrote:
...
> >
> > But still getting this panic, your patches does not contain some
> > defconfig, so I still try to figure out what I need to enable to get it
> > working. Maybe it is some missing config entry which should be enabled.
> >
> > But, for me it looks like some devicetree issue, because of_iomem returns
> > NULL, at [0]. Don't know what I am doing wrong.
> 
> My best guess is that since you're not using U-Boot, the firmware's
> mangling the DT in some way that breaks us.  Notably, in my current
> firmware checkout, set /soc/ranges to just the first entry that we're
> using, which would break the mapping.  However,
> rpi/rpi-4.4.y:arch/arm/boot/dts/bcm2709.dtsi uses the same /soc/ranges
> setup that we do, so I'm not sure what's going on.  Perhaps
> bcm2709_io_desc[]'s initialization covers for it?

I boot here with two different bootloaders, both ends in the same panic.

Finally I figured out if I do a user/kernel split (2G/2G) then the
issue is gone.

Later I need to enable "CONFIG_HAVE_ARM_ARCH_TIMER" so the kernel
doesn't hang forever.

After finally booting the RPi2 I get several messages of:

unexpected IRQ trap at vector 00

while typing _one_ character over uart.

Can you provide somehow your RPi2 kernelconfig?

- Alex
