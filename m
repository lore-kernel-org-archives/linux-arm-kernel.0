From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Jun 2015 12:07:08 +0100
Subject: [PATCH 5/8] regulator: pwm-regulator: Don't assign structure
 attributes right away
In-Reply-To: <20150609101005.GZ14071@sirena.org.uk>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-6-git-send-email-lee.jones@linaro.org>
 <20150608180718.GR14071@sirena.org.uk> <20150609070347.GE2982@x1>
 <20150609101005.GZ14071@sirena.org.uk>
Message-ID: <20150609110708.GR2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Mark Brown wrote:

> On Tue, Jun 09, 2015 at 08:03:47AM +0100, Lee Jones wrote:
> 
> > Admittedly this is an extreme example, but I do consider:
> 
> > 	init_data = of_get_regulator_init_data(<blah>);
> > 	if (init_data)
> >         	return -ENOMEM;
> 
> > ... neater than:
> 
> > 	config.init_data = of_get_regulator_init_data(<blah>);
> > 	if (!config.init_data)
> >         	return -ENOMEM;
> 
> Oh, I see.  I pretty much see things the other way for things where the
> temporary has no other users.

I don't feel passionate enough about it to contest.

Skip this patch then.  Are you okay to continue the review?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
