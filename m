From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Dec 2012 20:09:28 +0100
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121213174032.GB14619@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121212165833.6a35a6ec@skate>
 <20121212215138.GC11530@obsidianresearch.com>
 <201212131458.55020.arnd@arndb.de>
 <20121213174032.GB14619@obsidianresearch.com>
Message-ID: <20121213200928.2f70c125@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 13 Dec 2012 10:40:32 -0700, Jason Gunthorpe wrote:

> > If the IntA to IntD lines are all on the same host interrupt, you
> > might only need one line above and make the map-mask all zeroes.
> 
> Well, no that is where the existing stuff goes wrong..
> 
> Each of the four INTx's on each port need a dedicated linux interrupt
> vector. Sharing interrupts is bad. The chip has dedicated cause and
> mask bits so there is no reason to share.
> 
> To do this the pex driver has to allocate 4 irq descs per port, setup
> a generic irq chip for the driver, use irq_set_chained_handler on the
> summary interrupt in the main cause register and then decode the INTx
> bits in the chained handler function. This is very straightforward and
> very much worth doing.

Yes, this is definitely part of my plans. For now, I kept the existing
PCIe implementation of Kirkwood and al with regard to IRQs, but when I
read more about INT{A,B,C,D} and the cause register that is available,
I immediately noted in my TODO-list: use a generic irq chip to
demultiplex those IRQ events.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
