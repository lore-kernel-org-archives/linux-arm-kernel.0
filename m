From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 10:52:26 +0200
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <1430884947-16787-1-git-send-email-lho@apm.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
Message-ID: <2150970.xGYLhDU9BR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 May 2015 22:02:22 Loc Ho wrote:
> 
> v8:
> * Change ASM_EDAC_H to __ASM_EDAC_H in file edac.h
> * Add WARN_ONCE in stub function atomic_scrub
> * Update DTS binding documentation (with only memory controller node)
> * Temporary remove L1/L2, L3, and SoC driver code and update memory driver
>   code accordingly
> 
> 

I don't see how this is helping. You still use a syscon reference for the
pcp node after I told you not to, and you are completely leaving out the
other nodes, which makes it impossible to tell what your plan is for those.

Please come up with a plan that makes it possible to have proper support
for all the devices in the future. Leaving out bits because you know that
adding them later will be hard is not a good solution: if you screw up
the design now, adding them later will be even harder.

	Arnd
