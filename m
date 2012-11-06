From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 6 Nov 2012 06:06:20 +0000
Subject: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for AM33XX
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 23:27:52, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 12:28:36, Hiremath, Vaibhav wrote:
> [...]
> > > -	u32 mask = 1 << shift;
> > > -
> > > -	/* Check the current status to avoid  de-asserting the line twice */
> > > -	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
> > > -		return -EEXIST;
> > 
> > Any specific reason why you have removed this check?
> 
> During bootup the hardreset line is asserted, so wouldn't that check lead
> to the function always returning without doing anything?
> 

The check is,

/* Check the current status to avoid  de-asserting the line twice */
if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
	return -EEXIST;


The code is checking whether the line is already de-asserted (== 0), so I am 
not sure how this will change if hardreset line is asserted during bootup.

Thanks,
Vaibhav
