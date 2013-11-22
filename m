From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Nov 2013 12:57:31 +0000
Subject: Patches from ARM folks solicited for the -stable tree
In-Reply-To: <20131121225227.GA12201@kroah.com>
References: <alpine.DEB.2.02.1311210442560.30143@utopia.booyaka.com>
 <20131121153254.GA3422@kroah.com>
 <alpine.DEB.2.02.1311211818000.30143@utopia.booyaka.com>
 <20131121185021.GA15057@kroah.com>
 <alpine.DEB.2.02.1311212210150.9743@utopia.booyaka.com>
 <20131121225227.GA12201@kroah.com>
Message-ID: <20131122125731.GL14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 02:52:27PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Nov 21, 2013 at 10:15:37PM +0000, Paul Walmsley wrote:

> > It's true that the focus here for -stable has mostly been for fixes for 
> > code that causes some kind of crash or failure, rather than new device 
> > support.  Including new device support could probably increase the amount 
> > of -stable patches by quite a bit.  The problem with this is that it could 
> > cause hard-to-find regressions in the -stable kernel.  For example, on 
> > OMAP, adding support for a new device could potentially cause PM 
> > regressions on the rest of the system, depending on how the driver 
> > operates.  So the bar for those types of patches seems pretty high if it's 
> > really intended to be a "stable" kernel.

> Then those "types" of patches are not device ids or quirks being added
> to a table, so of course I wouldn't want to take those into the stable
> tree...

What happens moderately often (not just for OMAP) is that the driver
level change is a stable suitable change by itself but starting to use
the driver can expose a requirement to do additional work on some
existing SoCs to integrate it properly since the driver starts using SoC
integraton that isn't altogether there or correct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/b300f7b4/attachment.sig>
