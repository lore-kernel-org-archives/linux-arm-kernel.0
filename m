From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 26 Nov 2012 05:19:24 +0000
Subject: [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off to rtc driver
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA78AA0@DBDE01.ent.ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-2-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA78AA0@DBDE01.ent.ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC4C13C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:17:02, AnilKumar, Chimata wrote:
> +Andrew Morton
> 
> On Tue, Nov 20, 2012 at 15:18:43, AnilKumar, Chimata wrote:
> > From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> > 
> > Add system power off control to rtc driver which is the in-charge
> > of controlling the BeagleBone system power. The power_off routine
> > can be hooked up to "pm_power_off" system call.
> > 
> > System power off sequence:-
> > * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
> > * Enable PMIC_POWER_EN in rtc module
> > * Set rtc ALARM2 time
> > * Enable ALARM2 interrupt
> > 
> > Added while (1); after the above steps to make sure that no other
> > process acquire cpu. Otherwise we might see an unexpected behaviour
> > because we are shutting down all the power rails of SoC except RTC.
> 

Reviewed-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
