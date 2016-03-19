From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 19 Mar 2016 17:48:14 +0000
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <87oaab980n.fsf@free-electrons.com>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <87oaab980n.fsf@free-electrons.com>
Message-ID: <20160319174814.GK1184@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all,

On Fri, Mar 18, 2016 at 03:26:48PM +0100, Gregory CLEMENT wrote:
> 
> (adding Jason Cooper in CC:)
> 
> Hi Thomas and Andrew
>  
>  On ven., mars 18 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> 
> > Hello,
> >
> > On Fri, 18 Mar 2016 14:14:32 +0100, Andrew Lunn wrote:
> >
> >> Isn't this also applicable to mvebu v5?
> >> 
> >> And your change to multi_v7_defconfig could also be applied to
> >> multi_v5_defconfig.
> >
> > mvebu_v5 already enables a crypto driver, but it's the old one. So
> > there's a decision to be taken here whether we move all the platforms
> > to use the new driver or not.
> >
> > The new driver has been tested on the Armada family, and I believe also
> > on Kirkwood. However I'm pretty sure it hasn't been tested on Dove and
> > Orion.
> >
> > Dove is ARMv7 and enabled in mvebu_v7_defconfig, but since neither the
> > old nor the new driver were enabled in mvebu_v7_defconfig, we are not
> > going to disrupt any existing user here by adding the new driver in the
> > defconfig.
> >
> > Changing mvebu_v5_defconfig, multi_v5_defconfig, orion5x_defconfig and
> > dove_defconfig however implies moving those defconfigs away from the
> > old driver, and select the new one instead. A more serious change,
> > IMO.
> 
> 
> For Dove I don't know if there are users for this module, but for Orion
> and Kirkwood as they are used in NAS product, I am pretty sure that
> people use it. I would like to have some feedback about users which have
> switched to the new driver. I think Jason did it on kirkwood.

As long as the old driver is still in the tree for fallback, let's go
ahead and switch the relevant kernel configs over to the new driver.

Then, we can deprecate the old driver after a few cycles.

thx,

Jason.
