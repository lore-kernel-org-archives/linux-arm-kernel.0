From: caglarakyuz@gmail.com (Caglar Akyuz)
Date: Tue, 19 Jan 2010 10:40:01 +0200
Subject: Kernel Start-up Time
In-Reply-To: <4B54B901.2000905@googlemail.com>
References: <201001181010.01975.caglarakyuz@gmail.com>
	<1263829143.3207.34.camel@linux-1lbu>
	<4B54B901.2000905@googlemail.com>
Message-ID: <201001191040.01759.caglarakyuz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 January 2010 09:39:45 pm Dirk Behme wrote:
> On 18.01.2010 16:39, Steve Chen wrote:
> > On Mon, 2010-01-18 at 10:54 +0200, Caglar Akyuz wrote:
> >> On Monday 18 January 2010 10:39:27 am Tonyliu wrote:
> >>> Caglar Akyuz wrote:
> >>>> Hello,
> >>>>
> >>>> While measuring Linux start-up time, I see that printing version
> >>>> string in "start_kernel" takes ~1.3 seconds. I guess this is the time
> >>>> between from "bootloader jumping to uImage" and "printing version
> >>>> string in generic start_kernel code". Relevant part of my boot log is
> >>>> attached.
> >>>>
> >>>> My question: is it normal this 1.3 sec init time? My system is 297 MHZ
> >>>> arm926ej-s with a 162MHZ DDR2 memory.
> >>>
> >>> It depends on where you start to measure it?
> >>>      Starting from when power is turned on.
> >>>      Starting from when the first instruction executes.
> >>>      Start from the bootloader tries to load the kernel image.
> >>> ...
> >>
> >> That number is relative, it is the time passing from u-boot jumping to
> >> kernel and kernel starting.
> >>
> >>> I think this type of mearsurement  makes no much sense to you, since
> >>> normally
> >>> people want to know
> >>>     When the kernel loads userspace or
> >>>      When the first app starts to run.
> >>
> >> First application starts in ~4 second. This time consists of:
> >>
> >> 1) ~1 sec for application start.
> >> 2) ~1 sec for userspace init, mouting filesys, etc.
> >> 3) ~1 sec for kernel init for drivers and machine specific code
> >> 4) ~1 sec for the aforementioned delay.
> >>
> >>> These are more meaningful for specific product.
> >>
> >> It is number 4 that I'm trying to understand. I think it has the highest
> >> chance to contribute to end goal. But if it is as expected, then no room
> >> for optimization there.
> >
> > Well, "no room for optimization" is a pretty strong statement.  Last
> > year Monta Vista demo the 1 second boot.
> >
> > http://mvista.com/press_release_detail.php?fid=news/2009/Ultra-fast-boot.
> >html&d=
> >
> > I realized that it is a different and faster processor, but I'm pretty
> > sure there are plenty of places you can trim the boot time.   It is a
> > matter of time and effort.
> 
> Maybe
> 
> http://elinux.org/Boot_Time
> 
> could help you a little.
> 
> Best regards
> 
> Dirk
> 

Thanks Dirk,

That page was my starting point and following suggestions there I gained more 
than 10 seconds.

Unfortunately, my bottleneck is not mentioned in any of places. Either 
something is wrong with my setup or this is normal. I'm trying to understand 
which is the case.

Best regards,
Caglar
