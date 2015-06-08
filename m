From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 08 Jun 2015 10:38:27 -0700
Subject: [GIT PULL] omap fixes for v4.1,
 urgent fix to avoid potential hardware damage
In-Reply-To: <20150601205952.GF30984@atomide.com> (Tony Lindgren's message of
 "Mon, 1 Jun 2015 13:59:53 -0700")
References: <20150601205952.GF30984@atomide.com>
Message-ID: <7h7frew164.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> Here's a pull request to fix potential hardware breaking configuration
> on BeagleBones. For the other fixes, apologies for these coming in so
> late, seems that people have been busy finding regressions.
>
> Regards,
>
> Tony
>
>
> The following changes since commit f25bf74c8862efdc30453d16d60cf22958a4873e:
>
>   ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK (2015-05-20 10:00:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/fixes-rc6
>
> for you to fetch changes up to 7a6cb0abe1aa63334f3ded6d2b6c8eca80e72302:
>
>   ARM: dts: am335x-boneblack: disable RTC-only sleep to avoid hardware damage (2015-06-01 12:48:23 -0700)
>
> ----------------------------------------------------------------
> Omap fixes for the -rc cycle, including a fix for potential hardware
> breakage on BeagleBones:
>
> - BeagleBones don't support RTC-only mode, it can cause hardware
>   damage if system-power-controller is specified without
>   ti,pmic-shutdown-controller
>
> - Fix a recent regression to am3517 SoCs caused by the recent clock
>   move that was not noticed until now despite automated boot
>   testing
>
> - Fix a regression for n900 touchscreen triggered by recent
>   recent input changes
>
> - Fix compatible property for dm816x USB to avoid errors with
>   USB Ethernet
>
> - Fix oops for omap3 when built with CONFIG_THUMB2_KERNEL
>

Thanks, applied to fixes. 

Kevin
