From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 17:24:23 +0100
Subject: [PATCH] [MEDIA] dvb: usb: fix dib3000mc dependencies
In-Reply-To: <3984729.n55BH9Zr8c@wuerfel>
References: <3984729.n55BH9Zr8c@wuerfel>
Message-ID: <5525192.eyIcy1NRHy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 17:17:39 Arnd Bergmann wrote:
> The dibusb_read_eeprom_byte function is defined in dibusb-common.c,
> but that file is not compiled for CONFIG_DVB_USB_DIBUSB_MB as it
> is for the other driver using the common functions, so we can
> get a link error:
> 
> drivers/built-in.o: In function `dibusb_dib3000mc_tuner_attach':
> (.text+0x2c5124): undefined reference to `dibusb_read_eeprom_byte'
> (.text+0x2c5134): undefined reference to `dibusb_read_eeprom_byte'
> 
> This changes the Makefile to treat the file like all the others
> in this directory, and enforce building dvb-usb-dibusb-common.o
> as a dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

I just realized that this depends on another patch I've sent back
in April, so that is probably no longer in the patch queue. Please
disregard for now.

	Arnd
