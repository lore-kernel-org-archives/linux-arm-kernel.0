From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 20 Apr 2012 20:26:33 +0800
Subject: [RFC PATCH 00/10 V3] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120420094805.GS20478@pengutronix.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
 <201204200413.56909.marex@denx.de>
 <20120420094805.GS20478@pengutronix.de>
Message-ID: <CAL411-onyB8SJEBoJ2XK=wyHKR0C7SyJtCsoJCDZGatP8HmYZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 5:48 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

>>
>> btw /wrt USB Gadget etc -- how does the drivers/usb/gadget/fsl_udc_core.c and
>> drivers/usb/gadget/ci13xxx_* fit into the big picture? We're gonna use the
>> ci13xxx stuff for Gadget on mx28, correct? Then how does fsl_udc_core.c fit in?
>
> From what I have been told by a collegue the ci13xxx driver works
> better, and from what I have seen the code looks better. So I think mxs
> should use it. i.MX can then use it later aswell. We won't need the
> fsl_udc_core driver anymore then.
>
Oh, I find I lost many discussions using company email.
>From the function and quality level, fsl_udc_core.c is absolutely the
best one for all
i.mx SoCs, as both internal and upstream fsl code use it.

It discussed before:
http://marc.info/?l=linux-usb&m=129906859817430&w=2

I just wonder if ci13xxx_udc.c can support fsl's well as it has below
at comment.

/*
 * Description: MIPS USB IP core family device controller
 *              Currently it only supports IP part number CI13412
 */
I will check with IC guys to see if i.mx's controller is compatible
with CI13412.
If fsl's compatible with CI13412, then mxs can try to use ci13xxx_udc.c to see
if there are any problems, If no problems with kinds of testing,
we can switch all i.mx SoC to ci13xxx_udc.c.

> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html



-- 
BR,
Peter Chen
