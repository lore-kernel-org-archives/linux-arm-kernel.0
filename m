From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 24 Jul 2014 14:02:54 +0200
Subject: [PATCH 0/2] serial: st-asc: Couple of fixes
Message-ID: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains two fixes for ST's ASC driver.

The first issue addressed is a Kernel BUG when using the console on a different
ASC instance than the one being probed.

The second one is an overflow during buad rate calculation when requested rate
is higher than about 262Kbauds.

Maxime Coquelin (2):
  serial: st-asc: Don't call BUG in asc_console_setup()
  serial: st-asc: Fix overflow in baudrate calculation

 drivers/tty/serial/st-asc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
1.9.1
