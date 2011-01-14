From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 14:08:21 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <alpine.LFD.2.00.1101141138480.2678@localhost6.localdomain6>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
	<4D2F6AB7.30800@eukrea.com> <20110113212401.GZ24920@pengutronix.de>
	<4D2FFCBE.3010704@eukrea.com>
	<alpine.LFD.2.00.1101141138480.2678@localhost6.localdomain6>
Message-ID: <20110114130821.GA1434@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 14, 2011 at 11:57:34AM +0100, Thomas Gleixner wrote:
> So there are several things wrong here:
> 
> 1) Using handle_level_irq for an edge interrupt is wrong. That's not
>    restricted to the TS driver problem at hand. That's wrong in
>    general. Other set_type() functions adjust the handler as well when
>    they switch the edge/level types.
That was introduced by 060d20d32ae7c6a20a8eac465795ed5bc9b37f7c.
As a quick test you can try to revert that.  If that helps I can look
deeper into it.  That won't help on at91 though.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
