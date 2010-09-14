From: cjb@laptop.org (Chris Ball)
Date: Tue, 14 Sep 2010 04:03:20 +0100
Subject: [PATCH V8] mmc : Add i.MX21 support to mxcmmc driver
In-Reply-To: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
References: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
Message-ID: <20100914030318.GA10782@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel, Sascha, 

On Fri, Sep 10, 2010 at 12:02:44AM +0200, Martin Fuzzey wrote:
> Even though the i.MX21 SDHC module has the same revision number as the i.MX27
> one there are a few differences!!
>         Some interrupt enables are inverted.
>         FIFO is only 16 bits wide.
>         The argument is written to 2x16bit registers (vs 1x32).
>         Interrupts must be acknowledged via the INT_CNTR register.
>         Card clock must be enabled for each request.
> 	For writes DMA must be enabled on command response not before.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> Changes from V7 (February 2010):
> Rebased to 2.6.36-rc3
> 
> arch/arm/mach-imx/clock-imx21.c |    4 +
> drivers/mmc/host/mxcmmc.c       |  153 ++++++++++++++++++++++++++++++---------
> 2 files changed, 120 insertions(+), 37 deletions(-)

Any feedback on this patch from Martin?  

https://patchwork.kernel.org/patch/178242/

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
