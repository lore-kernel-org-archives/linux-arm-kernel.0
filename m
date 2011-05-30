From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 May 2011 14:23:47 -0600
Subject: [PATCH] ARM: Xilinx: Adding zynq platform support
In-Reply-To: <BANLkTikjMYUCXgBN3UKjpzEg68qOqOHv5A@mail.gmail.com>
References: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
	<alpine.LFD.2.00.1105241435550.3207@xanadu.home>
	<BANLkTi=hCpCbNzi1ZiKmGnbhmCG2Ce=EkA@mail.gmail.com>
	<201105261559.41993.arnd@arndb.de>
	<BANLkTikjMYUCXgBN3UKjpzEg68qOqOHv5A@mail.gmail.com>
Message-ID: <20110530202347.GC32035@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 05:47:35PM +0800, Barry Song wrote:
> 2011/5/26 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 25 May 2011, Grant Likely wrote:
> >>
> >> As per discussion attached below. ?Please pull this tree adding device
> >> tree support to ARM, plus some other minor device tree changes.
> >
> > Hi Grant and Linus,
> >
> > There is also the new Xilinx zynq subarchitecture pending that depends
> > on this, see below. Should we also include that right away, in order
> > to have an example for other platforms? I think the code is clean
> > enough and it would be good to have.
> >
> > ? ? ? ?Arnd
> >
> > 8<---------
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > The 1st board support is minimal to get a system up and running
> > on the Xilinx platform.
> >
> > This platform reuses the clock implementation from plat-versatile, and
> > it depends entirely on CONFIG_OF support. ?There is only one board
> > support file which obtains all device information from a device tree
> > dtb file which is passed to the kernel at boot time.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > [john.linn at xilinx.com: Reverted dependency on of_irq_domain patches]
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> is there a whole complete tree for zynq? i'd like to refer. thanks! as
> i am moving csr prima2 to device tree, we need to change so many
> codes. i hope we can follow what the way zynq is doing.

It is in linux-next.  Hopefully we'll get it merged into the arm
subarch maintainer tree early in this cycle.

You can also look at arch/powerpc/platforms/* to see examples of how
to work with the DT.  I'm also working on some howto documentation for
doing DT work.

g.
