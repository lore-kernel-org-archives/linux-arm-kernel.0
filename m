From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Sep 2013 11:09:44 +0000 (UTC)
Subject: [PATCH v4 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
In-Reply-To: <52495B03.3050006@ti.com>
References: <cover.1380179370.git.afzal@ti.com>
 <a6758751113ef93bc912ccefb9cdb0ba383f19d5.1380179370.git.afzal@ti.com>
 <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com>
 <52495B03.3050006@ti.com>
Message-ID: <alpine.DEB.2.02.1309301107150.17980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 30 Sep 2013, Afzal Mohammed wrote:

> > The references to "wkup_pwrdm" on some of these clockdomains don't 
> > look right to me.  For example, this clockdomain is listed as being in 
> > AM43XX_CM_WKUP_INST, but its enclosing powerdomain is listed as being in 
> > AM43XX_PRM_WKUP_INST.  Looks to me like it's best to have two different 
> > wakeup powerdomains: one CM_WKUP, and one PRM_WKUP.
> 
> On AM43x, prcm is a single block as in AM335x and is part of wakeup
> domain. This is different from OMAP4 that had separate prm and cm
> blocks. Script also generated the same output.

Why are there two different address offsets for CM_WKUP and PRM_WKUP?  
>From another patch in the series:

+#define AM43XX_PRM_WKUP_INST                           0x2000

...

+#define AM43XX_CM_WKUP_INST                            0x2800



- Paul
