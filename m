From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Oct 2014 10:27:05 +0200
Subject: [PATCH 7/9] dmaengine: Move slave caps to dma_device
In-Reply-To: <20140927092846.GA5182@n2100.arm.linux.org.uk>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-8-git-send-email-maxime.ripard@free-electrons.com>
 <20140927092846.GA5182@n2100.arm.linux.org.uk>
Message-ID: <20141001082705.GF6884@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 10:28:47AM +0100, Russell King - ARM Linux wrote:
> On Sat, Sep 27, 2014 at 10:54:43AM +0200, Maxime Ripard wrote:
> > The previous code was relying on the fact that the slave_caps were to be
> > defined on a per channel basis.
> > 
> > However, this proved to be a bit overkill, since every driver filling these so
> > far were hardcoding it, disregarding which channel was actually given.
> > 
> > Add these capabilities to the dma_device structure, so that drivers can just
> > provide them at probe time, and be done with it.
> 
> This is also buggy for the same reason as patch 6.

Indeed

> The only way to do this is to either have a flag day, fixing all drivers
> at once (which isn't going to happen) or leave the caps code as-is, and
> provide a library function which drivers can hook into the caps callback
> which retrieves the information from dma_device.
> 
> That way, DMA engine drivers which are using the new method can just
> install the new function, and those which haven't been updated with
> capabilities can carry on as they are, and are detectable to drivers.

Which is pretty much the current behaviour, isn't it?

> What would be acceptable is to have the DMA engine registration function
> spot the lack of DMA caps function and print a warning at boot to
> encourage people to add it.

That would be an option too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/d72be5ed/attachment-0001.sig>
