From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jul 2018 10:18:33 -0700
Subject: [GIT PULL] tee driver for v4.18
In-Reply-To: <20180702121013.GA17791@jax.urgonet>
References: <20180702121013.GA17791@jax.urgonet>
Message-ID: <CAOesGMj=OG0j_3rOY8XmJiY5c8bhJL6boxcBUm2B2yyKQTTRog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,


On Mon, Jul 2, 2018 at 5:10 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hello arm-soc maintainers,
>
> Please pull these small tee driver enhancements. There's a new config
> option for the OP-TEE driver, OPTEE_SHM_NUM_PRIV_PAGES. Also the OP-TEE
> driver reads current time with ktime_get_real_ts64() from now on.
>
> Thanks,
> Jens
>
> The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:
>
>   Linux 4.17 (2018-06-03 14:15:21 -0700)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.18
>
> for you to fetch changes up to 3249527f19d660c5adfb2b6f4ffd4ca0506b8755:
>
>   tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig (2018-06-20 11:20:36 +0200)
>
> ----------------------------------------------------------------
> Misc enhancement for tee driver subsystem
>
> * Replaces getnstimeofday64() with ktime_get_real_ts64()
> * Adds OPTEE_SHM_NUM_PRIV_PAGES to configure how many pages should be
>   statically reserved for driver private allocations
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       tee: replace getnstimeofday64() with ktime_get_real_ts64()
>
> Sahil Malhotra (1):
>       tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig

This doesn't seem to be bugfixes (and not regression fixes in
particular), so I took the liberty of queuing these for 4.19 (in
next/drivers) instead of fixes for v4.18.

Let me know if this was an inaccurate assessment and I can move them over.


Thanks!

-Olof
