From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Dec 2010 19:07:46 +0530
Subject: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
	L2 cache
In-Reply-To: <4D0F5B15.1020309@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-6-git-send-email-nm@ti.com>
	<9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
	<4D0F41BB.2070606@ti.com>
	<eb91f91221d31f1c74366590a4fb0900@mail.gmail.com>
	<4D0F553E.1060301@ti.com>
	<e6ba48e58d90204a23a5e948700a5166@mail.gmail.com>
	<4D0F5B15.1020309@ti.com>
Message-ID: <e6cc70b2642b16d1a0f981cacadef7c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nishanth Menon [mailto:nm at ti.com]
> Sent: Monday, December 20, 2010 7:03 PM
> To: Santosh Shilimkar
> Cc: linux-omap; linux-arm; Jean Pihet; Kevin; Tony
> Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while
> invalidating L2 cache
>
> Santosh Shilimkar had written, on 12/20/2010 07:29 AM, the following:
> [..]
> > So may be you could update the change log something like below.
> >
> > While coming out of MPU OSWR/OFF states, L2 controller is reseted.
> > The reset behavior is implementation specific as per ARMv7 TRM and
> > hence $L2 needs to be invalidated before it's use. Since the
> > AUXCTRL register is also reconfigured, disable L2 cache before
> > invalidating it and re-enables it afterwards. This is as per
> > Cortex-A8 ARM documentation.
> > Currently this is identified as being needed on OMAP3630 as the
> > disable/enable is done from "public side" while, on OMAP3430, this
> > is done in the "secure side".
> Thanks, will update the rev5 patch with this commit log.
>
Sure. With that change you could add,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
