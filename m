From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Mon, 26 Nov 2012 15:10:24 +0900
Subject: [PATCH 0/7] ARM: mach-shmobile: kzm9g: Reference DT implementation
In-Reply-To: <1353889014-17142-1-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
Message-ID: <50B307D0.3030800@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon-san,

(2012/11/26 9:16), Simon Horman wrote:

> this series is a first pass at providing a refernce DT implementation
> for the kzm9g baord which is intended to act as a guide for mach-shmobile
> developers.
> 

I tried this patch series on v3.7-rc7 with CONFIG_MACH_KZM9G_REFERENCE=y.
It boot up correctly with rootfs on SD card. It works good for following devices
 - serial port on /dev/ttySC4
 - SD card on /dev/mmcblk0
 - micro SD card on /dev/mmcblk1
 - eMMC on /dev/mmcblk2

I found /dev/i2c-0 seems not to work correctly. "i2cdump" command fails like this.

# i2cdump 0 0x40
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x40, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: [  180.171875] i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
[  180.187500] i2c-sh_mobile i2c-sh_mobile.0: Polling timed out
XX [  185.187500] i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
[  185.203125] i2c-sh_mobile i2c-sh_mobile.0: Polling timed out
XX ^C[  190.203125] i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
[  190.218750] i2c-sh_mobile i2c-sh_mobile.0: Polling timed out

I quited the command by ^C.
When I try the same on v3.7-rc7 without CONFIG_MACH_KZM9G_REFERENCE=y
"i2cdump" command does not time out and shows some data.
