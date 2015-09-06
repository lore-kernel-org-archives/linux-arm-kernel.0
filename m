From: eric@anholt.net (Eric Anholt)
Date: Sun,  6 Sep 2015 10:57:39 -0700
Subject: Raspberry Pi native clock driver
Message-ID: <1441562263-19888-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After my last firmware clocks posting, Gordon at Raspberry Pi pointed
that you can, in fact, touch the clocks from the ARM side.  This is
the driver that resulted from that.  With debug printfs at boot the
clock frequencies from .recalc_rate() are looking good, a few are
definitely corrected compared to our previous fixed clock references,
and I've tested that I can now get different frequencies out of the
pixel clock for the KMS driver.

Gordon and Dom took a look at the code, and while I don't have
explicit Acked-Bys, they thought it seemed pretty sound as far as the
hardware goes.  We'll want to sort out eventually who really owns
which clocks between the firmware and Linux, but for now this at least
gets us corrected frequency information on the Linux side.
