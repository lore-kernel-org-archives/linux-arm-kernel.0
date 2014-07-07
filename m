From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Mon, 07 Jul 2014 18:19:35 +0900
Subject: [PATCHv2 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
In-Reply-To: <1404128960-27225-6-git-send-email-jh80.chung@samsung.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
 <1404128960-27225-6-git-send-email-jh80.chung@samsung.com>
Message-ID: <000d01cf99c4$920eb1b0$b62c1510$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for late review.
If you're in progress for next, please consider it.

On Mon, June 30, 2014, Jaehoon Chung wrote:
> Replaced the "disable-wp" into host's quirks.
> (Because the slot-node is removed at dt-file.)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..6c5d696 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -994,10 +994,11 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>  {
>  	int read_only;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci_board *brd = slot->host->pdata;
>  	int gpio_ro = mmc_gpio_get_ro(mmc);
> 
>  	/* Use platform get_ro function, else try on board write protect */
> -	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
It would be better to use host->quirks instead of brd->quirks
It's finally updated with host->pdata->quirks on probing.

Thanks,
Seungwon Jeon
