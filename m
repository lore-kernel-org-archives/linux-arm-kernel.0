From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 26 Apr 2018 11:54:40 +0100
Subject: [RFC PATCH v4] tty: pl011: Avoid spuriously stuck-off interrupts
Message-ID: <1524740081-4979-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update to a previous RFC v3 [1], to fix a problem observed by
the qemu community that causes serial input to hang when booting a
simulated system with data already queued in the UART FIFO [2].

RFC v3 did not solve the problem by itself, due to the problem being
triggered again in pl011_enable_interrupts() after working around it
in pl011_hwinit().  See the updated commit message in the patch for
details.

This patch is intended to supersede the previous RFCs, so please test
_without_ RFC v2 (or 3) applied.

If you can, please:

 a) Check that you can still reproduce the bug on mainline without this
    patch.

 b) Check whether this patch fixes the problem.

Cheers
---Dave

[1] [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573120.html

[2] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Dave Martin (1):
  tty: pl011: Avoid spuriously stuck-off interrupts

 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.1.4
