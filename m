From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 26 Jun 2016 23:06:20 +0200
Subject: [v2] media: rc: fix Meson IR decoder
Message-ID: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The meson-ir driver uses the wrong offset (at least according to
Amlogic's reference driver as well as the datasheets of the
Meson8b/S805 and GXBB/S905).
This means that we are getting incorrect durations (REG1_TIME_IV)
reported from the hardware.

This problem was also noticed by some people trying to use this on an
ODROID-C1 and ODROID-C2 - the workaround there (probably because the
datasheets were not publicy available yet at that time) was to switch
to ir_raw_event_store_edge (which leaves it up to the kernel to measure
the duration of a pulse). See [0] and [1] for the corresponding
patches.

Please note that I was only able to test this on an GXBB/S905 based
device (due to lack of other hardware).


[0] https://github.com/erdoukki/linux-amlogic-1/commit/969b2e2242fb14a13cb651f9a1cf771b599c958b
[1] http://forum.odroid.com/viewtopic.php?f=135&t=20504
