From: jbe@pengutronix.de (Juergen Beisert)
Date: Tue, 15 Dec 2009 14:43:59 +0100
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
Message-ID: <200912151443.59761.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

has anyone experience with SD card usage on Samsung S3C2410/S3C2440 CPU based 
systems?

I tried with:

 - a very old Canon SD Memory Card SDC, 16 MiB
 - SanDisk SD, 512 MiB
 - SanDisk Micro-SD with adapter, 512 MiB
 - Transcend SD ultra, 1 GiB
 - Kingston Micro SD with adapter, 2 GiB
 - hama SD Class 2, 2GB
 - MMC plus, extreme memory, 2 GB
 - Platinum SD 1, GB

I tried with a few kernels of the 2.6.31.x revision and 2.6.32.1, but most of 
these cards are failing always.
The old Canon card works with every kernel. The others do not work with any 
2.6.31.x revision kernel, but some(!) are working with 2.6.32.1 (both SanDisk 
(512 MiB) and the Kingston Micro SD).

Kernel's output is most of the time:

s3c2440-sdi s3c2440-sdi: running at 0kHz (requested: 0kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c2440-sdi s3c2440-sdi: powered down.
mmc0: error -110 whilst initialising SD card
s3c2440-sdi s3c2440-sdi: powered down.

The output for the "Kingston Micro SD" in kernel 2.6.32.1:

s3c-sdi s3c2440-sdi: running at 0kHz (requested: 0kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
s3c-sdi s3c2440-sdi: running at 24978kHz (requested: 25000kHz).
s3c-sdi s3c2440-sdi: running at 24978kHz (requested: 25000kHz).
mmc0: new SD card at address 8d7e
mmcblk0: mmc0:8d7e SD02G 1.83 GiB
 mmcblk0: p1 p2

Any idea why most of the cards do not work?

Regards
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
