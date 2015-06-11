From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 14:08:56 +0200
Subject: [PATCH 0/6] clockevent: Migrate to new 'set-state' interface
In-Reply-To: <cover.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <55797A58.9020601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:40 PM, Viresh Kumar wrote:
> Hi Thomas/Daniel,
>
> This series converts few clockevent drivers to the new set-state
> interface. This would enable these drivers to use new states (like:
> ONESHOT_STOPPED, etc.) of a clockevent device (if required), as the
> set-mode interface is marked obsolete now and wouldn't be expanded to
> handle new states.
>
> Once all the drivers are migrated to the new interface in future, we can
> remove the code supporting '->mode' in clockevents core.
>
> Drivers converted in this series are selected based on the diff they
> generate. These are different diffs we shall have for most of the
> drivers and any suggestions/improvements for these patches will be
> applied to other drivers as well.
>
> This is based of tip/master from few days back due to dependency on
> clockevent_state_*() helpers.
>
> Only the first patch is tested on hardware, others are ONLY compile
> tested.

I suggest you use the kernel continuous integration [1] to test the 
patches, it is probable some of the hardware is there.

	-- Daniel

[1] http://kernelci.org/


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
