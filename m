From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 13 Aug 2018 11:52:24 -0700
Subject: [PATCH] remoteproc/davinci: Mark error recovery as disabled
In-Reply-To: <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com>
References: <20180723232757.9147-1-s-anna@ti.com>
 <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com>
Message-ID: <20180813185224.GG5090@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 13 Aug 08:11 PDT 2018, Suman Anna wrote:

> Hi Bjorn,
> 
> On 07/23/2018 06:27 PM, Suman Anna wrote:
> > The Davinci remoteproc driver does not support error recovery at
> > present, so mark the corresponding remoteproc flag appropriately
> > so that the debugfs flag shows the value as 'disabled' by default.
> > 
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Can you pick up this minor patch for 4.19 please, I do not see this in
> your rproc-next branch?
> 

Of course, the patch is applied now, will send my pull request in a few
days.

Regards,
Bjorn

> Thanks,
> Suman
> 
> > ---
> >  drivers/remoteproc/da8xx_remoteproc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> > index b668e32996e2..53160d5ed543 100644
> > --- a/drivers/remoteproc/da8xx_remoteproc.c
> > +++ b/drivers/remoteproc/da8xx_remoteproc.c
> > @@ -284,6 +284,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> >  		goto free_mem;
> >  	}
> >  
> > +	/* error recovery is not supported at present */
> > +	rproc->recovery_disabled = true;
> > +
> >  	drproc = rproc->priv;
> >  	drproc->rproc = rproc;
> >  	drproc->dsp_clk = dsp_clk;
> > 
> 
