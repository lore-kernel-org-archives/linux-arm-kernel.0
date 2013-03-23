From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 23 Mar 2013 12:25:28 +0530
Subject: [PATCH 4/4] dmaengine: dw_dmac: simplify master selection
In-Reply-To: <1363963401-7924-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1363963401-7924-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1363963401-7924-5-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <CAKohpo=ebMW97YhxFT+MpQtJF9M4pa8KNqpLWiDCuQtFPD+LnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2013 20:13, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The patch to add the common DMA binding added a dummy dw_dma_slave
> structure into the dw_dma_chan structure in order to configure the
> masters correctly. It turns out that this can be simplified if we
> pick the DMA masters in the dwc_alloc_chan_resources function instead
> and save them in the dw_dma_chan structure directly.
>
> This could be simplified further once all users that today use
> dw_dma_slave for configuration get converted to device tree based
> setup instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/dma/dw_dmac.c      | 76 ++++++++++++++++++----------------------------
>  drivers/dma/dw_dmac_regs.h |  5 ++-
>  2 files changed, 33 insertions(+), 48 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
