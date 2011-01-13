From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 13 Jan 2011 09:25:19 +0100
Subject: i.MX & IRQF_ONESHOT
Message-ID: <4D2EB6EF.7030608@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

while testing 2.6.37 on our i.MX27 based board - code in 
arch/arm/mach-imx/eukrea_mbimx27-baseboard.c - I noticed the touchscreen 
controller (ADS7846) doesn't work anymore.

A few IRQ are generated when probing for the chipset and starting calibration 
(usually first point works), then nothing more (even if the IRQ signals is 
generated as seen on the scope, the irq count doesn't increase anymore and 
stays <= 4 and no data is reported to the input layer).

drivers/input/touchscreen/ads7846.c was switched to threaded IRQ in commit 
2991a1ca6e9b13b639a82c0eec0cbc191bf1f42f where was added :
irq_flags |= IRQF_ONESHOT;

Commenting out this line in the ads7846 driver makes it work again.
Am I missing something obvious or is there a reason for IRQF_ONESHOT creating 
trouble with gpio irq or SPI on i.MX ?

Thanks
Eric
