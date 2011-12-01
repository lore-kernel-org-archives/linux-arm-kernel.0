From: cjb@laptop.org (Chris Ball)
Date: Thu, 01 Dec 2011 13:10:33 -0500
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
 from 100ms to 1ms
In-Reply-To: <1321944150-12162-1-git-send-email-tony.lin@freescale.com> (Tony
 Lin's message of "Tue, 22 Nov 2011 14:42:30 +0800")
References: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
Message-ID: <87vcq0kvs6.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 22 2011, Tony Lin wrote:
> 1ms is enough for hardware to change the clock to stable.
> 100ms is too long in the tasklet.
>
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> CC: Xiaobo Xie <X.Xie@freescale.com>
> CC: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mmc/host/sdhci-esdhc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index c3b08f1..b97b2f5 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  		| (div << ESDHC_DIVIDER_SHIFT)
>  		| (pre_div << ESDHC_PREDIV_SHIFT));
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> -	mdelay(100);
> +	mdelay(1);
>  out:
>  	host->clock = clock;
>  }

I don't know if 1ms is actually long enough for the clock to stabilize
on all boards, but I'll push this change to mmc-next and we can see if
we get any regression reports.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
