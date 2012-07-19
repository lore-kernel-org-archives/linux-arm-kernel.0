From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Jul 2012 18:31:47 +0300
Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
In-Reply-To: <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-8-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
Message-ID: <1342711907.4672.153.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-19 at 08:44 -0600, Paul Walmsley wrote:
> On Thu, 19 Jul 2012, Tero Kristo wrote:
> 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> This one needs at least some short description for the changelog.  Maybe 
> just a brief explanation that OSWR saves more energy that CSWR, but has 
> higher resume latency, and since resume from system suspend is considered 
> to be a high-latency operation, OSWR is appropriate here.

Yea, I can add one. How about this:

Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
suspend

Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
state that saves more power, but has higher latencies also. As suspend
is considered a high-latency operation, OSWR is appropriate here.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---

I'll update this to next rev if one is requested.

(Kind of hoping this set would be reaching maturity already.)

-Tero
