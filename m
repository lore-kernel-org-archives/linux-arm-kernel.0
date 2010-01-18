From: caglarakyuz@gmail.com (Caglar Akyuz)
Date: Mon, 18 Jan 2010 10:54:59 +0200
Subject: Kernel Start-up Time
In-Reply-To: <4B541E3F.9040205@windriver.com>
References: <201001181010.01975.caglarakyuz@gmail.com>
	<4B541E3F.9040205@windriver.com>
Message-ID: <201001181054.59214.caglarakyuz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 January 2010 10:39:27 am Tonyliu wrote:
> Caglar Akyuz wrote:
> > Hello,
> >
> > While measuring Linux start-up time, I see that printing version string
> > in "start_kernel" takes ~1.3 seconds. I guess this is the time between
> > from "bootloader jumping to uImage" and "printing version string in
> > generic start_kernel code". Relevant part of my boot log is attached.
> >
> > My question: is it normal this 1.3 sec init time? My system is 297 MHZ
> > arm926ej-s with a 162MHZ DDR2 memory.
> 
> It depends on where you start to measure it?
>     Starting from when power is turned on.
>     Starting from when the first instruction executes.
>     Start from the bootloader tries to load the kernel image.
> ...

That number is relative, it is the time passing from u-boot jumping to kernel 
and kernel starting.

> I think this type of mearsurement  makes no much sense to you, since
> normally
> people want to know
>    When the kernel loads userspace or
>     When the first app starts to run.
> 

First application starts in ~4 second. This time consists of:

1) ~1 sec for application start.
2) ~1 sec for userspace init, mouting filesys, etc.
3) ~1 sec for kernel init for drivers and machine specific code
4) ~1 sec for the aforementioned delay.
 
> These are more meaningful for specific product.
> 

It is number 4 that I'm trying to understand. I think it has the highest 
chance to contribute to end goal. But if it is as expected, then no room for 
optimization there.

Regards,
Caglar
