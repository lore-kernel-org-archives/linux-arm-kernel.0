From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 5 Oct 2010 00:45:27 +0200
Subject: [PATCH v5] power: introduce library for device-specific OPPs
In-Reply-To: <201010050036.23179.rjw@sisk.pl>
References: <1285933174-24053-1-git-send-email-nm@ti.com>
	<201010050036.23179.rjw@sisk.pl>
Message-ID: <201010050045.27969.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 05, 2010, Rafael J. Wysocki wrote:
> On Friday, October 01, 2010, Nishanth Menon wrote:
...
> > +int opp_init_cpufreq_table(struct device *dev,
> > +			    struct cpufreq_frequency_table **table)
> > +{
> > +	struct device_opp *dev_opp;
> > +	struct opp *opp;
> > +	struct cpufreq_frequency_table *freq_table;
> > +	int i = 0;
> > +
> > +	rcu_read_lock();
> 
> I would pretend I'm an updater here and acquire dev_opp_list_lock instead.
> 
> > +	dev_opp = find_device_opp(dev);
> > +	if (IS_ERR(dev_opp)) {
> > +		rcu_read_unlock();
> 
> So that won't be necessary.

Or rather the lock will have to be dropped here instead.

> > +		pr_warning("Unable to find device\n");
> > +		return PTR_ERR(dev_opp);
> > +	}
> > +

Thanks,
Rafael
