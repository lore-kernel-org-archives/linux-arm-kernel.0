From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 21:04:40 +0200
Subject: [Linaro-mm-sig] [PATCH v4] drivers: of: add return value to
 of_reserved_mem_device_init
In-Reply-To: <1413370902-28187-1-git-send-email-m.szyprowski@samsung.com>
References: <13963062.ORRNOhrvYD@wuerfel>
 <1413370902-28187-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <3202272.i0Lr6KJ3g8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 October 2014 13:01:42 Marek Szyprowski wrote:
> Driver calling of_reserved_mem_device_init() might be interested if the
> initialization has been successful or not, so add support for returning
> error code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This patch fixes build warining caused by commit
> 7bfa5ab6fa1b18f53fb94f922e107e6fbdc5e485 ("drivers: dma-coherent: add
> initialization from device tree"), which has been merged without this
> change and without fixing function return value.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

It also makes sense to encode the information you have below the ---
line as

Fixes: 7bfa5ab6fa1b1 ("drivers: dma-coherent: add initialization from device tree")
