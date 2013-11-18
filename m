From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 18:35:02 +0000
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118160626.GN26046@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
 <20131118160626.GN26046@ulmo.nvidia.com>
Message-ID: <20131118183502.GP2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 05:06:28PM +0100, Thierry Reding wrote:

> Part of my point was that you could possibly still use the same IP with
> only a modified (standard) register interface. That way no licensing of
> third party IP would be needed. You'd only need to rewrite parts of the
> IP to make it look (and behave) like the standard one.

> That's exactly how 16550-compatible UARTs work, isn't it? Or even the
> way that USB (EHCI, ...) work. There's a standardize register interface,
> possibly with a way for vendor-specific extensions, but the interface
> itself doesn't need to be licensed, so there are no additional costs to
> supporting the standard interface. There are only the advantages of
> being able to reuse a well-tested body of code.

My (potentially flawed) understanding here is that the register
interfaces for this sort of thing tend to be very thin - perhaps more
true for SPI which is extremely simple electrically.  Adding a new
interface therefore ends up being more invasive than it could appear
since assumptions in the design and validation tend to appear in the
registers and so changing the register map propagates through.

I do agree that it'd be nice to get some standardisation at some level,
I just fear that it's a bit late.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/84293f9c/attachment.sig>
