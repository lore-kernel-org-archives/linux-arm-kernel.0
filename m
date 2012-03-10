From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Mar 2012 19:24:31 +0000
Subject: [PATCH 1/2] ARM: at91: only RM9200 has ISA-style PIO
In-Reply-To: <1331405075-3231-1-git-send-email-alan@signal11.us>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
 <1331405075-3231-1-git-send-email-alan@signal11.us>
Message-ID: <201203101924.31710.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 March 2012, Alan Ott wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most at91 systems have no support for PCMCIA or other
> PC-style buses, so we can select NO_IOPORT in order to
> disable compilationf or all drivers that need these.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>

Hi Alan,

You forgot to Cc the at91 maintainers on this patch (and on patch 0).
Also, this patch relies on the another series I did to redefine
the meaning of CONFIG_NO_IOPORT while renaming the existing one to
CONFIG_NO_IOPORT_MAP. This patch will have to wait for the other
series.

	Arnd
