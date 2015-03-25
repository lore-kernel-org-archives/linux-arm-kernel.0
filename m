From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:45 +0000
Subject: [RESEND] Altera socfpga big endian work 
Message-ID: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the core of the socfpga systen to run in big endian
mode. It inclusdes support for debug uart, secondary core boot and has
support for timers and initial conversion patches for the mmc.

The two drivers that are known to not work are the Ethernet and the
dwc2 usb. I do not have data for either, so I currently do not know
if it possible to change the hardware's endian fetch mode.

The dwc2 driver on my cyclone5 socfpga board with v4.0-rc5 does not
work in little endian mode, which makes testing converting the driver
difficult. The supplied 3.10 kernel does work so it is not down to the
hardware. It detects the presence of a new device and then fails to
enumerate it (no other errors shown)

This is up on git.baserock.org/delta/linux.git in the branch
baserock/bjdooks/socfpga-v5

Sorry, this is a resend due to incorrect linux-arm-kernel mailing list
address.
