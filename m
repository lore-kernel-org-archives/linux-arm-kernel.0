From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 18 Nov 2011 17:58:14 +0000
Subject: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer
 when device is present
In-Reply-To: <878vne5zeg.fsf@ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
 <8762irg73n.fsf@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
 <874ny37hdv.fsf@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A8904BF32@DBDE01.ent.ti.com>
 <878vne5zeg.fsf@ti.com>
Message-ID: <E28AAFD00EFAA646AE3DF9B89CD24A89052B4A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Friday, November 18, 2011 12:51 AM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Koyamangalath, Abhilash
> Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with 
> voltage layer when device is present
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> [...]
> 
> >> 
> >> If PMIC is not TWL family, then I don't expect any functions in
> >> twl_common.c to be called.
> >
> > This is the reason I wanted to know if the check on ".irq" in the
> > patch is sufficient. If any PMIC requires & sets 
> "pmic_i2c_board_info.irq"
> > then both omap3_twl_init() and omap4_twl_init() will be called.
> 
> Only TWL PMICs should be calling these functions, as they are in code
> for TWL PMICs *only*.
> 
> If you have a non-TWL PMIC, then you should not be using the 
> omap_pmic_*
> functions.
> 
> Admittedly, these omap_pmic_* functions should be renamed to be clear
> that they are TWL specific.

Thanks. We also need mechanism - may be name - to identify the PMIC family
at this stage; and that should be used to select the corresponding init function.

~sanjeev

> 
> Kevin
> 
