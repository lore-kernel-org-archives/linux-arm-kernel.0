From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 26 Apr 2011 12:09:21 +0200
Subject: [PATCH v6 1/3] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <4DB63360.8010908@freescale.com>
References: <1303267549-18377-1-git-send-email-b32955@freescale.com>
	<1303267549-18377-2-git-send-email-b32955@freescale.com>
	<19887.57747.43423.753598@ipc1.ka-ro>
	<4DB63360.8010908@freescale.com>
Message-ID: <19894.39377.436330.612744@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> Hi:
> > Huang Shijie writes:
> >> +/* debug control */
> >> +int gpmi_debug;
> >> +
> > This could be a module_param.
> >
> I think the module_param is not easy to use.
> I want to know the log when the gpmi driver is running, and change the 
> log level as soon
> as my need changs.
> 
> So I prefer to use the origin method.
> 
> 
|static int debug;
|module_param(debug, int, S_IRUGO | S_IWUSR);
is all you need to do exactly what you want.

You can write to /sys/module/imx28-gpmi-nfc/parameters/debug at any
time to change the debug level.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
