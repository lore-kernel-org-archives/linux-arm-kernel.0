From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Aug 2016 19:10:56 +0100
Subject: [PATCH 3/9] remoteproc: core: Remove pointless OOM print
In-Reply-To: <20160809173653.GD26240@tuxbot>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-4-lee.jones@linaro.org>
 <20160809173653.GD26240@tuxbot>
Message-ID: <20160809181056.GA1581@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Aug 2016, Bjorn Andersson wrote:

> On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:
> 
> > These types of error prints are superfluous.  The system will
> > pick up on OOM issues and let the user know.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This doesn't rely on anything else, so you can just take it.

> Although, I think we should drop the "mapping" object. We have all the
> information in the carveout object to reverse the mapping at cleanup.

Let's fix it for now, then work on 'nice to have's in a subsequent set.
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 5654a81..4914482 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -619,7 +619,6 @@ static int rproc_handle_carveout(struct rproc *rproc,
> >  	if (rproc->domain) {
> >  		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> >  		if (!mapping) {
> > -			dev_err(dev, "kzalloc mapping failed\n");
> >  			ret = -ENOMEM;
> >  			goto dma_free;
> >  		}

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
