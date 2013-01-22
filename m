From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 22 Jan 2013 18:58:33 +0000
Subject: [PATCH] ARM: Versatile Express: extend the MPIDR range used for
 pen release check
In-Reply-To: <alpine.LFD.2.02.1301221324220.6300@xanadu.home>
References: <1358852200-4581-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.02.1301221324220.6300@xanadu.home>
Message-ID: <20130122185833.GE3959@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 06:25:20PM +0000, Nicolas Pitre wrote:
> On Tue, 22 Jan 2013, Lorenzo Pieralisi wrote:
> 
> > In ARM multi-cluster systems the MPIDR affinity level 0 cannot be used as a
> > single cpu identifier, affinity levels 1 and 2 must be taken into account as
> > well.
> > This patch extends the MPIDR usage to affinity levels 1 and 2 in versatile
> > secondary cores start up code in order to compare the passed pen_release
> > value with the full-blown affinity mask.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Note that my b.L series makes this patch obsolete.

This is needed to boot TC2 in the mainline. Agreed, when the power API
BSP support for TC2 is merged this can be removed, but waiting for that to
happen we should fix the current code to enable TC2 in its current state.

Lorenzo
