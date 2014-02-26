From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 12:03:59 +0000
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <530DCC8A.6060708@ti.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
 <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon>
 <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com>
Message-ID: <20140226120359.GA27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 01:14:18PM +0200, Tomi Valkeinen wrote:
> We have a bunch of panels and encoders used on OMAP boards, and we have
> separate, omapdss specific, drivers for those. My plan is to continue
> improving those drivers until they can be platform independent. This
> would be the Common Display Framework that's been discussed (or a
> precursor to it).

I believe CDF has been knocked on the head.

Also - DRM is not going to ever support hotplugging components - this
was discussed at kernel summit last year and David Airlie was quite
adamant about that.  So, any "framework" which forces hotplugging of
components on subsystems isn't going to fly.

This is why we now have the component helpers in the driver model -
to allow devices to be collected together into one logical subsystem
group, and bound/unbound as a group.

Remember that "hotplugging" in this context does not mean that the
user can physically do something with the hardware.  It means that
they're separate devices which can be probed/removed at will.  Every
device in Linux can be bound and unbound from its driver at any time
by userspace, and that is something which is expected to be handled
gracefully.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
