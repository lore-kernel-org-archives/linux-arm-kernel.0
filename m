From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 May 2013 10:10:16 -0700
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <20130520095447.GR21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
Message-ID: <20130520171012.GG10378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130520 03:00]:
> On Fri, May 17, 2013 at 12:17:51PM -0700, Tony Lindgren wrote:
> > We can now boot with device tree. If you don't want to update u-boot,
> > you can boot with appended DTB with the following instructions:
> > 
> > 1. Make sure you have the appended DTB support in .config
> > 
> >    CONFIG_ARM_APPENDED_DTB=y
> >    CONFIG_ARM_ATAG_DTB_COMPAT=y
> >    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
> > 
> > 2. Build the zImage
> > 
> >    $ ARCH=arm CROSS_COMPILE=... make zImage
> > 
> > 3. Build the device tree blobs
> > 
> >    $ ARCH=arm CROSS_COMPILE=... make dtbs
> > 
> > 4. Append the dtb to zImage
> > 
> >    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-sdp.dtb > /tmp/appended
> > 
> > 5. Use mkimage to produce the appended device tree uImage
> > 
> >    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
> >      -n "Linux" -d /tmp/appended /tmp/uImage
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Okay, I'm removing the 4430SDP from the boot test system once this goes
> in, because this will mean rewriting the build system to cope with this
> stuff.

OK, up to you. At least I check the results of your build system
occasionally though.

I know people don't want to have more uImage handling in the kernel,
but maybe we could add handling for board specific uImage targets
for compability?

Maybe something like dtbname.uImage-dtba:

$ make omap4-sdp.uImage-dtba

And then that would take care of steps 3 - 5 automatically?

Of course the alternative is to update u-boot, but that's not always
possible for some legacy boards.

Regards,

Tony
