From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 16 Jul 2012 09:00:24 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120715144935.GB2429@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
Message-ID: <20483.48136.37651.182431@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Fri, Jul 13, 2012 at 11:21:09AM +0200, Lothar Wa?mann wrote:
> > Shawn Guo writes:
> > > Hi Lothar,
> > > 
> > > On Mon, Jul 09, 2012 at 03:04:53PM +0200, Lothar Wa?mann wrote:
> > > > This doesn't work at least because the pins that are used for PHY
> > > > strap options need to be reconfigured for their FEC functionality
> > > > after releasing the PHY reset. But even after adding the missing
> > > > reconfiguration the ethernet PHY does not work.
> > > > 
> > > Can you please test the branch below to see if ethernet PHY works?
> > > 
> > No. See bootlog below.
> > 
> Thanks for testing, Lothar.  But from the boot log below, the kernel
> did a non-DT boot rather than a boot from device tree.  More on this
>
I compiled the kernel with DT support, but just the TX28 board
selected. When selecting an additional i.MX28 board, the kernel
doesn't boot at all any more. Does this mean in order to get a kernel
with DT support one has to select at least two different platforms?
Is this behaviour intended?

> below.  But does that mean ethernet PHY does not work even on non-DT
> kernel right now?
> 
Seems so.

> > The following patch is required for the kernel to build:
> 
> Yes, Marek has reported that.  But I'm not so fond of fixing it right
> away like that, since mxs_defconfig has it enabled with board file
> support and does not expose the problem.
> 
> Instead, I would really like to remove those board files with equivalent
> device tree support, and build in mach-mxs.c and ocotp.c all the time.
> 
OK.

> This line tells that the kernel is doing a traditional non-DT boot.
> If the kernel boots from device tree, you should see the following line
> instead.
> 
> Machine: Freescale i.MX28 (Device Tree), model: Ka-Ro electronics TX28 module
> 
> I'm not sure if you have your bootloader passes dtb to kernel or use
> append-dtb approach.  In the later case, here are the brief
> instructions.
> 
> - Enable CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> - Build kernel
> - make ARCH=arm imx28-tx28.dtb
> - cat arch/arm/boot/zImage arch/arm/boot/imx28-tx28.dtb > arch/arm/boot/zImage_dtb
> - Boot zImage_dtb like you boot zImage as usual
> 
I'm using the appended DTB approach, and have done exactly this except
for using uImage rather than zImage.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
