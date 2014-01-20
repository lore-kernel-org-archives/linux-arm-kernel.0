From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 20 Jan 2014 13:53:10 +0900
Subject: [PATCH 2/3] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
In-Reply-To: <1390190215-22700-3-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-3-git-send-email-olof@lixom.net>
Message-ID: <52DCABB6.6000000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Olof.

It looks good to me. When use the mmc_of_parse, we can also remove the duplicated property.
I have also worked the patch for using mmc_of_parse().

1. caps2-mmc-hs200-1_8v/1_2v capability can be moved into mmc_of_parse.
then we can remove parsing of dt into dw_mmc.c
2. keep-power-in-suspend/enable-sdio-wakeup can be removed.

If i missed other patch, let me know, plz.

how about?
if you're ok, i will send the patch-set on this week.

Best Regards,
Jaehoon Chung

On 01/20/2014 12:56 PM, Olof Johansson wrote:
> The shared of parse function fills in common options for capabilities,
> etc, but it needs to be called from each driver that wants to make use
> of it. dw_mmc was missing the call.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a776f24..7119f63 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2137,6 +2137,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (!mmc)
>  		return -ENOMEM;
>  
> +	mmc_of_parse(mmc);
> +
>  	slot = mmc_priv(mmc);
>  	slot->id = id;
>  	slot->mmc = mmc;
> 
