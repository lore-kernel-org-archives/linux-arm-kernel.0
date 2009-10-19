From: schen@mvista.com (Steve Chen)
Date: Mon, 19 Oct 2009 07:28:08 -0500
Subject: Ext3 is supported not well at 2.6.28 for external SD card	removal
In-Reply-To: <4ADC234F.8070505@gmail.com>
References: <4ADBFB5B.9030200@gmail.com>
	<200910190759.11591.marek.vasut@gmail.com> <4ADC1943.1090306@gmail.com>
	<20091019080128.GC11449@pengutronix.de>  <4ADC234F.8070505@gmail.com>
Message-ID: <1255955288.3153.219.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-19 at 16:29 +0800, Peter Chen wrote:
> Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Mon, Oct 19, 2009 at 03:46:11PM +0800, Peter Chen wrote:
> >> Marek Vasut wrote:
> >>> Dne Po 19. ??jna 2009 07:38:35 Peter Chen napsal(a):
> >>> You popped the card out without unmounting the filesystem I guess ?
> >> We don't execute umount at 2.6.27/23 either, and it has little error:
> >> [   32.541208] Buffer I/O error on device mmcblk1p1, logical block 0
> >> [   32.544784] lost page write due to I/O error on mmcblk1p1
> >>
> >> Besides, the remove card is ok after suspend at 2.6.27 and 2.6.23.
> >>
> >> Usually, the remove card(ext3) without umount is forbiddon or not?
> > You shouldn't remove the card without unmounting first.  And you should
> > unmount with .23 and .27, too.  Just because these kernels don't wail it
> > doesn't mean you cannot loose data.
> > 
> > Best regards
> > Uwe
> > 
> I find the system still will be deadlock if i use sync before go to suspend.
> I wonder why system will go to deadlock even there is not card at slot.
> 

Is this specific to ext3?  Does it happen to other file systems such as
xfs?

Regards,

Steve
