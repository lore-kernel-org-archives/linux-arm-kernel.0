From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 10 Jun 2013 12:16:07 +0100
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <CAAVeFu+UMZikdWO20c9chvBcieOAUgOhz-nTEUpevFWnPNC_ZA@mail.gmail.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <51B0BC80.9040007@wwwdotorg.org>
 <CAAVeFu+by44HnOzv_85kwgeCx5b9TxiMhr27x69QcUj9GRbk8A@mail.gmail.com>
 <51B20B46.4030501@wwwdotorg.org>
 <CAAVeFu+UMZikdWO20c9chvBcieOAUgOhz-nTEUpevFWnPNC_ZA@mail.gmail.com>
Message-ID: <20130610111601.GA3674@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 05:11:15PM +0900, Alexandre Courbot wrote:
> On Sat, Jun 8, 2013 at 1:33 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >>> I think we need to separate the concept of support for *a* secure
> >>> monitor, from support for a *particular* secure monitor.
> >>
> >> Agreed. In this case, can we assume that support for a specific secure
> >> monitor is not arch-specific, and that this patch should be moved
> >> outside of arch-tegra and down to arch/arm? In other words, the ABI of
> >> a particular secure monitor should be the same no matter the chip,
> >> shouldn't it?
> >
> > I would like to believe that the Trusted Foundations monitor had the
> > same ABI irrespective of which Soc it was running on. However, I have
> > absolutely no idea at all if that's true. Even if there's some common
> > subset of the ABI that is identical across all SoCs, I wouldn't be too
> > surprised if there were custom extensions for each different SoC, or
> > just perhaps even each product.
> >
> > Can you research this and find out the answer?
> 
> Will do. Information about TF is scarce unfortunately.

I don't have full information on this topic, but there is certainly no
common standard ABI.  Every example I've seen is different so far,
though some will be less different than others.

ARM are baking some proposabls for that, but that doesn't change the
existing software, and it's impossible to predict how rapidly a new
standards proposal would be adopted.  So unfortunately, diversity is
something we will have to cope with for the foreseeable future.

> > What we can always do is make a compatible property that lists
> > everything[1], and have the driver match on the most specific value for
> > now, but relax the driver's matching later if it turns out that the ABI
> > is indeed common.
> >
> > [1] That'd need to be at least secure OS name, and secure OS version.
> > Perhaps the SoC and board data can be deduced from the DT's top-level
> > compatible properties; nvidia,tegra114-shield, nvidia,tegra114?
> 
> They can probably, but in theory nothing prevents a board from coming
> with different secure monitors (or none at all). In this case, just
> having the board name might not be enough.
> 
> Having a proper node for the firmware like David and Tomasz suggested
> seems to be the best way to make sure we cover all cases - I think I
> will try to do it this way for the next version, and hopefully come
> with a binding that is useful for everyone.

Since existing SMC based firmwares are not safely probeable, describing
what's there using DT feels like the best bet for now.

Cheers
---Dave
