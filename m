From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Mar 2010 16:06:15 -0000
Subject: [RFC PATCH 1/6] ARM: pmu: register IRQs at runtime
In-Reply-To: <20100316114131.GC4116@wear.picochip.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
	<20100316114131.GC4116@wear.picochip.com>
Message-ID: <000101cac5eb$c5abaf70$51030e50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,
 
> I much prefer this rather than the old static list that we had before. As an
> aside, do you know of any ARM PMU's that need memory resources in addition to
> the IRQ's? If so perhaps a platform_device might be an easy way of extending
> this.

Well, the ARM11MPCore SCU counters are memory mapped and I have a feeling that
anything [counter-wise] outside the CPU core will likely be memory mapped in the
future.

I've had a go at using a platform_device instead of the struct pmu_irqs, I'll post
the changes for you to take a look at.
 
> Acked-by: Jamie Iles <jamie.iles@picochip.com>

Thanks for that. Please take a look at the platform_device version and see what
you reckon.

Cheers,

Will
