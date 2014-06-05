From: andy@aeruder.net (Andrew Ruder)
Date: Thu, 5 Jun 2014 05:01:22 +0200
Subject: PXA 2xx devictree port and clock infrastructure
In-Reply-To: <87zji3cr3d.fsf@free.fr>
References: <87zji3cr3d.fsf@free.fr>
Message-ID: <20140605030122.GA27682@og3k>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 03:02:14PM +0200, Robert Jarzmik wrote:
> I'm playing with devicetree to port the mioa701 machine code to devicetree (or
> rather to eliminate the mioa701 machine code).

Sorry for the late response, but for what its worth I have an entire
line of boards running on device-tree for PXA270.  Even better, they are
FIT booted out of U-Boot so I can use the same kernel on at least 4 (and
growing) different pieces of hardware.  Some of the patches are in
really sorry shape, but I'm just now trying to get them cleaned up for
inclusion (just sent the first wave to netdev today).

Unfortunately the few major issues I have is:

  a.) I simply changed the names of the clocks to match to get past that
  part (didn't create the clock driver stuff).

  b.) I'm currently using a hacky patch to pxamci.c to set the DMA
  channel since I'm not yet using the DMA patches that have been posted
  here.

  c.) Several other little things in mach-pxa/ to get the thing going
  that I haven't totally figured out yet.

I've gone ahead and pushed everything up to my personal github
repository in the meantime - it will probably be rebased frequently
while I get things cleaned up.

http://github.com/aeruder/linux

elecsys-v3.14/master - merges all of below
elecsys-v3.14/dm9000 - several patches for dm9000 network against v3.14
elecsys-v3.14/dt-dma-hack - the aforementioned pxamci.c patch
elecsys-v3.14/hwirq-vs-irq - issue regarding ISA interrupts
elecsys-v3.14/misc - this is where some of the changes get really bad
and still lots of cleanup to do
elecsys-v3.14/trivial - lots of small cleanups - several to device-tree
                        stuff
elecsys-v3.14/zx-support - stuff to support my specific boards (the
                           device trees and configs)

- Andy
