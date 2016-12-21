From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 21 Dec 2016 16:20:32 +0900
Subject: [PATCH 1/3] extcon: Add documentation for EXTCON_CHG_USB_* and
 EXTCON_USB_*
In-Reply-To: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
References: <CGME20161221061321epcas2p196fd90254d59164e1195840bdd546fa7@epcas2p1.samsung.com>
 <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
Message-ID: <585A2D40.9000606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016? 12? 21? 15:10, Baolin Wang wrote:
> Current there is both "EXTCON_USB" and "EXTCON_CHG_USB_SDP" which
> both seem to suggest a standard downstream port. But there is no
> documentation describing how these relate.
> 
> Thus add documentation to describe EXTCON_CHG_USB_SDP should always
> appear together with EXTCON_USB, and EXTCON_CHG_USB_ACA would normally
> appear with EXTCON_USB_HOST.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  include/linux/extcon.h |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index b871c0c..6498b05 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -46,7 +46,14 @@
>  #define EXTCON_USB		1
>  #define EXTCON_USB_HOST		2
>  
> -/* Charging external connector */
> +/*
> + * Charging external connector
> + *
> + * When one SDP charger connector was reported, we should also report
> + * the USB connector, which means EXTCON_CHG_USB_SDP should always
> + * appear together with EXTCON_USB. The same as ACA charger connector,
> + * EXTCON_CHG_USB_ACA should always appear with EXTCON_USB_HOST.
> + */

Looks good to me.
But, you use the different word for ACA as following:
I think that 'would normally' is proper in descritpion.

- commit msg : EXTCON_CHG_USB_ACA would normally appear with EXTCON_USB_HOST.
- description: EXTCON_CHG_USB_ACA should always appear with EXTCON_USB_HOST.

>  #define EXTCON_CHG_USB_SDP	5	/* Standard Downstream Port */
>  #define EXTCON_CHG_USB_DCP	6	/* Dedicated Charging Port */
>  #define EXTCON_CHG_USB_CDP	7	/* Charging Downstream Port */
> 

-- 
Regards,
Chanwoo Choi
