From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Jun 2012 14:18:33 -0600 (MDT)
Subject: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
In-Reply-To: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.00.1206271416420.27496@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi

On Thu, 10 May 2012, Tomi Valkeinen wrote:

> These patches fix DSS hwmod data related to sysc flags. I haven't seen any
> problem produced by these missing bits, but by looking at the TRM it's clear
> that they should be defined.
> 
> However, applying these will cause additional warnings to show during boot:
> 
> omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
> 
> Most likely the softreset fails even now, but as there's no check to verify it,
> no warnings are visible.
> 
> I think the reason for the failing softreset is the same problem as we have on
> OMAP4: dss_core hwmod should be enabled before other dss hwmods can be enabled
> (and reset).

Thanks, queued for 3.6.

Not sure what to do about the softreset issues at the moment, due to 
competing priorities.  But for sure the data should match the hardware.


- Paul
