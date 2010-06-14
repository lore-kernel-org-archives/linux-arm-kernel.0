From: imp@bsdimp.com (M. Warner Losh)
Date: Mon, 14 Jun 2010 09:51:08 -0600 (MDT)
Subject: Request review of device tree documentation
In-Reply-To: <20100614124438.GF9323@yookeroo>
References: <4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
Message-ID: <20100614.095108.295937982770216377.imp@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In message: <20100614124438.GF9323@yookeroo>
            David Gibson <david@gibson.dropbear.id.au> writes:
: On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
: [sni]
: > > That's sort of a self-fulfilling prophecy. ?If the OS doesn't trust the
: > > firmware, there is no pressure for the firmware to "get it right".
: > 
: > Firmware will not get it right.  Period.  There will always be
: > something wrong.  It is never right on PCs.  It will never be right on
: > the other architectures.
: 
: Yes, yes, yes.  And there is a great deal of empirical evidence to
: back that assertion.

While I'll be the first to agree with that, there's also a great deal
of empirical evidence to suggest that they get it right enough often
enough.  Otherwise nothing would boot and everything would be broken.

: >  That goes for OSes too, but upgrading an OS
: > isn't as risky as upgrading firmware.  That isn't to say that it can't
: > be close, but every firmware feature that the OS depends on is a
: > feature that could force a risky firmware upgrade when the bug in it
: > is discovered.
: 
: Indeed.  In fact, the general rule of thumb is really "put as much as
: possible into the most easily replaced layer of the stack".  This is,
: incidentally, why I've always been dubious about simple firmwares
: supplying a flattened device tree rather than including the device
: tree template in the kernel, cuboot style.

The down side of cuboot style is that your kernel will boot on fewer
boards.  The firmware enables more generic kernels.

: > I'm also convinced that the economics are all wrong for "getting it
: > right" when talking about firmware.  Manufactures don't care about
: > firmware; they care about selling boxes.  Customers don't care about
: > firmware, they care about the operating system (well, that's not true
: > either, they care about applications).  For manufactures, once it can
: > boot the real operating system, there is little to no incentive to
: > spend any more money on firmware when the money can be better spent on
: > either the next product or the adding features to the operating system
: > of the existing product.  In fact, spending money on firmware is
: > actually *more risky* one a product ships, because if a firmware
: > upgrade goes bad, then that means product returned for repair at the
: > factory.
: 
: A good analysis.  The other side of this, is that for an OS, if you
: rely on the firmware to do X, it will work when the firmware gets it
: right.  If you do X yourself, it will work whether or not the firmware
: gets it right.  This means that if there's even one firmware you have
: to deal with out there that gets X wrong, you have to do it yourself
: and then there is little to no incentive to rely on firmware even in
: the cases where it does get it right.  In fact there's a disincentive,
: because then you have two different code paths to test and maintain.

Two comments: (1) You are assuming that you are in a position to do
'X' right which isn't always possible (in this case, it is impossible
to do generically, but can be done specifically for a given board if
you know enough about the board) and (2) In this case, the wrapped fdt
path uses the same path as the get the fdt from the firmware.

Warner
