From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun, 20 Dec 2009 14:03:59 +0100
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <4B2E1D37.6030100@warmcat.com>
References: <200912151443.59761.jbe@pengutronix.de>
	<200912201322.23013.jbe@pengutronix.de>
	<4B2E1D37.6030100@warmcat.com>
Message-ID: <200912201404.00746.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Sonntag, 20. Dezember 2009, Andy Green wrote:
> >> and you looked with your scope that power is OK there from early boot
> >
> > I started to add some caps close to the socket. Now more cards are
> > working with a 2.6.32.2 kernel. But when I boot a 2.6.31 kernel instead,
> > some are still do not work. Curious.
>
> Where did you connect the caps and what value are they?

4u7 and 100n, at the power supply pins of the SD socket. But...

> Unless you have a very long bus to the SD Card, any caps on signal lines
> are just there to suppress EMI and are not required for operation.
>
> If you added a cap between power and ground at the socket and it started
> behaving better, I would remove the cap and watch the power carefully
> with a 'scope during boot.

...this seems not the problem...

> Also I would try the "thumb test" as a sanity check against the socket,
> try a bad card that never works with your thumb applying gentle pressure
> to the socket.

...I added some delays to the driver, when it switches the clocks. You are 
right: The driver states "switching to 400kHz" ----- but nothing happen! 
There is no clock at the SD card! Not till it switches to the 25MHz clock. It 
seems the driver is bogus (current 2.6.32.2). Time for bug hunting now. :-)

Thanks for pointing me to the right direction.

Regards
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
