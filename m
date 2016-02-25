From: ynvich@gmail.com (Sergei Ianovich)
Date: Thu, 25 Feb 2016 20:09:43 +0300
Subject: [PATCH] spi: lp-8841: return correct error code from probe
In-Reply-To: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
References: <1456400265-3068525-1-git-send-email-arnd@arndb.de>
Message-ID: <1456420183.23036.40.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-25 at 12:37 +0100, Arnd Bergmann wrote:
> The spi_lp8841_rtc_probe() function misses an initialization of the
> return code when it fails to get its memory resource, as gcc notices:
> 
> drivers/spi/spi-lp8841-rtc.c: In function 'spi_lp8841_rtc_probe':
> drivers/spi/spi-lp8841-rtc.c:239:9: error: 'ret' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This changes the code to propagate the error from
> devm_ioremap_resource().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7ecbfff6711f ("spi: master driver to enable RTC on ICPDAS LP-
> 8841")

Tested-by: Sergei Ianovich <ynvich@gmail.com>
