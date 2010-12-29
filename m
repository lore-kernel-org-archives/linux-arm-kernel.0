From: thomas.ab@samsung.com (Thomas Abraham)
Date: Wed, 29 Dec 2010 09:32:29 +0530
Subject: S3C OTG udc driver isochronous support
In-Reply-To: <AANLkTi=ssBu9FQp3svPBk3i3dPZTd-Dd03h9EyrO0waH@mail.gmail.com>
References: <AANLkTi=ssBu9FQp3svPBk3i3dPZTd-Dd03h9EyrO0waH@mail.gmail.com>
Message-ID: <AANLkTi=nKqX4VQug_rk3TiV2w=UW7ayoDFiHp37qDgyq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 26, 2010 at 10:06 PM, Barry Song <21cnbao@gmail.com> wrote:
> Hi All,
> After checking the S3C OTG udc drivers in drivers/usb/gadget, i didn't
> find it can support isochronous endpoint. According to datasheet of
> S3C6410, EPtype field of DIEPCTLn and DOEPCTLn is read-only. Current
> S3C OTG udc driver list ep0~ep9, which are control endpoint and
> bulk/int endpoint according to the source codes:

Iso transfer type is not yet supported in the s3c otg driver. But the
EPtype field can be programmed as bulk, interrupt or iso endpoint. Iso
transfers have been used on 6410 but that support is not yet posted.

> static struct s3c_udc memory = {
> ? ? ? ?.usb_address = 0,
>
> ? ? ? ?.gadget = {
> ? ? ? ? ? ? ? ? ? .ops = &s3c_udc_ops,
> ? ? ? ? ? ? ? ? ? .ep0 = &memory.ep[0].ep,

<snip>

The drivers/usb/gadget/s3c-hsotg.c file is the s3c usb otg gadget
driver. Are you referring to some other file.

> ep10~ep14 are not in the list. So is it possible ep10~ep14 are iso
> endpoints? I guess only samsung engineers can answer this question.
> And has anybody improved the udc driver to support ISO mode? Here i
> want to use this mode to support g_webcam gadget.

>
> Thanks
> Barry
>
<snip>
