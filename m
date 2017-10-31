From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 31 Oct 2017 12:19:39 +0800
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
Message-ID: <1509423579.10793.10.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

We have 3 root ports in MT7623, but this is a bug in this chip where the
HW designers wired the IRQs in a nonstandard way. We've tried to
statically assign the bus portion of the address part in the parent
interrupt-map before, but this approach cannot handle the case - if we
attach the device in random order.

Thanks.

On Mon, 2017-10-30 at 13:42 +0100, Arnd Bergmann wrote:
> On Mon, Oct 23, 2017 at 12:06 AM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> >
> > ----------------------------------------------------------------
> > - mt76233 add PCIe node
> 
> Could you clarify what the subnodes in the PCI node are for? It seems odd
> to have "interrupt-map" properties in both the pcie controller and its child
> nodes, and I want to ensure this is following the standard PCIe binding before
> I pull it.
> 
>        Arnd
> 
