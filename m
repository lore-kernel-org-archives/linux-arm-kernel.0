From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Mar 2014 09:44:57 -0500
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <53199726.4080300@free-electrons.com>
References: <5318779C.8030901@free-electrons.com>
 <20140306142117.GL4780@lunn.ch>
 <531886B4.2070002@free-electrons.com>
 <20140306144600.GM4780@lunn.ch>
 <53188B73.4000109@free-electrons.com>
 <53189892.5090502@free-electrons.com>
 <20140306160213.GA4327@arch.cereza> <20140306172339.GP4780@lunn.ch>
 <20140306191747.GA32655@arch.cereza>
 <53199726.4080300@free-electrons.com>
Message-ID: <20140307144457.GC18707@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 10:53:42AM +0100, Gregory CLEMENT wrote:
> On 06/03/2014 20:17, Ezequiel Garcia wrote:
> > On Mar 06, Andrew Lunn wrote:
> >>> Can't we fix this so the probe order doesn't affect the name?
> >>>
> >>> Is that sane?
> >>
> >> You are not supposed to trust the device name, since probing can
> >> happen in parallel, on different buses. udev should have rules to name
> >> the interfaces based on the MAC address. On my Debian system i have:
> >>
> >> /etc/udev/rules.d/70-persistent-net.rules
> >>
> >> So what is important is that the MAC addresses are assigned correctly
> >> to the device. And DT does that based on MMIO address, so should be
> >> reliable, independent of probe order.

errr... I've always viewed the udev rules for persistent naming as a
hacky work-around.  If we have an opportunity to present consistent
names to userspace, then we should do that.  Otherwise, why would
devicetree have the ability to assign aliases?

> I was aware of this solution, and indeed for the end user it is the thing
> to do.

If we're broken, then yes.  Once we fix it, then the udev rules would
just confirm that the naming is the same from the previous boot.

thx,

Jason.
