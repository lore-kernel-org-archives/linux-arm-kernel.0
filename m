From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 12 May 2017 08:10:11 +0800
Subject: [PATCH v9 7/9] coresight: add support for CPU debug module
In-Reply-To: <20170511171232.GA21765@linaro.org>
References: <1494298202-6739-1-git-send-email-leo.yan@linaro.org>
 <1494298202-6739-8-git-send-email-leo.yan@linaro.org>
 <20170511171232.GA21765@linaro.org>
Message-ID: <20170512001010.GA13845@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 11:12:32AM -0600, Mathieu Poirier wrote:

[...]

> > +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> > +{
> > +	void __iomem *base;
> > +	struct device *dev = &adev->dev;
> > +	struct debug_drvdata *drvdata;
> > +	struct resource *res = &adev->res;
> > +	struct device_node *np = adev->dev.of_node;
> > +	int ret;
> > +
> > +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +	if (!drvdata)
> > +		return -ENOMEM;
> > +
> > +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> > +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> > +		dev_err(dev, "CPU%d drvdata has been initialized, "
> 
> s/"has been"/"has already been"
> 
> That way it really look like an error message.

Will fix.

> Also debug_probe() uses dev_xyz() but everywhere else in the driver it is
> pr_xyz() - any specific reason for that?  I suggest moving to dev_xyz().

Some logs are shared for all device instances, so I think should use
pr_xyz(); will spin a new version to change other places to use
dev_xyz() if the logs are for specific device instance.

> Otherwise things look good.

[...]

Thanks,
Leo Yan
