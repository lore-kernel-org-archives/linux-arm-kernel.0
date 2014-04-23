From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 18:13:52 +0100
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for
 components tracking
In-Reply-To: <20140423164328.GG24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk>
 <5351145D.8070207@samsung.com>
 <20140418124652.GE24070@n2100.arm.linux.org.uk>
 <535652B2.7000607@samsung.com>
 <20140422115145.GU24070@n2100.arm.linux.org.uk>
 <5357D68E.8060605@samsung.com>
 <20140423164328.GG24070@n2100.arm.linux.org.uk>
Message-ID: <20140423171351.GH24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 05:43:28PM +0100, Russell King - ARM Linux wrote:
> So, maybe you would like to finally address *my* point about TDA998x
> and your solution in a way that provides a satisfactory answer.  *Show*
> how it can be done, or *outline* how it can be done.

Let me be absolutely clear *why* I'm very interested in this - and that
is because I'm presently converting TDA998x and Armada DRM to use the
component helpers.  If your solution is better, then I'd want to convert
to that instead, and let's retire the component helpers.

At the moment, my belief is that your solution is *very* substandard and
suboptimal precisely for the reasons I've outlined, especially when it
comes to sharing a component between several drivers.

So, if you *really* care, you'll stop fobbing me off on this point and
provide some real technical input how you'd see your solution being used
in exactly the scenario that I've been outlining several times in this
thread.

For example, you could show what kind of modifications you expect would
be required to the _existing_ TDA998x driver to allow it to participate
as a device declared in DT as an entirely separate entity, probed via the
standard I2C probing methods, and then hook itself into the appropriate
DRM driver.  Remembering, of course, that the TDA998x device is used by
more than _just_ Armada DRM.

I don't care if you show it via pseudo-code or by real patch.  I just
want to know _how_ your solution could be used.  And I won't want some
silly remark like "trivially" or "I've already answered that."  I want
_you_ to _show_ _how_ it can be done.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
