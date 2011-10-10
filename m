From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Oct 2011 10:25:01 -0700
Subject: [PATCH] ARM: OMAP: omap_device: Add omap_device_{alloc, delete,
	register}_ss
In-Reply-To: <CAK=WgbbqG4qFAafJ49jdYwf19whxBGhtywTWVTnsejZ0F_ekog@mail.gmail.com>
	(Ohad Ben-Cohen's message of "Mon, 10 Oct 2011 09:37:08 +0200")
References: <1317833693-21105-1-git-send-email-ohad@wizery.com>
	<CAK=WgbbqG4qFAafJ49jdYwf19whxBGhtywTWVTnsejZ0F_ekog@mail.gmail.com>
Message-ID: <87hb3giwsy.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> Hi Kevin,
>
> On Wed, Oct 5, 2011 at 6:54 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Split omap_device_build_ss() into two smaller functions:
> ...
>> This patch is considered an interim solution until DT fully materializes
>> for omap; at that point, this functionality will be removed.
>
> Good news: we might not need this after all.

Great.

> I need the remoteproc devices to exists at ->reserve() time, so I can
> assign them a private CMA pool, which means I can't wait for
> omap_device_build_ss() and must create the devices beforehand.
>
> ... which makes Benoit's alloc/delete methods perfect for me.
>
> So please hold this one off for now. I'd just need a s/static// patch
> that will allow me to use Benoit's methods outside of omap_device.c,
> but I'll wait for things to settle down a bit before sending it, to
> minimize this kind of churn.

OK.  Sounds good.

Thanks,

Kevin

> Thanks and sorry for the noise,
> Ohad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
