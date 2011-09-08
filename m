From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2011 22:11:31 +0200
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAKnu2Mpnjec-hvfbT0zH1P2mGZKNwTQYgDLGHWUXLmGGQB0_ow@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<201109081819.30035.arnd@arndb.de>
	<CAKnu2Mpnjec-hvfbT0zH1P2mGZKNwTQYgDLGHWUXLmGGQB0_ow@mail.gmail.com>
Message-ID: <2264116.VTHb2BIH5a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 20:48:26 Linus Walleij wrote:
> 2011/9/8 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 08 September 2011, Barry Song wrote:
> >>
> >> this filter is used by all drivers with DMA since every dma channel is
> >> fixed to be assigned to one device.
> >
> > Ok, I see now. I think it would be best to introduce a generic
> > 'filter by device tree property' function or alternatively an
> > dma_of_request_channel function like this:
> 
> You'd have to discuss that with Vinod, the thing is that x86 Atom
> systems are using dmaengine for device slave transfers too, and
> IIRC these things don't use devicetrees. I may be wrong...

Some of them use device tree, some don't.

I'm not saying that we have to convert all drivers to use this, but
for platforms that always have device tree available, it seems by far
the cleanest solution.

	Arnd
