From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Nov 2013 16:29:21 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118135727.GD14306@sirena.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
Message-ID: <20131118152920.GL26046@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 01:57:27PM +0000, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 01:40:22PM +0000, Grant Likely wrote:
> 
> > Some hardware does that. That's what OHCI, EHCI, UHCI, XHCI, SDHCI, and
> > similar are all about. It always helps when well understood hardware
> > follows a register interface. It doesn't work for everything, but I
> > agree it would be good to have preferred hw interfaces for SPI & I2C.
> 
> You'd need something class based like USB, there's such massive
> variation in what the hardware is trying to do and the tradeoffs.  A big
> issue is that especially with I2C many of the devices are primarily
> analogue devices implemnted in larger processes where the cost of adding
> additional digital logic can have a noticeable effect on the area and
> hence cost of the silicon.

My comments were mostly regarding the interface controllers. Those which
generate the same bus transactions but need different drivers on every
SoC. I suspect that the same costs don't apply (or at least not to the
same extent) to SoCs.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/b0016586/attachment-0001.sig>
