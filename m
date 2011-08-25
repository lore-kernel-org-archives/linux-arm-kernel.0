From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Aug 2011 11:28:24 +0100
Subject: How to handle named resources with DT?
In-Reply-To: <20110824231613.GC19890@legolas.emea.dhcp.ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
	<201108121635.42953.arnd@arndb.de> <4E45422D.4050708@ti.com>
	<CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
	<87r54a1v0o.fsf@ti.com>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
Message-ID: <20110825102824.GB10405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
> on top of all that, for IPs which are used on many SoCs (such as MUSB)
> it's quite silly to force all users to provide resources in a certain
> order. It sounds to me that this will be prone to error in many ways
> until everything is synced up and on the correct order.
> 
> Ditching _byname is a very bad idea.

I continue to disagree.  The current _byname is an abonimation and hack
to try to "fix" this problem.

_byname should have been implemented differently - rather than overriding
the resources name field (which is _normally_ specified to be the device
or driver name), a new field should have been introduced in struct resource
to carry the resource sub-name (which is really what it is.)

That would have avoided making /proc/iomem completely illegible with
multiple devices using this feature.
