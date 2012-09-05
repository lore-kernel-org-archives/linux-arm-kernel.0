From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 09:54:45 -0700
Subject: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
In-Reply-To: <50474FC0.6010805@ti.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005230.28732.1131.stgit@muffinssi.local>
 <20120831235212.GS1303@atomide.com> <50474FC0.6010805@ti.com>
Message-ID: <20120905165445.GD1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 06:12]:
> Hi Tony,
> 
> On 09/01/2012 02:52 AM, Tony Lindgren wrote:
> > 
> > ..but irq_base here is still in use as that's where the value from
> > irq_alloc_descs() is being stored to. So I'll drop the changes to
> > struct twl6040 from this patch as otherwise twl6040 code won't compile.
> > 
> > Turns out I did not have twl6040 selected in any of the testconfigs
> > that I ran.
> 
> I store the irq_base in a private data for the MFD driver so child drivers can
> request the correct IRQ.
> 
> You can safely remove the irq_base from twl6040_platform_data struct

Can you please do a patch for that against testing-cleanup branch? That
way we'll know that the twl changes get tested for audio ;)

Maybe also check if Felipe's earlier patch also has something else that
can be removed? That's the "[PATCH] arm: omap: drop unused IRQ defines":

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/103274.html#

Regards,

Tony
