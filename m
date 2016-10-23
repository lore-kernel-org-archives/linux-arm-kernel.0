From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2016 20:10:02 +0100
Subject: [PATCH RFC 0/10] tda998x initial cleanups from bridge conversion
Message-ID: <20161023191002.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the discussion about converting tda998x to a bridge, here's
some preparatory work for that, which includes a bunch of fixes.  I'm
sending this out _early_ as I'm not going to be working on any kernel
stuff next week (it's likely I won't even be reading email.)  So it may
be a little rough around the edges.

Essentially, this is a series of cleanups, complexity removal, and
avoiding races with the newly introduced audio support.  Even without
the bridge conversion, I think all these are still worthwhile to have.

This series of changes can also be found in my drm-tda998x-devel branch
as an unstable series of commits (iow, I'm going to rebase/rework these
at some point, so the commit IDs are not stable, so do not merge this.)

 git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel

 drivers/gpu/drm/i2c/tda998x_drv.c | 782 +++++++++++++++++++-------------------
 1 file changed, 394 insertions(+), 388 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
