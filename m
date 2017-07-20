From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jul 2017 00:17:45 +0100
Subject: [PATCH 0/4] Make PL031 interrupt optional
Message-ID: <20170720231745.GE31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some boards out there which have a PL031 RTC, but its
interrupt is not wired up.  To support these, we need the PL031
to support the primecell without interrupts.

When no interrupt is present, there's little point exposing the
RTC's alarm capabilities, so we omit the alarm-related function
calls - the RTC merely becomes a source of time-of-day.

This patch series cleans pu the pl031 driver a little, and adds
support for this configuration.

 drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
