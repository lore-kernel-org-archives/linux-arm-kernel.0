From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 14:39:25 +0530
Subject: [PATCH v2 2/2] phy: sun4i-usb: Replace the deprecated extcon API
In-Reply-To: <1483071089-8362-3-git-send-email-cw00.choi@samsung.com>
References: <1483071089-8362-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161230041136epcas5p4719845a9e04914e91dd6dac1a5d257ef@epcas5p4.samsung.com>
 <1483071089-8362-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <587C8DC5.5040001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 30 December 2016 09:41 AM, Chanwoo Choi wrote:
> This patch replaces the deprecated extcon API as following:
> - extcon_set_cable_state_() -> extcon_set_state_sync()
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

merged both the patches in this series.

Thanks
Kishon
> ---
>  drivers/phy/phy-sun4i-usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index bf28a0fdd569..eae171e18043 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -534,7 +534,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
>  	mutex_unlock(&phy0->mutex);
>  
>  	if (id_notify) {
> -		extcon_set_cable_state_(data->extcon, EXTCON_USB_HOST,
> +		extcon_set_state_sync(data->extcon, EXTCON_USB_HOST,
>  					!id_det);
>  		/* When leaving host mode force end the session here */
>  		if (force_session_end && id_det == 1) {
> @@ -547,7 +547,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
>  	}
>  
>  	if (vbus_notify)
> -		extcon_set_cable_state_(data->extcon, EXTCON_USB, vbus_det);
> +		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
>  
>  	if (sun4i_usb_phy0_poll(data))
>  		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
> 
