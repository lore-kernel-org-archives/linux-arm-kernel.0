From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 27 Mar 2015 14:59:29 +0000
Subject: [PATCH v4 0/2] serial/amba-pl011: Activate TX IRQ passively (rework)
Message-ID: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a repost against tty-next only.

There is no code change compared with v3.

The only difference from v3 is rewording of an accidentally cloned
commit message, so that the message actually describes the patch.

For history, see
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333498.html
and earlier posts.

(This series sent through itself, via PPP on pl011.  Eeesh, I'd
forgotten what life was like in the dial-up era...)


Dave Martin (2):
  Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is
    not open"
  serial/amba-pl011: Refactor and simplify TX FIFO handling

 drivers/tty/serial/amba-pl011.c |  118 +++++++++------------------------------
 1 file changed, 27 insertions(+), 91 deletions(-)

-- 
1.7.10.4
