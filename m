From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 23 Aug 2010 12:05:19 +0200
Subject: [PATCH 2/3] arm: return both physical and virtual addresses
	from addruart
In-Reply-To: <1282553423.739278.339711204256.2.gpush@pororo>
References: <1282553423.737985.983362819420.0.gpush@pororo>
	<1282553423.739278.339711204256.2.gpush@pororo>
Message-ID: <20100823100519.GA8018@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +		.macro	addruart_current, rx, tmp1, tmp2
> +		addruart	\tmp1, \tmp2
> +		mrc		p15, 0, \rx, c1, c0
> +		tst		\rx, #1
> +		moveq		\rx, \tmp1
> +		movne		\rx, \tmp2
> +		.endm
Don't you need to depend on MMU somehow to do this in generic code?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
