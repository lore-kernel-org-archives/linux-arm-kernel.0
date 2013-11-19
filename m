From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 Nov 2013 10:11:42 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118183502.GP2674@sirena.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
 <20131118160626.GN26046@ulmo.nvidia.com>
 <20131118183502.GP2674@sirena.org.uk>
Message-ID: <20131119091140.GE31504@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 06:35:02PM +0000, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 05:06:28PM +0100, Thierry Reding wrote:
> 
> > Part of my point was that you could possibly still use the same IP with
> > only a modified (standard) register interface. That way no licensing of
> > third party IP would be needed. You'd only need to rewrite parts of the
> > IP to make it look (and behave) like the standard one.
> 
> > That's exactly how 16550-compatible UARTs work, isn't it? Or even the
> > way that USB (EHCI, ...) work. There's a standardize register interface,
> > possibly with a way for vendor-specific extensions, but the interface
> > itself doesn't need to be licensed, so there are no additional costs to
> > supporting the standard interface. There are only the advantages of
> > being able to reuse a well-tested body of code.
> 
> My (potentially flawed) understanding here is that the register
> interfaces for this sort of thing tend to be very thin - perhaps more
> true for SPI which is extremely simple electrically.  Adding a new
> interface therefore ends up being more invasive than it could appear
> since assumptions in the design and validation tend to appear in the
> registers and so changing the register map propagates through.
> 
> I do agree that it'd be nice to get some standardisation at some level,
> I just fear that it's a bit late.

It certainly won't be easy, but I don't think it's too late. Hardware
used to be simple, and operating systems used to be simple. But that's
no longer true. There is a reason why we're trying to come up with ways
to move some of the complexity out of the kernel. We know that things
aren't going to scale well if the rate of change and increase in
complexity continue at the same pace.

Isn't that the reason why PSCI and similar have been conceived? Even DT
is a byproduct of those developments. What we've been doing so far is to
come up with ways to solve all these problems with additional layers of
software. But I don't think we can go on doing that endlessly. Doing so
also makes it increasingly complicated to build a complete open-source
stack for a device. If you have to rely on all sorts of firmware to boot
a device to a usable state that can very easily become really messy.

While it might already be late now, it will certainly be much later a
few years down the road.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/899dc0d4/attachment.sig>
