From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 13 Jun 2012 11:48:29 -0400
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FD8AC5E.1060804@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD8AC5E.1060804@redhat.com>
Message-ID: <20120613154829.GH14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:06:06AM -0400, Jon Masters wrote:
> On 06/11/2012 12:52 PM, Gregory CLEMENT wrote:
> 
> > You'll find in this patch set the new version of the initial support for a
> > new family of ARMv7-compatible Marvell SoCs initially submitted by my
> > colleague Thomas Petazzoni. Following the conclusion of the discussion when
> > we submitted our first version we have chosen to add this support for this
> > SoC family in the to support in the arch/arm/mach-mvebu/ directory.
> 
> Pardon my silly question. I know that there's an effort to reconcile the
> two different SoCs so you're picking a neutral name, but what does
> "mvebu" mean, and will you be persistently keeping this name? 

As persistent as anything else is in life ;-P  It covers all the SoCs that
have come out of Marvell's EBU division.  This includes orion5x,
kirkwood, dove, mv78xxx, the new armada xp, etc.

We're placing all boards under that umbrella with DT support into
mach-mvebu/.  Eventually, once DT conversion is complete, the other
directories will empty out and mach-mvebu/ will hold all support for
those SoCs.

Currently, the only boards with DT support are in mach-kirkwood/: the
dreamplug, iconnect, and a few others.  Before it gets too out of hand,
Arnd has a patch series which consolidates it all into mach-mvebu/.

> Our guys want to know what this new platform will entail for Fedora
> support in terms of the platform name being used in various non-kernel
> places.

I'm not familiar with how Fedora does it, but debian has five different
armel kernels, each supporting a range of boards.

linux-image-iop32x
linux-image-ixp4xx
linux-image-kirkwood
linux-image-orion5x
linux-image-versatile

At the very least, they will be able to consolidate -kirkwood and
-orion5x into linux-image-mvebu if they choose.


hth,

Jason.
