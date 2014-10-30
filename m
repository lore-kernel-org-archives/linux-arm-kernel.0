From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 15:43:43 +0100
Subject: [PATCH] watchdog: at91rm9200: allow building when using device
 tree
In-Reply-To: <20141030153624.6643c1b4@bbrezillon>
References: <1414678534-2677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20141030153624.6643c1b4@bbrezillon>
Message-ID: <2000678.14fQbcst9s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 15:36:24 Boris Brezillon wrote:
> On Thu, 30 Oct 2014 15:15:34 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > When building with device tree, ARCH_AT91RM9200 may not be selected. Allow
> > building that driver by also depending on ARCH_AT91.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 

Doesn't this reintroduce the bug fixed by commit 09549cd0172 ("watchdog:
Revert the AT91RM9200_WATCHDOG dependency")?

At least in 3.18-rc2, the driver still uses at91_st_write/at91_st_read.

	Arnd
