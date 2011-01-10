From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 10 Jan 2011 20:23:42 +0100
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <87fwt069ys.fsf@macbook.be.48ers.dk>
References: <AANLkTimGTVybe4LmspxWj6vkM_zNnPcaUbk6sqvpJ032@mail.gmail.com>
	<1294673540l.26200l.0l@i-dmzi_al.realan.de>
	<87fwt069ys.fsf@macbook.be.48ers.dk>
Message-ID: <20110110192342.GF24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 04:43:07PM +0100, Peter Korsgaard wrote:
> >>>>> "Anders" == Anders Larsen <al@alarsen.net> writes:
> 
> Hi,
> 
>  >> Is there a known interaction with this and the JTAG controller?
> 
>  Anders> indeed there is - disabling the processor clock blocks JTAG debugging.
> 
> Ok - And apparently it completely blocks the JTAG controller, so you
> cannot even put it in bypass mode and access other devices on the same
> JTAG chain.
This is a quite usual violation of ieee-1949.1-2001 (i.e. the jtag
standard (don't know if there is a newer version?)).  I really wonder
why it's so hard to get this right.  There is the availability of
"compiliance-enable patterns" that allow to say:  "My device is only
jtaggable if this input is 1."  Why not power the jtag block with such an
input?  Software doesn't need (and actually must not) have the ability
to disable the jtag clock.  Moreover this way the chip doesn't need any
current to keep jtag on and still a developer needing jtag doesn't need
to change any source code, but only needs a jumper on his devboard.

It could be so easy when all people knew what they do.

sigh
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
