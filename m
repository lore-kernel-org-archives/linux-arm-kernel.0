From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 May 2015 10:52:28 +0200
Subject: [PATCH v3] Thermal hardware trip points and Mediatek thermal driver
Message-ID: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hardware trip points. It picks up earlier
work from Mikko Perttunen. Mikko implemented hardware trip points as part
of the device tree support. It was suggested back then to move the
functionality to the thermal core instead of putting more code into the
device tree support. This series does exactly that.

The majority of the patches are cleanups and fixes. Patch 11 introduces
hardware tracked trip points and finally a driver for the Mediatek
thermal controller is introduced as the first user is added.

All comments welcome

Changes since v2:
- Add Mediatek thermal controller driver as first user for hardware trip
  points

Changes since v1:
- Use int instead of unsigned long consistently for temperatures
- Instead of misfixing the emulation code add a comment how the
  code is meant
- Add doc entry for .set_trips callback
- initialize prev_low_trip/prev_high_trip properly
- get tz->lock before calling thermal_zone_set_trips()
