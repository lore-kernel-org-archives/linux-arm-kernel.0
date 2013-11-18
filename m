From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Nov 2013 17:06:28 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118155022.GB28334@sirena.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
Message-ID: <20131118160626.GN26046@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 03:50:22PM +0000, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 04:29:21PM +0100, Thierry Reding wrote:
> > On Mon, Nov 18, 2013 at 01:57:27PM +0000, Mark Brown wrote:
> 
> > > You'd need something class based like USB, there's such massive
> > > variation in what the hardware is trying to do and the tradeoffs.  A big
> > > issue is that especially with I2C many of the devices are primarily
> > > analogue devices implemnted in larger processes where the cost of adding
> > > additional digital logic can have a noticeable effect on the area and
> > > hence cost of the silicon.
> 
> > My comments were mostly regarding the interface controllers. Those which
> > generate the same bus transactions but need different drivers on every
> > SoC. I suspect that the same costs don't apply (or at least not to the
> > same extent) to SoCs.
> 
> Oh, right.  In that space I suspect you'd face apathy on the part of
> vendors for switching away from their existing validated and deployed
> IPs - probably the best shot would be a freely licensed reference
> implementation that people could pick up if they wanted.  It's plausible
> that some of the vendors might do so for SPI where there are a bunch of
> chips that don't have DMA/FIFOs yet and so could possibly benefit from
> performance and feature gains but without that sort of benefit it's hard
> to see what would be persuasive for the vendors.

Part of my point was that you could possibly still use the same IP with
only a modified (standard) register interface. That way no licensing of
third party IP would be needed. You'd only need to rewrite parts of the
IP to make it look (and behave) like the standard one.

That's exactly how 16550-compatible UARTs work, isn't it? Or even the
way that USB (EHCI, ...) work. There's a standardize register interface,
possibly with a way for vendor-specific extensions, but the interface
itself doesn't need to be licensed, so there are no additional costs to
supporting the standard interface. There are only the advantages of
being able to reuse a well-tested body of code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/212df139/attachment.sig>
