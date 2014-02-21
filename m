From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Feb 2014 09:34:44 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140221003227.GF19893@obsidianresearch.com>
References: <53039894.10905@keymile.com> <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com> <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com> <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
 <20140220173518.GA19893@obsidianresearch.com>
 <20140220212914.29ddc031@skate>
 <20140221003227.GF19893@obsidianresearch.com>
Message-ID: <20140221093444.35870a73@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 20 Feb 2014 17:32:27 -0700, Jason Gunthorpe wrote:

> > In practice, the story is a little bit more subtle than that: the PCIe
> > driver may want to decide to either tell the PCI core to enlarge the
> > window BAR up to the next power of two size, or to dedicate two windows
> > to it.
> 
> That is a smart, easy solution! Maybe that is the least invasive way
> to proceed for now?

So you suggest that the mvebu-mbus driver should accept a
non power-of-two window size, and do internally the job of cutting that
into several power-of-two sized areas and creating the corresponding
windows?

> I have no idea how you decide when to round up and when to allocate
> more windows, that feels like a fairly complex optimization problem!

Yes, it is a fairly complex problem. I was thinking of a threshold of
"lost space". Below this threshold, it's better to enlarge the window,
above the threshold it's better to create two windows. But not easy.

> Alternatively, I suspect you can use the PCI quirk mechanism to alter
> the resource sizing on a bridge?

Can you give more details about this mechanism, and how it could be
used to alter the size of resources on a bridge?

> > Jason, would you mind maybe replying to Bjorn Helgaas email (Thu, 20
> > Feb 2014 12:18:42 -0700) ? I believe that a lot of the misunderstanding
> > between Bjorn and me is due to the fact that I don't use the correct
> > PCI terminology to describe how the Marvell hardware works, and how the
> > Marvell PCIe driver copes with it. I'm sure you would explain it in a
> > way that would be more easily understood by someone very familiar with
> > the PCI terminology such as Bjorn. Thanks a lot!
> 
> Done!

Thanks a lot! Really appreciated.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
