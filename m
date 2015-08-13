From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:13 -0700
Subject: Raspberry Pi KMS-only driver
Message-ID: <1439427380-2436-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the first patch series for graphics on the Raspberry Pi.  It
brings up fbcon on KMS, and the xf86-video-modesetting driver runs so
you can do X with no further userspace drivers.

Right now this series doesn't support changing video modes away from
the firmware boot setup, because when I set the pixel clock using the
rpi-dt-clocks series I end up with a black display. even on no-op
modesets.

I've dropped all of the 3D bits from this series, to simplify this
review stage.  See vc4-kms-v3d-rpi2 for a series that works with the
current Mesa driver, based on downstream 2709.  I squashed all of my
messy KMS series down, but kept Derek's patches separate to make sure
he gets credit.

This code can also be found at:

https://github.com/anholt/linux/tree/vc4-kms-squash
