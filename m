From: jose.goncalves@inov.pt (=?ISO-8859-1?Q?Jos=E9_Miguel_Gon=E7alves?=)
Date: Wed, 17 Feb 2010 18:09:35 +0000
Subject: [PATCH] spi_s3c24xx: Fix for SPI on S3C2412
Message-ID: <4B7C30DF.90805@inov.pt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Testing some SPI temperature sensors and ADCs with a S3C4212 host I have 
found that I could not read the correct data.  I've probed the SPI 
signals with a scope and everything seemed OK.
I dig into the driver sources and on the S3C2412 datasheet to find that 
this device can not use the same S3C2410 driver's code because of the 
added FIFOs, even if not used. The following patch is needed to make the 
driver to work on the S3C2412 chip (and probably on the S3C2413).

Regards,
Jos? Miguel Gon?alves
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.git-spi_s3c2412.patch
Type: text/x-patch
Size: 2286 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100217/dd567841/attachment.bin>
