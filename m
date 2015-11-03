From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 14:48:43 +0000
Subject: [PATCH DRAFT 0/2] Sketch for ZTE ZX296702 UART integration
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <20151103134349.GV8644@n2100.arm.linux.org.uk>
Message-ID: <20151103144843.GY8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 01:43:49PM +0000, Russell King - ARM Linux wrote:
> So, I'm working on a replacement set of patches which does this the
> right way, and I'll post them later today or early tomorrow, depending
> on when I get them tested on the Versatile / Juno platforms.

Here's my version of the changes required, following the ideas I've put
forward in previous threads.  Build tested, but not boot tested yet.
They're queued for my nightly build and boot test this evening.

The final patch in the series is experimental as it's missing the
detection to make use of the ZTE UART bits.  Also, I'm debating whether
we should make that conditional on a config symbol so that non-ZTE
platforms don't have to suffer the consequences of the conditional 32-bit
accessor.

 drivers/tty/serial/amba-pl011.c | 341 ++++++++++++++++++++++++++--------------
 drivers/tty/serial/amba-pl011.h |  34 ++++
 include/linux/amba/serial.h     |  18 +++
 3 files changed, 272 insertions(+), 121 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
