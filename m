From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2018 08:24:46 -0800
Subject: Nokia N900: insecure W+X mapping at 0xd0050000
In-Reply-To: <20180308142818.GA9439@amd>
References: <20180308142818.GA9439@amd>
Message-ID: <20180308162446.GK5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> Insecure W+X mappings, who cares about those? I have 7 pages...

Is this with CONFIG_DEBUG_WX=y?

My guess is that it's for mapping the PM assembly to SRAM. This
is already fixed for am335x that is using drivers/misc/sram*.c.
I think omap2 - omap4 still need fixing if this is the culprit.

Regards,

Tony
