From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Fri, 29 Sep 2017 14:20:54 +0000
Subject: [PATCHv2 2/7] usb: dwc2: add support for STM32F7 USB OTG HS
In-Reply-To: <1503930018-536-3-git-send-email-amelie.delaunay@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
 <1503930018-536-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <a0f2971e-d41a-01bb-88e1-8ffed786e954@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gentle ping for driver review submitted on August 28th.

Thanks,
Amelie

On 08/28/2017 04:20 PM, Amelie Delaunay wrote:
> This patch adds the dwc2_set_params function for STM32F7 USB OTG HS.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   drivers/usb/dwc2/params.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index a3ffe97..d5b672d 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -136,6 +136,15 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
>   	p->activate_stm_fs_transceiver = true;
>   }
>   
> +static void dwc2_set_stm32f7_hsotg_params(struct dwc2_hsotg *hsotg)
> +{
> +	struct dwc2_core_params *p = &hsotg->params;
> +
> +	p->host_rx_fifo_size = 622;
> +	p->host_nperio_tx_fifo_size = 128;
> +	p->host_perio_tx_fifo_size = 256;
> +}
> +
>   const struct of_device_id dwc2_of_match_table[] = {
>   	{ .compatible = "brcm,bcm2835-usb", .data = dwc2_set_bcm_params },
>   	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params  },
> @@ -154,6 +163,8 @@ const struct of_device_id dwc2_of_match_table[] = {
>   	{ .compatible = "st,stm32f4x9-fsotg",
>   	  .data = dwc2_set_stm32f4x9_fsotg_params },
>   	{ .compatible = "st,stm32f4x9-hsotg" },
> +	{ .compatible = "st,stm32f7-hsotg",
> +	  .data = dwc2_set_stm32f7_hsotg_params },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
> 
