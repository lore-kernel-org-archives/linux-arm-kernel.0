From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sat, 23 Sep 2017 19:30:56 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170923182324.GK20805@n2100.armlinux.org.uk>
References: <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
 <20170922095713.GD20805@n2100.armlinux.org.uk>
 <20170922164850.GA13235@obsidianresearch.com>
 <20170922172022.GJ20805@n2100.armlinux.org.uk>
 <20170922182424.GA21945@obsidianresearch.com>
 <20170923182324.GK20805@n2100.armlinux.org.uk>
Message-ID: <20170924013056.GA811@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 07:23:24PM +0100, Russell King - ARM Linux wrote:

> So we're getting it almost right - except for the sloppyness of the
> workqueue being run (which is mostly dependent on the sloppiness of
> the timer.)

Looks really good. I made a note of your fix, but I probably will not
be able to pick this up again until Friday.

I think what is left to do:
- Test on x86 with CMOS, using rtclib and update_persistent_clock. I
  may be able to put together a system for this, but I don't have
  anything ready to go right now that is not kvm based. :\
- Add patches in a series to set set_offset_nsec for RTCs we have
  learned about.
- HR timer stuff, I'm inclined to put that in a dedicated patch in
  a series?

Anything else? Thanks for your patience with my untested patches :\

Jason
