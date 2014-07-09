From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Wed, 9 Jul 2014 12:11:44 +0200
Subject: [PATCH 1/2] usb: renesas_usbhs: add R-Car Gen. 2 init and power
 control
In-Reply-To: <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
References: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <CAO3366ySCau6A7hXTDzHy4COH8he5YrB2A_kNxuua8qejeH8VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 2:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulrich
>
> Thank you for your patch

Thank you for your review.

>> @@ -186,6 +192,8 @@ struct renesas_usbhs_platform_info {
>>        * driver use these param for some register
>>        */
>>       struct renesas_usbhs_driver_param       driver_param;
>> +
>> +     struct usb_phy *phy;
>>  };
>
> Using renesas_usbhs_platform_info for *phy is not good idea from my point of view.
> Because its memory is located on platform side.
> (this is the reason why usbhs_probe() using memcpy() for getting info->xxx)
>
> I guess struct usbhs_priv is good place,
> and you can use usbhs_pdev_to_priv() for this purpose ?

Yes, that seems more natural anyway.

CU
Uli
