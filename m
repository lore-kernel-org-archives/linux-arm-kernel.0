From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 13:43:48 -0700
Subject: [PATCH] ARM: OMAP3: hwmod: fix variant registration and remove
	SmartReflex from common list
In-Reply-To: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061433540.4611@utopia.booyaka.com>
Message-ID: <20111006204348.GU6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111006 13:05]:
> 
> Commit d6504acd2125984c61dce24727dd3842d0144015 ("OMAP2+: hwmod:
> remove OMAP_CHIP*") tests the inverse condition of what it should be
> testing for the return value from omap_hwmod_register().  This causes
> several IP blocks to not be registered on several OMAP3 family devices.
> 
> Fixing that bug also unmasked another bug, originally reported by
> Chase Maupin <chase.maupin@ti.com> and then subsequently by Abhilash K
> V <abhilash.kv@ti.com>, which caused SmartReflex IP blocks to be
> registered on SoCs that don't support them.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Chase Maupin <chase.maupin@ti.com>
> Cc: Abhilash K V <abhilash.kv@ti.com>
> ---
> 
> This fixes a pretty embarrassing "brown paper bag" bug of mine in one of 
> the cleanup patches.  Tony, it would be good if you could send this to 
> Arnd ASAP and merge into your cleanup branch.  Tested on 3430SDP, 37XX 
> EVM, and OMAP3503.

OK thanks, applying into fixes-part2 branch.

Regards,

Tony
