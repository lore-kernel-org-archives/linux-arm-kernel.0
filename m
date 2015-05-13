From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 10:46:45 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <20150513081535.GS10961@lukather>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <4862159.g8Sk9nOiS2@wuerfel> <20150513081535.GS10961@lukather>
Message-ID: <2913865.DiE4h2cH6J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 10:15:35 Maxime Ripard wrote:
> > Alternatively, you could leave the XOR_DESCRIPTOR_SWAP flag disabled
> > and just swap the descriptors manually like a lot of other drivers
> > do. You have to swap the mmio accesses anywya.
> 
> That won't be easily doable however.
> 
> Not only the endianness of the individual fields in the descriptor
> changes, but changing the endianness also swaps the fields themselves
> by pair of u32.
> 
> You can see that here:
> http://lxr.free-electrons.com/source/drivers/dma/mv_xor.h#L159
> 
> So I'm guessing that leaving it like it is was the more readable
> solution.

I see, yes that would get a bit ugly.

	Arnd
