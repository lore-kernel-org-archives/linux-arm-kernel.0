From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Tue, 1 Oct 2013 11:28:38 +0200
Subject: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
In-Reply-To: <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
Message-ID: <201310011128.38928.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
> a couple of the patch descriptions say that they are untested on i.MX28.

On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
> For battery driven systems it is a very bad idea to collect the touchscreen
> data within a kernel busy loop.
>
> This change uses the features of the hardware to delay and accumulate
> samples in hardware to avoid a high interrupt and CPU load.
>
> Note: this is only tested on an i.MX23 SoC yet.

This note is no longer true. Marek tested it on his M28EVK, Lothar on his TX28 
and myself also on an i.MX28EVK.

For the IIO part of the driver I tested on my i.MX23 based ChumbyOne and some 
customer hardware and it seems still to work (I can only guess if the values I 
read from the sysfs entries are correct, sorry).

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
