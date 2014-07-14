From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 13:19:06 +0800
Subject: [PATCH v3] ARM: save/restore Cortex-A9 CP15 registers on
 suspend/resume
In-Reply-To: <alpine.DEB.2.10.1407101704540.2893@Yrabib>
References: <1404974856-25846-1-git-send-email-shawn.guo@freescale.com>
 <alpine.DEB.2.10.1407101704540.2893@Yrabib>
Message-ID: <20140714051905.GA2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 05:05:23PM +0200, Nicolas Pitre wrote:
> On Thu, 10 Jul 2014, Shawn Guo wrote:
> 
> > The CP15 diagnostic register holds ARM errata bits on Cortex-A9, so it
> > needs to be saved/restored on suspend/resume.  Otherwise, the
> > effectiveness of errata workaround gets lost together with diagnostic
> > register bit across suspend/resume cycle.  And the CP15 power control
> > register of Cortex-A9 shares the same problem.
> > 
> > The patch adds a couple of Cortex-A9 specific suspend/resume functions
> > to save/restore these two Cortex-A9 CP15 registers across the
> > suspend/resume cycle.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org

Thanks, Nico.

If no one has objection to the patch, I'm going to put it into patch
tracker soon.

Shawn
