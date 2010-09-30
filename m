From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Sep 2010 15:29:14 +0200
Subject: [PATCH] Fixing ethernet driver compilation error for i.MX31
	ADS board
In-Reply-To: <1285851444-18123-1-git-send-email-ian@opensource.wolfsonmicro.com>
References: <1285851444-18123-1-git-send-email-ian@opensource.wolfsonmicro.com>
Message-ID: <20100930132914.GP29811@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Thu, Sep 30, 2010 at 01:57:24PM +0100, Ian Lartey wrote:
> This is only a partial revert of "ARM: mx3/mx31ads: fold board header in its only user"
> [commit ccfa7c269843001077df02d98918c6c9bde91395)]
> 
> As some of the the board defines are also used in the cs89x0 ethernet driver by the i.MX31 ADS.
Can you please line break the commit log.  AFAIK up to 76 chars are
usual for the kernel.

Hmmm, I took a look into drivers/net/cs89x0.c.  This driver definitly
needs a cleanup, e.g. should start to provide a platform driver.
Maybe it can even be merged with drivers/net/mac89x0.c?

I think the best for know would be the following:

 - reintroduce mach/board-mx31ads.h but only defining the symbols used
   by cs89x0 together with a comment saying that the constants are
   needed for the cs89x0 ethernet driver.

 - In a second patch add CS89x0 to mx31_defconfig

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
