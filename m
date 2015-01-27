From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Jan 2015 08:50:16 -0800
Subject: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
In-Reply-To: <54C777CE.1070900@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
 <54C61938.8000303@ti.com> <20150126154936.GC28663@atomide.com>
 <54C777CE.1070900@ti.com>
Message-ID: <20150127165016.GJ28663@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150127 03:37]:
> On 26/01/15 17:49, Tony Lindgren wrote:
> 
> >> I'm not sure if I miss something, but regmap_write does not protect from
> >> problems if there are multiple users for the same registers. You need to
> >> use regmap_update_bits() to get a protected read/write sequence, in
> >> which you can change only the bits that you want to change.
> > 
> > To me it seems that issue can be fixed by making all the code use regmap.
> > AFAIK that should work for the legacy code too.
> 
> Even if everybody uses regmap, doing
> 
> v = regmap_read()
> modify v
> regmap_write(v)
> 
> is racy. regmap_update_bits() has to be used to protect the read/write
> sequence. Which may be somewhat challenging at times with some strange
> registers, the like Roger Q encountered recently related to CAN.

Yeah that's a good point.

Regards,

Tony
