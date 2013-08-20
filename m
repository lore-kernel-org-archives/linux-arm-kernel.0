From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 21 Aug 2013 00:32:06 +0200
Subject: [PATCH 01/16] pwm: samsung: Update DT bindings documentation to
 cover clocks
In-Reply-To: <5213D2D6.50603@wwwdotorg.org>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
 <1377019903-14614-2-git-send-email-t.figa@samsung.com>
 <5213D2D6.50603@wwwdotorg.org>
Message-ID: <11380970.mYsvoRAzs5@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 of August 2013 14:34:30 Stephen Warren wrote:
> On 08/20/2013 11:31 AM, Tomasz Figa wrote:
> > PWM driver consumes at least one and up to three clocks, which need to
> > be specified in device tree when used. This patch updates bindings
> > documentation to add information about clocks.
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> > 
> > +- clock-names: should contain all following required clock names:
> > +    - "timers" - PWM base clock used to generate PWM signals,
> > +  and any subset of following optional clock names:
> > +    - "pwm-tclk0" - first external PWM clock source,
> > +    - "pwm-tclk1" - second external PWM clock source.
> > +  Note that not all IP variants allow using all external clock
> > sources. +  Refer to SoC documentation to learn which clock source
> > configurations +  are available.
> 
> It might be nice to explicitly enumerate which variants (or rather, I
> suppose which exact compatible values) support which optional clocks.
> However, I suppose it's fine to just say "go read the HW manual"
> instead.

I don't have enough information about some of the variants, so I decided 
to put it this way, instead of making an incomplete list or speculating 
about things.

> So, this patch,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks.

> (although this patch isn't backwards-compatible since before now, DT
> nodes didn't need to provide any entries in clocks)

The thing is that the clocks were supposed to be there from the beginning, 
but in a hurry I forgot to specify them in original bindings documentation 
and things were running over compatibility clkdev aliases anyway, so 
nobody (including me) noticed.

Best regards,
Tomasz
