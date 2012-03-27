From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 27 Mar 2012 05:12:07 +0000
Subject: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
In-Reply-To: <4F70AA82.3000204@ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com>
 <4F6D0569.6080203@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com>
 <4F70AA82.3000204@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317BD6E2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, Mar 26, 2012 at 23:12:26, Hunter, Jon wrote:
> Also, I don't see where the gpmc_child->res and gpmc_child->num_res are 
> actually used. Are these needed?

These are for the peripheral resources not in control of GPMC, like
gpio irq. These are copied in gpmc_create_child.

> > Gpmc_device_data is dedicated to each CS, gpmc_pdata is required
> > at least to inform driver about clock rate.
> 
> Ok, understood! So the struct gpmc_device_pdata only has a single 
> chip-select entry and so looking at the code you will have multiple 
> instances of this structure of a gpmc device that uses more than one 
> chip-select. Any reason you did it this way and not have a single pdata 
> struct for each device defining all chip-selects it uses?

When coding started, multiple CS for a peripheral was not taken into
consideration, later handling multiple CS was incorporated making it
this way. But your suggestion seems better to me, will see if code can
modified accordingly in later patch series (v2 already sent)

> 
> > Generally, as the change involved moving a lot of code, seems more reviews
> > are on those than the actual changes than what I intended to get reviewed,
> > next patch series will be modified not to move existing code, hence some
> > of your suggested changes may not be present in it, probably those to be
> > done as another cleanup patch.
> 
> Yes I understand. However, it is a good opportunity to clean some of 
> this up even if it is existing code :-)

Ok

Regards
Afzal
