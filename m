From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Sep 2017 11:21:16 +0100
Subject: [PATCH v2 0/4] Make PL031 interrupt optional
Message-ID: <20170929102116.GX20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some boards out there which have a PL031 RTC, but its
interrupt is not wired up.  To support these, we need the PL031
to support the primecell without interrupts.

When no interrupt is present, there's little point exposing the
RTC's alarm capabilities, so we omit the alarm-related function
calls - the RTC merely becomes a source of time-of-day.

This patch series cleans up the pl031 driver a little, and adds
support for this configuration.

 drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

v2: update patch 2 & 3 for review comment on v1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
