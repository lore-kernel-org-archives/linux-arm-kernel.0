From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 15 Jan 2014 15:31:45 +0800
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
References: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
 <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <52D63961.1030808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin

Would you mind check whehter this patch solve the issue of "The Samsung 
Arndale board started failing boot from MMC".

I am sorry about that.

On 01/15/2014 03:15 PM, Zhangfei Gao wrote:
> Introdeced from commit b7db86adfa58b
commit should be bf626e5550f24aec24975a0e85ad8e572ca76a6b, from mmc-next

> CDETECT is ingored since IS_ERR_VALUE(!mmc_gpio_get_cd(mmc)) does not work
> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> ---
>   drivers/mmc/host/dw_mmc.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
