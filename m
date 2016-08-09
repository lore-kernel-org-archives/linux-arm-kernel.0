From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 9 Aug 2016 14:29:17 +0800
Subject: [RESEND PATCH] usb: hub: change CLEAR_FEATURE to SET_FEATURE
In-Reply-To: <1470713487-7596-1-git-send-email-yonglong.wu@mediatek.com>
References: <1470713487-7596-1-git-send-email-yonglong.wu@mediatek.com>
Message-ID: <CAL411-pcupjH7xBH9rR8hs5_EGDidcO3JFkRtE4ENpgq7qvmcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 11:31 AM, Yonglong Wu <yonglong.wu@mediatek.com> wrote:
> From: Yonglong Wu <yonglong.wu@mediatek.com>
>
> According to USB30 specification, the Function Remote Wakeup field can be
> modified by the SetFeature() requests. SetFeature() is recommended to use.
>
> Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> ---
>  drivers/usb/core/hub.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bee1351..a6f5095 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3111,7 +3111,7 @@ static int usb_disable_remote_wakeup(struct usb_device *udev)
>                                 USB_CTRL_SET_TIMEOUT);
>         else
>                 return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -                               USB_REQ_CLEAR_FEATURE, USB_RECIP_INTERFACE,
> +                               USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
>                                 USB_INTRF_FUNC_SUSPEND, 0, NULL, 0,
>                                 USB_CTRL_SET_TIMEOUT);
>  }
> --
> 1.7.9.5
>

This requirement is so strange, would you please list the detail
chapter at specification.

Peter
