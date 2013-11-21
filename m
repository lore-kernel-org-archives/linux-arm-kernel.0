From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Nov 2013 17:45:56 -0800
Subject: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
In-Reply-To: <20131121000533.GJ10317@atomide.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com>
 <20131120192209.GI10317@atomide.com>
 <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
 <20131121000533.GJ10317@atomide.com>
Message-ID: <20131121014555.GL10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131120 16:06]:
> 
> They at least had interrupts listed looking at commit 3b9b10. Probably
> the thing to do for now is to revert those changes, and see if we can
> just remove the L3 entries from the .dtsi files.

Actually the patch I posted should be able to handle also the
ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3" property in omap4.dtsi,
but we're not currently parsing that as we only look at the children
and not the properties of the OCP bus. Should be fixable, will take a look
tomorrow if this approach makes sense to you.

Regards,

Tony
