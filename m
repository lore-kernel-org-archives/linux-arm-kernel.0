From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 5 Nov 2012 17:57:52 +0000
Subject: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for AM33XX
In-Reply-To: <5097639C.7000800@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 12:28:36, Hiremath, Vaibhav wrote:
[...]
> > -	u32 mask = 1 << shift;
> > -
> > -	/* Check the current status to avoid  de-asserting the line twice */
> > -	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
> > -		return -EEXIST;
> 
> Any specific reason why you have removed this check?

During bootup the hardreset line is asserted, so wouldn't that check lead
to the function always returning without doing anything?

Regards,
Vaibhav
