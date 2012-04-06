From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 05 Apr 2012 21:14:01 -0700
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <4F7DA1DE.2030203@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-7-git-send-email-lee.jones@linaro.org>
 <20120405123642.GG24211@n2100.arm.linux.org.uk> <4F7DA1DE.2030203@linaro.org>
Message-ID: <20120406041401.28A993E0BC4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Apr 2012 14:45:02 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> On 05/04/12 13:36, Russell King - ARM Linux wrote:
> > On Thu, Apr 05, 2012 at 10:55:47AM +0100, Lee Jones wrote:
> >> +	of_property_read_u32(np, "clock-frequency",&pdata->f_max);
> >> +	if (!pdata->f_max)
> >> +		pr_warn("%s has no 'clock-frequency' property\n", np->full_name);
> >
> > To be anal about this (which is what we should be about DT bindings)
> > this is not a 'clock frequency' but a maximum clock frequency for the
> > bus.  Or to put it another way, a clock frequency limit.
> >
> > A 'clock-frequency' property suggests (at least to me) that it's
> > specifying the rate of the MCLK signal, which is not what it's doing.
> 
> Sounds sensible.
> 
> I initially had it as 'f-max', but was told to change it to 
> 'clock-frequency'. I'm happy to take other suggestions however.

Yes, "clock-frequency" already has established usage as an exact clock
specification.  If it is a maximum as you say then something like
"max-frequency" makes more sense.

Someone was working on a common MMC DT binding.  Really all of the MMC
drivers should use the same binding for the common bits.

g.
