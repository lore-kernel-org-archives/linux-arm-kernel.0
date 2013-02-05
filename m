From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 10:31:35 -0500
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205142720.GB2481@localhost>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
Message-ID: <20130205153135.GU14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 11:27:21AM -0300, Ezequiel Garcia wrote:
> On Tue, Feb 05, 2013 at 07:48:33AM -0500, Jason Cooper wrote:
> > Morning-ish Andrew,
> > 
> > On Tue, Feb 05, 2013 at 01:38:27PM +0100, Andrew Lunn wrote:
> > > > And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> > > 
> > > Maybe it makes sense to provide a patch to mvebu_defconfig to add 
> > > CONFIG_MTD_M25P80=y ?
> > 
> > I thought this as well, then reconsidered when he said there was nothing
> > on it.  So it's not really needed to boot.  I don't have a strong
> > opinion on it though, so =y, =m, or =n.
> > 
> 
> Well, the SPI flash may not be empty, if that's what you meant.
> For instnace, my Armada XP GP board has the bootloader on that SPI,
> and boots from there. After booting, the SPI flash is no longer needed.

Is the bootloader environment on there?  Is there room for the dtb once
u-boot is upgraded to support fdt?

> IMHO, I don't think we should include the option CONFIG_MTD_M25P80
> as it is just a particular SPI master device present in a particular board.
> 
> On the other hand, I don't have a strong opinion on this.
> I've always wondered the *true* meaning of defconfigs,
> so feel free to enligthen me :)

Hmm, a quick look through Documentation/* didn't produce anything
authoritative.  There's Documentation/sh/new-machine.txt which says

"
Now all that's left to do is providing a defconfig for your new board.
This way, other people who end up with this board can simply use this
config for reference instead of trying to guess what settings are
supposed to be used on it.
"

One thing we've been doing a lot of with mvebu is using it for
build-testing.  For that use case, since the bootloader is there, I'd
recommend setting it.  This will reduce the likelyhood of nasty build
breakages futher down the line as we'll catch them before pushing to
arm-soc.

thx,

Jason.
