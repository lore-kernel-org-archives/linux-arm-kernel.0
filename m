From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 24 Feb 2014 21:41:07 +0300
Subject: [PATCH v11 09/15] usb: phy: Add set_wakeup API
In-Reply-To: <1393208467-6355-10-git-send-email-peter.chen@freescale.com>
References: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
 <1393208467-6355-10-git-send-email-peter.chen@freescale.com>
Message-ID: <530B9243.4020909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/24/2014 05:21 AM, Peter Chen wrote:

> This API is used to set wakeup enable at PHY registers, in that
> case, the PHY can be waken up from suspend due to external events,
> like vbus change, dp/dm change and id change.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>   include/linux/usb/phy.h |   16 ++++++++++++++++
>   1 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 6c0b1c5..c2c6f49 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -111,6 +111,13 @@ struct usb_phy {
>   	int	(*set_suspend)(struct usb_phy *x,
>   				int suspend);
>
> +	/*
> +	 * Set wakeup enable for PHY, in that case, the PHY can be
> +	 * waken up from suspend status due to external events,

    s/waken/woken/

WBR, Sergei
