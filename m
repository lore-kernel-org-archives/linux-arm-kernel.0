From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Jun 2016 00:30:36 +0200
Subject: [PATCH 01/48] clk: at91: replace usleep() by udelay() calls
In-Reply-To: <1465596231-21766-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <11395561.bQatt85IOg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 11, 2016 12:03:04 AM CEST Alexandre Belloni wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> Fix the main and slow clock .prepare() implementations which used to call
> usleep() when the scheduler wasn't ready yet.
> 

Does this have to be called that early? It seems wasteful to always
call udelay() here, when these are functions that are normally
allowed to sleep.

	Arnd
