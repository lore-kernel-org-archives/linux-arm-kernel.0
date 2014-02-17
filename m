From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 17 Feb 2014 21:53:14 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAwLzddIHR0eS9zZXJpYWw6IEFkZCBoZWxwZXJzIHRv?=
 =?UTF-8?B?IHVzZSBHUElPcyB0byBjb250cm9sIG1vZGVtIGxpbmVzIGFuZCBpbXBsZW1l?=
 =?UTF-8?B?bnQgYXRtZWxfc2VyaWFsLmM=?=
In-Reply-To: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1392659594.887845512@f137.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????????, 17 ??????? 2014, 17:57 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
> but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
> Moreover, even if the controller can handle CTS/RTS, the dedicated
> CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).
> 
> So this patchset adds the possibility to control those lines via GPIO,
> as it is done for RTS in the patch "switch atmel serial to use gpiolib"
> 
> As it was suggested by Alexander Shiyan, I made that available for
> every board.
> 
> Patch 1 implements the generic helpers to control modem lines via GPIO
> Patches 2 and 3 are just a little tidy up of atmel_serial.c.
> Patch 4 implements modem control lines in atmel_serial atmel_serial.
> Patches 5 and 6 implement the get_direction() gpio call for at91, as
> it is needed by gpiod_get_direction().
> Patch 7 implement the interrupts of CTS/DSR/DCD/RI.

I still recommend split this series. The first patch must be a separate,
2 and 3 - independent to this series, 5 and 6 - to the appropriate mailing lists,
and finally as soon as all of the previous will be applied - you can send 7.

Thanks.
---
