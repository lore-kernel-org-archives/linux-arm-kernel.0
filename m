From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Jul 2011 16:08:58 +0900
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <4E16664D.7010206@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<4E165ECD.9070905@ti.com>
	<CAMbhsRT-Z4AmYmen9B9+mJ+c5YWyVbcsx0mykrn7L_JxgOLVDg@mail.gmail.com>
	<4E16664D.7010206@ti.com>
Message-ID: <002801cc3d3d$edd60f70$c9822e50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar wrote:
> 
> On 7/7/2011 6:41 PM, Colin Cross wrote:

Hi all,

Now Samsung prepares updating PM on EXYNOS4210 and save/restore GIC is
needed for that.
Actually, it works fine on EXYNOS4210 with this.

But we have some concern about following.

> +/*
> + * Saves the GIC distributor registers during suspend or idle.  Must be
called
> + * with interrupts disabled but before powering down the GIC.  After
calling
> + * this function, no interrupts will be delivered by the GIC, and another
> + * platform-specific wakeup source must be enabled.
> + */

PMU needs to detect interrupt which can be a wakeup source via GIC before
calling WFI.
Seems there is no problem but I think that can be a hole during very short
time...

So is it needed to disable GIC after saving context?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
