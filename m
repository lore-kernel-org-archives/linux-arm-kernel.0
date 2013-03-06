From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Mar 2013 17:27:12 -0500
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306215031.GB4916@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
Message-ID: <20130306222712.GP23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 02:50:31PM -0700, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2013 at 09:40:36PM +0100, Thomas Petazzoni wrote:
...
> > Again, I don't see the point of making the DT binding more complex than
> > the one being proposed here, and you haven't given any really
> > compelling arguments except that it is not to your taste. I believe
> > we're reaching a point where things start to be a matter of taste, and
> > so unless you're writing the code and doing the work yourself, you also
> > have to accept that other people might have different visions of how
> > things should be handled, and therefore have different tastes.
> > 
> > How can we make progress on this, in a *reasonable* way?
> 
> Well, as you say, we've pretty much completed presenting arguments for
> each view on this subject, so it is really up to the gatekeepers of
> the stable DT 'ABI' to decide on how they want this all to look in the
> end, IMHO.
> 
> Jason C/Andrew L/Arnd?

I'm inclined to agree with Thomas.  Since the the first Kirkwood DT
board was added to the tree, it's been pounded into me that DT
*describes hardware*.  Not how random bootloader X happened to configure
it.

However, we also have the example of local-mac-address.  Which is
describing how the hardware is *configured* to present a consistent id
to a network (from bootloader to kernel to userspace).  This is
certainly a valid deviation from the rule.

If a bootloader setup some windows before handing off control to the
kernel (keep in mind, this could be *BSD, windows, BeOS, etc), is there
any /need/ to keep that configuration?

If we are to include Jason's suggestion, I think it should be listed as
optional properties typically inserted at boot by the bootloader as an
FYI.  And, for Thomas' sanity, presented as a future patch on top of
current work. ;-)

At this point, we have at least a few release cycles to shake out a
standard DT binding for Marvell SoCs.  Currently, not a single product
ships with a DT-enabled bootloader.  Not even the development boards
created by Marvell.  So I'm fine with Thomas' bindings as they stand
*and* fine with adjusting them over the next few releases as needed.

It'll be a different story once products start being released with
DT-enabled bootloaders.

thx,

Jason.
