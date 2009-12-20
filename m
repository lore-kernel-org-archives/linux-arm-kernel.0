From: andy@warmcat.com (Andy Green)
Date: Sun, 20 Dec 2009 12:48:55 +0000
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <200912201322.23013.jbe@pengutronix.de>
References: <200912151443.59761.jbe@pengutronix.de>
	<4B27C808.7080800@warmcat.com>
	<200912201322.23013.jbe@pengutronix.de>
Message-ID: <4B2E1D37.6030100@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/09 12:22, Somebody in the thread at some point said:

Hi Juergen -

>> and you looked with your scope that power is OK there from early boot
>
> I started to add some caps close to the socket. Now more cards are working
> with a 2.6.32.2 kernel. But when I boot a 2.6.31 kernel instead, some are
> still do not work. Curious.

Where did you connect the caps and what value are they?

Unless you have a very long bus to the SD Card, any caps on signal lines 
are just there to suppress EMI and are not required for operation.

If you added a cap between power and ground at the socket and it started 
behaving better, I would remove the cap and watch the power carefully 
with a 'scope during boot.

Also I would try the "thumb test" as a sanity check against the socket, 
try a bad card that never works with your thumb applying gentle pressure 
to the socket.

-Andy
