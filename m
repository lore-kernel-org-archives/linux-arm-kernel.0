From: hemantp@ti.com (Pedanekar, Hemant)
Date: Sat, 1 Oct 2011 06:24:29 +0530
Subject: [PATCH v3 2/3] ARM: OMAP: TI814X: Add cpu type macros and
	detection support
In-Reply-To: <alpine.DEB.2.00.1109291443160.26728@utopia.booyaka.com>
References: <1317258560-30408-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1109291443160.26728@utopia.booyaka.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4EC56A8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Paul Walmsley wrote on Friday, September 30, 2011 2:17 AM:

> Hello Hemant,
> 
> a few comments:
> 
> On Thu, 29 Sep 2011, Hemant Pedanekar wrote:
> 
>> This patch adds cpu type, macros for identification of TI814X device.
>> 
>> Note that following update to common OMAP data structures is made:
>> 
>> cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
>> clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to
>> u16 from u8. 
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> Also, the opp2xxx.h change looks spurious, is that really needed?
> 
I changed prcm_config.flags to accommodate cpu_mask change, as cpu_mask
is used with prcm_config.flags (mostly) in clkt2xxx_virt_prcm_set.c as
below:

prcm->flags & cpu_mask

And flags is assigned in opp2420_data.c (e.g., RATE_IN_242X)

But yes, these are already defined RATE_INs and do not cross 8-bits,
so no warnings even if flags is 8-bit and cpu_mask changed to 16-bit.

What is your suggestion?

I see you mentioned "Also" in the above comment, but didn't see any
comment preceeding.
  
> Could you please split the clock-related changes into a
> separate patch?
> Then this patch would just be the id.c and cpu.h changes.
> 
> Other than that, the patch looks okay to me.
> 
> 
> - Paul

Will do that.

Thanks.
   Hemant
