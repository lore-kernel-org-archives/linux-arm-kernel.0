From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 04 Aug 2016 10:18:42 +0900
Subject: [PATCH] UHS-SD card for Hisilicon Hikey
In-Reply-To: <1470219733-113975-1-git-send-email-kid.jin@hisilicon.com>
References: <CGME20160803102743epcas1p463b9648675d7324251f7a504f419d4db@epcas1p4.samsung.com>
 <1470219733-113975-1-git-send-email-kid.jin@hisilicon.com>
Message-ID: <952b56f0-97b0-1e8f-ef54-b6b1264fc18d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/2016 07:22 PM, Jin Guojun wrote:
> mmc: dw_mmc-k3: Hisilicon Hikey have no tuning function in dw_mmc-k3.c,so we must do the tuning function stub when we init UHS card.

Refer to Shawn's previous comment.
"No, please amend the commit title line as "mmc: dw_mmc: xxxxx"
And add "linux-mmc at vger.kernel.org", patch version, Changelog, etc..

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 8e9d886..6247894 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -131,11 +131,17 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  	host->bus_hz = clk_get_rate(host->biu_clk);
>  }
>  
> +static int dw_mci_hi6220_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
> +{
> +	return 0;
> +}
> +
>  static const struct dw_mci_drv_data hi6220_data = {
>  	.caps			= dw_mci_hi6220_caps,
>  	.switch_voltage		= dw_mci_hi6220_switch_voltage,
>  	.set_ios		= dw_mci_hi6220_set_ios,
>  	.parse_dt		= dw_mci_hi6220_parse_dt,
> +	.execute_tuning		= dw_mci_hi6220_execute_tuning,
>  };
>  
>  static const struct of_device_id dw_mci_k3_match[] = {
> 
