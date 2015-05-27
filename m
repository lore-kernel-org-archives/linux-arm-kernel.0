From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 27 May 2015 15:19:10 -0700
Subject: [RFC] Fix omap3 booting with thumb2 compiled kernel
In-Reply-To: <20150527215545.GA30984@atomide.com> (Tony Lindgren's message of
 "Wed, 27 May 2015 14:55:46 -0700")
References: <20150527215545.GA30984@atomide.com>
Message-ID: <7h7frtmzoh.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ fix email for Dave Martin, +Tyler ]

Tony Lindgren <tony@atomide.com> writes:

> The power management related assembly needs to interact with
> ARM mode bootrom code, so we need to keep most of the related
> assembly in ARM mode.
>
> Currently we are entering into and ARM mode assembly function
> from thumb2 mode, so we need to make sure we switch to ARM
> mode. And we need to do that again after the cache flush.
>
> ---
>
> Kevin told me about this earlier today.. 


And for full boot log/panics, see the kernelci.org thumb2 kernel boots
that fail: http://kernelci.org/boot/?THUMB2_KERNEL&fail

> Anybody got better ideas for a fix here?

FWIW, a quick test of this patch makes my omap3-beagle-xm pass a simple
boot test, but it fails with off idle.

Kevin
