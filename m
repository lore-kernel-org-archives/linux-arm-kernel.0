From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 20 Dec 2012 04:20:04 +0000
Subject: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
In-Reply-To: <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 07:43:50, Paul Walmsley wrote:
> On Tue, 18 Dec 2012, Hebbar Gururaja wrote:
> 
> > From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> > 
> > omap4_cminst_wait_module_ready() checks if register offset is NULL.
> > 
> > int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> > 				   u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> 
> We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
> listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
> What's going to happen in those cases?

Hmm. This is a special case to me. Let me go back and do some review.
Will be back with some more details.

> 
> 
> - Paul
> 


Regards, 
Gururaja
