From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 9 Aug 2016 10:25:55 +0200
Subject: [RESEND PATCH] usb: hub: change CLEAR_FEATURE to SET_FEATURE
In-Reply-To: <1470730076.4647.10.camel@mhfsdcap03>
References: <1470713487-7596-1-git-send-email-yonglong.wu@mediatek.com>
 <CAL411-pcupjH7xBH9rR8hs5_EGDidcO3JFkRtE4ENpgq7qvmcQ@mail.gmail.com>
 <1470730076.4647.10.camel@mhfsdcap03>
Message-ID: <20160809082555.GA17073@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 04:07:56PM +0800, yonglong.wu wrote:
> Hi,
> On Tue, 2016-08-09 at 14:29 +0800, Peter Chen wrote:
> 
>     On Tue, Aug 9, 2016 at 11:31 AM, Yonglong Wu <yonglong.wu@mediatek.com> wrote:
>     > From: Yonglong Wu <yonglong.wu@mediatek.com>
>     >
>     > According to USB30 specification, the Function Remote Wakeup field can be
>     > modified by the SetFeature() requests. SetFeature() is recommended to use.
>     >
>     > Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
>     > ---
>     >  drivers/usb/core/hub.c |    2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>     > index bee1351..a6f5095 100644
>     > --- a/drivers/usb/core/hub.c
>     > +++ b/drivers/usb/core/hub.c
>     > @@ -3111,7 +3111,7 @@ static int usb_disable_remote_wakeup(struct usb_device *udev)
>     >                                 USB_CTRL_SET_TIMEOUT);
>     >         else
>     >                 return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
>     > -                               USB_REQ_CLEAR_FEATURE, USB_RECIP_INTERFACE,
>     > +                               USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
>     >                                 USB_INTRF_FUNC_SUSPEND, 0, NULL, 0,
>     >                                 USB_CTRL_SET_TIMEOUT);
>     >  }
>     > --
>     > 1.7.9.5
>     >
> 
>     This requirement is so strange, would you please list the detail
>     chapter at specification.
> 
> 
> In USB20 specification, describes in chapter 9.4.5: The Remote Wakeup field can
> be modified by the SetFeature() and ClearFeature() requests using the
> DEVICE_REMOTE_WAKEUP feature selector.
> 
> In USB30 specification, also describes in chapter 9.4.5: The Function Remote
> Wakeup field can be modified by the SetFeature() requests using the
> FUNCTION_SUSPEND feature selector.
> 
> In USB30 specification only mentioned SetFeature().

Can you put this information in the changelog text when you resend this
again?

thanks,

greg k-h
