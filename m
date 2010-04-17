From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 17 Apr 2010 23:42:32 +0300
Subject: [PATCH] i2c-s3c2410: Enable i2c clock only on xfer
Message-ID: <201004172342.43440.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't see any reason to keep i2c clock enabled all the time when i2c bus 
driver is loaded, and even more: it prevents me to disable uda1380 codec power 
- uda1380 doesn't respond on i2c xfers if its power was disabled during i2c 
clock is enabled.

WinMobile enables i2c clock only on xfer (same for i2s clock)

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-i2c-s3c2410-Enable-i2c-clock-only-on-xfer.patch
Type: text/x-patch
Size: 1086 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100417/6e5080f2/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100417/6e5080f2/attachment.sig>
