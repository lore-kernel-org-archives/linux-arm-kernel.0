From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Oct 2013 15:14:46 +0000 (UTC)
Subject: [PATCH 3/3] ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
In-Reply-To: <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
 <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1310241513310.6544@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Tomi Valkeinen wrote:

> dpll4_m3_ck and dpll4_m4_ck have divider bit fields which are 6 bits
> wide. However, only values from 1 to 32 are allowed. This means we have
> to add a divider tables and list the dividers explicitly.
> 
> I believe the same issue is there for other dpll4_mx_ck clocks, but as
> I'm not familiar with them, I didn't touch them.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.  Does anyone out there want to take care of patching the 
remaining DPLL output clocks that suffer from the same problem?


- Paul
