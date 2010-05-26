From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 26 May 2010 11:50:10 +0200
Subject: vpack270 and sleep mode
In-Reply-To: <4BFCE794.9000306@papillon.ru>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<20100525202447.GD16204@n2100.arm.linux.org.uk>
	<201005252247.57688.marek.vasut@gmail.com>
	<4BFC99CB.2090902@papillon.ru>
	<20100526090748.GB25435@n2100.arm.linux.org.uk>
	<4BFCE794.9000306@papillon.ru>
Message-ID: <19452.61138.172496.920965@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> static struct device_driver pxa2xx_flash_driver = {
                ^^^^^^^^^^^^1
>          .name           = "pxa2xx-flash",
>          .bus            = &platform_bus_type,
                             ^^^^^^^^^^^^^^^^^^
This is WRONG!
platform drivers require a struct platform_driver and MUST be
registered using platform_driver_register()!
The platform suspend/resume expects the struct device_driver to be
embedded within a struct platform_driver.

See https://patchwork.kernel.org/patch/5894/

We should probably add some code to driver_register() to let it refuse
to register drivers with a 'platform_bus_type'.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
