From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Oct 2013 15:47:45 -0700
Subject: [PATCH 0/6] add support for omap wake-up interrupts via
 pinctrl-single, take2
In-Reply-To: <871u3spzm5.fsf@linaro.org>
References: <20131003054104.8941.88857.stgit@localhost>
 <871u3spzm5.fsf@linaro.org>
Message-ID: <20131010224744.GK29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [131010 14:55]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Here's a respin of the pinctrl-single related patches to use chained
> > irq as suggested by Linus W earlier. This series does not try to
> > provide any generic automated solution yet, but works by doing a
> > request_irq() for the wake-up pin, so it should be flexible enough for
> > both manual control and automated solution.
> 
> > This series removes the last nasty blocker for making omap3 to be
> > device tree only without causing nasty PM regressions.
> 
> Indeed, I gave this a spin on several OMAP3 platforms with legacy boot
> and ran through a series of retention and off-mode tests for idle and
> suspend with both UART and RTC wakeups.  No regressions found.  So...
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> on 3530/beagle, 3730/beagle-xM, 3530/Overo, 3730/Overo STORM

Thanks for testing, applying these into omap-for-v3.13/quirk
because of the dependencies.

Regards,

Tony
