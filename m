From: caglarakyuz@gmail.com (Caglar Akyuz)
Date: Tue, 19 Jan 2010 16:35:41 +0200
Subject: Kernel Start-up Time
In-Reply-To: <20100119110408.GB9187@sig21.net>
References: <201001181010.01975.caglarakyuz@gmail.com>
	<20100119110408.GB9187@sig21.net>
Message-ID: <201001191635.41944.caglarakyuz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 January 2010 01:04:08 pm Johannes Stezenbach wrote:
> On Mon, Jan 18, 2010 at 10:10:01AM +0200, Caglar Akyuz wrote:
> > While measuring Linux start-up time, I see that printing version string
> > in "start_kernel" takes ~1.3 seconds. I guess this is the time between
> > from "bootloader jumping to uImage" and "printing version string in
> > generic start_kernel code". Relevant part of my boot log is attached.
> >
> > My question: is it normal this 1.3 sec init time? My system is 297 MHZ
> > arm926ej-s with a 162MHZ DDR2 memory.
> >
> > [    4.700896] Starting kernel ...
> > [    4.702971]
> > [    5.966039] [    0.000000] Linux version
> > 2.6.30-davinci1-06079-g4e73fae-
> 
> Actually printk goes to a buffer which is output only after the
> serial console has been initialized (unless you use some
> kind of early printk).  So to find out what causes the delay
> look further down in your kernel messages, and look at the kernel
> timestamps not the ptx_ts ones.
> 

I thought early prink was magically handling all this stuff. Passing 
'earlyprintk' option to the kernel revealed correct numbers.

Caglar

> 
> HTH
> Johannes
> 
