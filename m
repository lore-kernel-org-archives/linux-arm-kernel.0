From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Dec 2017 15:29:57 +0530
Subject: [PATCH V4 03/12] drivers: Add boot constraints core
In-Reply-To: <20171213094205.GB13194@kroah.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <2868a37e561cab91ba5495a1e14b9548c8e93c3e.1509284255.git.viresh.kumar@linaro.org>
 <20171213094205.GB13194@kroah.com>
Message-ID: <20171213095957.GA3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:42, Greg Kroah-Hartman wrote:
> On Sun, Oct 29, 2017 at 07:18:51PM +0530, Viresh Kumar wrote:
> > +	/*
> > +	 * Remove boot constraints for both successful and unsuccessful probe(),
> > +	 * except for the case where EPROBE_DEFER is returned by probe().
> > +	 */
> > +	if (ret != -EPROBE_DEFER)
> > +		dev_boot_constraints_remove(dev);
> 
> This feels odd, but ok, I trust you :)

I did this because it may not be right to keep the boot constraints up for a
device that failed to probe. For example, a LCD screen may continue wasting
power if its device failed to probe. At least I would like to see a real case
where we don't want to remove the constraints here on probe failure.

> > +/* Forward declarations of constraint specific callbacks */
> > +#endif /* _CORE_H */
> 
> What is this comment at the end of the file for?

Perhaps this should be moved to a later patch.

Ack for every other comment you gave.

-- 
viresh
