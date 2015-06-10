From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 16:58:53 -0700
Subject: [GIT PULL v2 2/4] ARM: imx: soc updates for 4.2
In-Reply-To: <20150604023903.GB17189@dragon> (Shawn Guo's message of "Thu, 4
 Jun 2015 10:39:03 +0800")
References: <20150604023903.GB17189@dragon>
Message-ID: <7hk2vbi08y.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawnguo@kernel.org> writes:

> Changes since v1:
>  - Rebase to only share imx7d clock ID header with imx/dt branch
>  - Fix gpt timer issues found by linux-next testing
>
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.2
>
> for you to fetch changes up to 0be5da9dc249391e3310cc2351e7af5ce211ac49:
>
>   ARM: imx: imx7d requires anatop (2015-06-03 14:52:31 +0800)
>

> ----------------------------------------------------------------
> The i.MX SoC updates for 4.2:
>  - Add new SoC i.MX7D support, which integrates two Cortex-A7 and one
>    Cortex-M4 cores.
>  - Support suspend from IRAM on i.MX53, so that DDR pins can be set to
>    high impedance for more power saving during suspend.
>  - Move i.MX clock drivers from arch/arm/mach-imx to drivers/clk/imx.
>  - Move i.MX GPT timer driver from arch/arm/mach-imx into
>    drivers/clocksource.
>  - A couple of clock driver update for VF610 and i.MX6Q.
>  - A few random code correction and improvement.
>
> ----------------------------------------------------------------

Applied to next/soc, but...

This had a minor conflict with "ARM: vf610: enable Cortex-M4
configuration on Vybrid SoC" already in next/soc.  Please make sure
that my resolution of arch/arm/mach-imx/Kconfig looks right.

Thanks,

Kevin
