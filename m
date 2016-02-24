From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2016 22:33:50 +0000
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160224184114.GB2292@1wt.eu>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
 <20160224184114.GB2292@1wt.eu>
Message-ID: <20160224223350.GP19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 07:41:14PM +0100, Willy Tarreau wrote:
> Hi Russell,
> Well, now I'm one of these and I confirm that it's really painful to
> have a different ordering between the DTB provided in mainline and the
> DTB provided with the board. The worst thing is that using mainline,
> eth0 corresponds to the switch and appears up, so you don't immediately
> realize that it's not where your cable is connected :-/
> 
> Thus could we please get Thomas' patch to ensure that the board boots
> with similar interface naming with both the original and mainline kernel ?

I didn't say no to it, I merely asked a few pertinent questions and
made some pertinent points.

Let me restate:

* Today, people who switch between mainline and vendor kernels
  experience some pain due to the NIC order changing.

* Mainline has had support for Armada 38x for 2 years now, which is
  long enough for it to have gained users.  AFAICS, there haven't been
  any complaints about the different NIC ordering.  Changing the NIC
  ordering is going to cause breakage to these users when they migrate
  across the change.

By making the change, we're effectively telling these mainline-only
users "we don't care about your setups, we're going to break them"
because that's exactly what we're going to do.

Of course, if no one complains about the change, you've got away
with it.

I think the folk who want to make this change should be prepared for
userspace breakage reports: Linus feels very strongly about zero
userspace regressions, as we all should know.

What I'm saying, therefore, is make the change, but if you have one
report that someone's userspace setup has broken as a result of the
change, the change must be reverted.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
