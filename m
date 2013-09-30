From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Sep 2013 10:16:43 +0000 (UTC)
Subject: [PATCH v4 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
In-Reply-To: <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com>
References: <cover.1380179370.git.afzal@ti.com>
 <a6758751113ef93bc912ccefb9cdb0ba383f19d5.1380179370.git.afzal@ti.com>
 <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1309301014220.17980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Paul Walmsley wrote:

> The references to "wkup_pwrdm" on some of these clockdomains don't 
> look right to me.  For example, this clockdomain is listed as being in 
> AM43XX_CM_WKUP_INST, but its enclosing powerdomain is listed as being in 
> AM43XX_PRM_WKUP_INST.  Looks to me like it's best to have two different 
> wakeup powerdomains: one CM_WKUP, and one PRM_WKUP.

Looks like the same problem exists with at least the PER powerdomain also.  
Looks to me like that needs to be split into cm_per and prm_per variants?


- Paul
