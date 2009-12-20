From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun, 20 Dec 2009 13:22:22 +0100
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <4B27C808.7080800@warmcat.com>
References: <200912151443.59761.jbe@pengutronix.de>
	<4B27C808.7080800@warmcat.com>
Message-ID: <200912201322.23013.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Dienstag, 15. Dezember 2009, Andy Green wrote:
> > s3c2440-sdi s3c2440-sdi: running at 0kHz (requested: 0kHz).
> > s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).
> >
> > mmc0: new SD card at address 8d7e
> > mmcblk0: mmc0:8d7e SD02G 1.83 GiB
> >   mmcblk0: p1 p2
> >
> > Any idea why most of the cards do not work?
>
> -110 is timeout... it might be worth setting CONFIG_PRINTK_TIME and
> looking to see what the real time looks like in both cases.
>
> I guess you have the pullups on your PCB OK for the MMC bus (everything
> except CLK),

Yes, all signals except the clock are pulled up to +5V (10K), and a small cap 
to ground (don't know their values yet).

> and you looked with your scope that power is OK there from early boot

I started to add some caps close to the socket. Now more cards are working 
with a 2.6.32.2 kernel. But when I boot a 2.6.31 kernel instead, some are 
still do not work. Curious.

> and the signals look well-formed.  (And the clock is 400kHz).

To be continued...

> I noticed that at 115kbps console set on the kernel commandline on an
> iMX31, I can cause SD Card boot we use to fail like you describe at the
> moment just by setting loglevel=8 on the commandline.  So try one of the
> "bad" cards at loglevel=4 and see if that changes anything.

I tried it, but it makes no difference.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
