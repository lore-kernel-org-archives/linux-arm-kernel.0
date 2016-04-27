From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 09:19:16 +0300
Subject: [RESEND PATCH v2 2/7] usb: xhci: plat: attach the usb_phy to the
 correct hcd
In-Reply-To: <20160427135946.3b983890@xhacker>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-3-git-send-email-jszhang@marvell.com>
 <87potbpqkh.fsf@intel.com> <20160427135946.3b983890@xhacker>
Message-ID: <87h9eno9p7.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jisheng Zhang <jszhang@marvell.com> writes:
> Dear Felipe,
>
> On Wed, 27 Apr 2016 08:29:34 +0300 Felipe Balbi wrote:
>
>> Hi,
>> 
>> (Cc authors and maintainer, otherwise you're patch might be forgotten ;-)
>
> Thanks a lot for the kind remind. I just run get_maintainer.pl to get the
> To and Cc lists. It seems Mathias's email changed, MAINTAINERS need to updated.
>
>> 
>> Jisheng Zhang <jszhang@marvell.com> writes:
>> > Commit 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") adds the
>> > usb_phy for usb3, but it attached the usb_phy to incorrect hcd. The  
>> 
>> where did you see that's the USB3 phy ? I can't see it.
>
> Commit 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") says:
>
> "The Marvell Armada 385 AP needs a dumb phy in order to enable the USB3 VBUS."

That could be a typo. VBUS is defined by the original USB specification
and there is only a single VBUS ping for all speeds ;-)

> So I think it means USB3 phy.

we should ask patch author :-)

> Here I have two questions: Per my understanding, usb_phy is deprecated, all
> users and new code are encouraged to use generic phy. I think there must
> be some special reason commit 7b8ef22ea547 still made use of usb_phy, could
> I know what's the reason?

I don't know, maybe author knows

> And could the "USB3 VBUS" support be achieved through regulator framework?

depends on how the PHY is integrated but, IMO, it should be doable and
is probably preferrable.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/4ccee2e6/attachment.sig>
