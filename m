From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Sep 2017 16:39:13 +0200
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <d3d32839-12a8-71fa-cfec-03055d64388d@arm.com>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <20170901003135.10058-1-andre.przywara@arm.com>
 <20170901060445.vboici7qxfkztp3s@flea>
 <743ae23a-372a-762b-c345-b914f09fd718@arm.com>
 <20170904070415.e6nclz5n23bo7f4v@flea>
 <d3d32839-12a8-71fa-cfec-03055d64388d@arm.com>
Message-ID: <20170908143913.6ga64ssakvk2mjis@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 04, 2017 at 09:14:52AM +0100, Andr? Przywara wrote:
> > And obviously, while maintaining the stability of the binding of those
> > hundreds properties.
> > 
> > Or, you can base all this on the compatible, and be done with it once
> > and for all.
> 
> What I am after is to cover SoCs which *don't* have differences in their
> register layout, for instance A83T, H3, A64, R40.
> In an ideal world we could have reused the H3 compatible string,
> adjusting the number of channels for each SoC in the DT.
> 
> So I see that having a generic compatible name will not fly, as we now
> have differences which should not be modelled by DT properties.
> But I still think we should try to cover those non-register differences
> (number of channels) with a DT property, to allow reusing the existing
> driver code whenever possible. As is stands with this series, the R40
> support should just be a matter of:
> 	compatible = "allwinner,sun8i-r40-dma",
> 		     "allwinner,sun50i-a64-dma";

I just suggested the exact same thing, and then saw your mail, so I
guess we have an agreement :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/01b3c576/attachment.sig>
