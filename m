From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 14:28:42 -0700
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <3108005.nUMWsj4kjp@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <7339827.UeYZLZET5g@wuerfel> <20160329210018.GL2350@sirena.org.uk>
 <3108005.nUMWsj4kjp@wuerfel>
Message-ID: <20160329212842.GN2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 11:08:55PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:

> > Implementing that would require the SPI core to export something
> > providing access to the memory regions.  We don't currently do that,
> > it'd require us to deal with the interaction with access as a SPI device
> > (this hardware often seems to only accelerate reads so we still need to
> > use regular SPI access for writes).

> The manual lists both read and write accesses as handled through
> direct mode.

That is not in general the case for this sort of hardware, and there's
also erase support to consider here.

> > I don't like having to assign windows per device, like I say it seems
> > like more work.

> Ok, but that's something else that can be implemented independently
> as I explained earlier: We currently rely on the windows to be assigned
> in the DT, but it's also possible to extend the mbus driver in a way
> that lets it pick its own windows in one way or another. It should

That's what I've been asking for but people keep saying it's not
possible...

> not impact the binding for the SPI host controller in any way, the
> binding just describes how the internal addressing is wired up to
> the mbus in hardware, and the mbus driver takes care of mapping those
> into CPU addresses.

If we're able to do it automatically without baking this into the DT and
there's enough space to cope with this and PCI together then that's more
reasonable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/f38f0c00/attachment.sig>
