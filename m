From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Dec 2010 11:05:23 +0100
Subject: [PATCH 04/13] ARM: pxa: convert sched_clock() to use new
	infrastructure
In-Reply-To: <E1PTA8m-00079T-Ce@rmk-PC.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
	<E1PTA8m-00079T-Ce@rmk-PC.arm.linux.org.uk>
Message-ID: <20101216100523.GI1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

a very minor nit ...

On Thu, Dec 16, 2010 at 09:28:48AM +0000, Russell King - ARM Linux wrote:
> +	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
The value of ~0 is compiler implementation defined, so in general
~((u32)0) is saver.  (Though I admit that on arm ~0 will probably always
be -1, still I think using the save construct doesn't hurt here.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
