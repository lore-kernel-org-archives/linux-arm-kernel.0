From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 15 Oct 2015 10:56:50 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <CAL_Jsq+GMui-ztROeJ8zg06E+SuJ9+JSnpotHA0OcD3ZhCj4Uw@mail.gmail.com>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
 <CAL_Jsq+GMui-ztROeJ8zg06E+SuJ9+JSnpotHA0OcD3ZhCj4Uw@mail.gmail.com>
Message-ID: <561F6A52.70706@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2015 19:06, Rob Herring wrote:

> Yes, FLOZ has to be enabled after enabling the L2 and disabled before
> disabling the L2.

Is FLOZ merely a performance optimization?

Have you (or someone else) measured the impact of having it enabled vs disabled?

>> I suppose a work-around might be to set NSACR[18]?
> 
> You may find you need that anyway for control of the SMP bit if you
> shut off cores.

NSACR[18] == NSACR.NS_SMP

Usage constraints
The ACTLR is: [...] RW in Non-secure state if NSACR.NS_SMP = 1.
In this case all bits are Write Ignore except for the SMP bit.

Thus, even if my firmware sets NSACR.NS_SMP, Linux won't be able to
set bits 1,2,3 in ACTLR.

Regards.
