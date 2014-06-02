From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 2 Jun 2014 17:39:51 +0530
Subject: [PATCH 1/2] ARM: dts: Enable USB 3503 hub on exynos5250-snow
In-Reply-To: <CAODwPW8FpsF6vo5Z8_+YXwchwab=7Ltv0nEvP_=907HK232xCg@mail.gmail.com>
References: <1399293056-17143-1-git-send-email-gautam.vivek@samsung.com>
 <536BA9E8.2030306@suse.de> <536BAD05.9070401@samsung.com>
 <CAODwPW8FpsF6vo5Z8_+YXwchwab=7Ltv0nEvP_=907HK232xCg@mail.gmail.com>
Message-ID: <CAFp+6iFbDfWconRZzMhSXFG_RbXF-rnYwraJK1P1tQSb6R+Dkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julius,


On Thu, May 29, 2014 at 4:07 AM, Julius Werner <jwerner@chromium.org> wrote:
> We originally tried using this driver on ChromiumOS and never got it
> to work reliably. IIRC the issue was that if the hub had already been
> initialized by firmware, the USB stack might enumerate it before the
> usb3503 driver is probed and then the later reset will silently
> disrupt that connection. (I think I tried to force the 3503 to probe
> earlier as well, and there was some other issue with that although I
> don't recall the details.)

Ok, there was already a patch posted by you for this[1], which had
quite a much discussion
on it.
Would you like to give some pointers based on that ?
One that Olof had suggested was to use gpio-reset driver which is yet
to make to mainline.
But i think with that too we need to take care of the timing for
resetting the hub before PHY
gets reset.

>
> This will not be an issue for the Snow and Peach_Pi(t) boards (since
> neither of them shipped with firmware that supports this hub), but it
> will be an issue for Spring and Skate. On ChromiumOS we decided to
> carry a local (and admittedly ugly) patch to pull that reset line from
> the USB PHY driver instead, since that's the only way I could get it
> to work in all cases (see http://crosreview.com/58963).
>
> This doesn't mean I'm against this patch per se, just wanted to point
> out the trade-offs.

Thanks for raising the concern, this needs to be addressed.

[1] https://lkml.org/lkml/2013/7/9/486


-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
