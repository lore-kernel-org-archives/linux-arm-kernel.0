From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 19 Apr 2017 07:13:27 +0800
Subject: [PATCH v6 5/8] coresight: use const for device_node structures
In-Reply-To: <20170418152447.GB22806@linaro.org>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-6-git-send-email-leo.yan@linaro.org>
 <20170418152447.GB22806@linaro.org>
Message-ID: <20170418231327.GA8524@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Tue, Apr 18, 2017 at 09:24:47AM -0600, Mathieu Poirier wrote:
> On Thu, Apr 06, 2017 at 09:30:58PM +0800, Leo Yan wrote:
> > Almost low level functions from open firmware have used const to
> > qualify device_node structures, so add const for device_node
> > parameters in of_coresight related functions.
> > 
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> I agree with these changes but the patch needs to be split up - please see
> below.
> 
> > ---
> >  drivers/hwtracing/coresight/of_coresight.c | 6 +++---
> >  include/linux/coresight.h                  | 8 ++++----
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> > index 78d2399..46eec0f 100644
> > --- a/drivers/hwtracing/coresight/of_coresight.c
> > +++ b/drivers/hwtracing/coresight/of_coresight.c
> > @@ -52,7 +52,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
> >  			       endpoint, of_dev_node_match);
> >  }
> >  
> > -static void of_coresight_get_ports(struct device_node *node,
> > +static void of_coresight_get_ports(const struct device_node *node,
> >  				   int *nr_inport, int *nr_outport)
> 
> Move this to a patch by itself as it is not related to this driver.
> 
> >  {
> >  	struct device_node *ep = NULL;
> > @@ -101,7 +101,7 @@ static int of_coresight_alloc_memory(struct device *dev,
> >  	return 0;
> >  }
> >  
> > -int of_coresight_get_cpu(struct device_node *node)
> > +int of_coresight_get_cpu(const struct device_node *node)
> 
> Move this to the previous patch in this set.  There is not need to undo what you
> just did there.
> 
> >  {
> >  	int cpu;
> >  	bool found;
> > @@ -128,7 +128,7 @@ int of_coresight_get_cpu(struct device_node *node)
> >  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> >  
> >  struct coresight_platform_data *of_get_coresight_platform_data(
> > -				struct device *dev, struct device_node *node)
> > +			struct device *dev, const struct device_node *node)
> 
> Same here, move this to a new patch (the same one as of_coresight_get_ports()).

Yeah, this is better than my form. Will change.

Thanks,
Leo Yan
