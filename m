From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Jun 2015 08:03:47 +0100
Subject: [PATCH 5/8] regulator: pwm-regulator: Don't assign structure
 attributes right away
In-Reply-To: <20150608180718.GR14071@sirena.org.uk>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-6-git-send-email-lee.jones@linaro.org>
 <20150608180718.GR14071@sirena.org.uk>
Message-ID: <20150609070347.GE2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Jun 2015, Mark Brown wrote:

> On Fri, Jun 05, 2015 at 07:42:48PM +0100, Lee Jones wrote:
> > Perhaps this is just personal preference, but ...
> 
> Possibly...
> 
> > Prevents this kind of nonsense:
> 
> > 	this->is->just.silly = fetch_silly_value(&pointer);
> > 	if (!this->is->just.silly) {
> > 		printk("Silly value failed: %d\n", this->is->just.silly);
> > 		return this->is->just.silly;
> > 	}
> 
> But we don't have any of that code?  Well, one if statement where we
> check config.init_data but that's it.  A temporary does help with things
> like the above but we're not doing that in this driver are we?

Admittedly this is an extreme example, but I do consider:

	init_data = of_get_regulator_init_data(<blah>);
	if (init_data)
        	return -ENOMEM;

... neater than:

	config.init_data = of_get_regulator_init_data(<blah>);
	if (!config.init_data)
        	return -ENOMEM;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
