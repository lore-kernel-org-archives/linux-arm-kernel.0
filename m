From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:36:03 +0000 (UTC)
Subject: [PATCH 09/11] ARM: OMAP3: PRM: move iva2 force idle functionality
 to PRM driver
In-Reply-To: <1381508141-15244-10-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-10-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191732240.12900@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> This is correct location for this instead of the PM core, as it is accessing
> PRM registers directly.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This is custom reset code for the IVA2, not specifically PRM code, so it 
should go into a separate arch/arm/mach-omap2/iva2.c file, before it gets 
moved out into drivers/.  (Similar to what's been done for 
mach-omap2/i2c.c and mach-omap2/hdq1w.c, etc.)  Unfortunately, this is 
going to require separate interfaces for all of those direct PRM register 
accesses as well.


- Paul
