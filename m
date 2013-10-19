From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:19:46 +0000 (UTC)
Subject: [PATCH 06/11] ARM: OMAP3: CM/PM: add API for forcing IVA2 clk
 enable/disable
In-Reply-To: <1381508141-15244-7-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-7-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191719060.11676@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code directly writes to CM register space to enable/disable IVA2
> clock during boot during the IVA2 reset. Direct access shall be avoided,
> thus implement an API call for this, and change the PM core to use this.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Seems like this type of clock forcing needs to be coordinated with the 
clock framework.  Could you please work with Mike to get a decent 
interface implemented for this?


- Paul
