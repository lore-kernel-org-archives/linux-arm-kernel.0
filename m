From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed, 24 Sep 2014 11:24:37 +0200
Subject: [PATCH v2 8/8] tty/serial: add asm9260-serial driver
In-Reply-To: <3430001.JjzmzIerfp@wuerfel>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-7-git-send-email-linux@rempel-privat.de>
 <3430001.JjzmzIerfp@wuerfel>
Message-ID: <54228DD5.1090606@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.09.2014 um 17:26 schrieb Arnd Bergmann:
> On Sunday 21 September 2014 20:45:51 Oleksij Rempel wrote:
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  drivers/tty/serial/Kconfig          |   17 +
>>  drivers/tty/serial/Makefile         |    1 +
>>  drivers/tty/serial/asm9260_serial.c | 1485 +++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h    |    2 +
>>  4 files changed, 1505 insertions(+)
>>  create mode 100644 drivers/tty/serial/asm9260_serial.c
>>
> 
> Similar to the irqchip driver, this one in turns seems to be a duplicate
> of drivers/tty/serial/mxs-auart.c. Please see if you can make that one
> work instead of adding a new copy.

Hmmm.... they are identical in some parts, but have some different
offsets, and in some cases different bitmask. I think it will look
messy. Asm9260 has some more extras: RS485, CTRL3, ISO7816. Should it be
moved to one file? Or may be better to create some common-dma.c and
common-pio.c libs?

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/f49b6a8c/attachment.sig>
