From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat,  9 Mar 2013 18:44:36 +1300
Subject: [PATCH] tty: serial: vt8500: Fix clock code in probe
Message-ID: <1362807877-23263-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Looks like there was some kind of copy-paste messup in the probe function
which has resulted in some incorrect code being left after the conversion from
a fixed 24Mhz reference to a clock based driver.

This patch tidies up the initialization in probe() of the clock related bits.

Regards
Tony Prisk

Tony Prisk (1):
  tty: serial: vt8500: Unneccessary duplicated clock code removed

 drivers/tty/serial/vt8500_serial.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
1.7.9.5
