From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 09 Sep 2011 03:08:03 +0530
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <2264116.VTHb2BIH5a@wuerfel>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<201109081819.30035.arnd@arndb.de>
	<CAKnu2Mpnjec-hvfbT0zH1P2mGZKNwTQYgDLGHWUXLmGGQB0_ow@mail.gmail.com>
	<2264116.VTHb2BIH5a@wuerfel>
Message-ID: <1315517883.6638.1.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-08 at 22:11 +0200, Arnd Bergmann wrote:
> On Thursday 08 September 2011 20:48:26 Linus Walleij wrote:
> > 2011/9/8 Arnd Bergmann <arnd@arndb.de>:
> > > On Thursday 08 September 2011, Barry Song wrote:
> > >>
> > >> this filter is used by all drivers with DMA since every dma channel is
> > >> fixed to be assigned to one device.
> > >
> > > Ok, I see now. I think it would be best to introduce a generic
> > > 'filter by device tree property' function or alternatively an
> > > dma_of_request_channel function like this:
> > 
> > You'd have to discuss that with Vinod, the thing is that x86 Atom
> > systems are using dmaengine for device slave transfers too, and
> > IIRC these things don't use devicetrees. I may be wrong...
> 
> Some of them use device tree, some don't.
> 
> I'm not saying that we have to convert all drivers to use this, but
> for platforms that always have device tree available, it seems by far
> the cleanest solution.
We don't have a very clean solution for filter function in case of slave
dmaengine. How should the client specify which channel it wants is not
really clear.

We can look at device tree but that's something which wont work in case
of non device tree platforms (atom x86).
What we need is this information of channel mapping, which IMO is
platform specific and needs to come from platform data, we can abstract
it actually from the device tree data/PCI/firmware etc but essentially a
mechanism to publish channels and slaves uniquely and match them in this
kind of data

Linus W, any progress on that patches you posted??
 
-- 
~Vinod Koul
Intel Corp.
