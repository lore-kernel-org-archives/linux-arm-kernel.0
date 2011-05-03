From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 May 2011 17:18:49 +0100
Subject: [RFC PATCH 03/12] ARM: omap4: use remapped PPI interrupts for
	local timer
In-Reply-To: <4DBA67A5.4060803@ti.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-4-git-send-email-marc.zyngier@arm.com>
	<4DBA67A5.4060803@ti.com>
Message-ID: <1304439529.27148.188.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 12:54 +0530, Santosh Shilimkar wrote:

Hi Santosh,

> On 4/21/2011 12:38 AM, Marc Zyngier wrote:
> > Use the normal interrupt scheme for the local timers by using
> > a remapped PPI interrupt.
> >
> > Tested on a Pandaboard.
> >
> > Cc: Tony Lindgren<tony@atomide.com>
> > Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> > Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> > ---
> 
> Have reviewed and tested your series along with
> OMAP changes. It boots fine on OMAP4430 SDP.
> 
> # cat /proc/interrupts
>             CPU0       CPU1
> .
> 410:       3678          0   GIC-PPI  local_timer
> 413:          0       1042   GIC-PPI  local_timer
> .
> LOC:          0          0  Local timer interrupts
> .
> 
> Though above output would be bit miss leading, this
> series removes the duplicate code from platforms and
> consolidate it at one place.

The LOC line is gone in the next iteration of the patch serie.

> FWIW, you can add my
> 
> Reviewedd-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for testing.

	M.
-- 
Reality is an implementation detail.
