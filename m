From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 12:04:38 -0800
Subject: [GIT PULL] Allwinner core changes for 3.14
In-Reply-To: <20131220221850.GA23269@lukather>
References: <20131220221850.GA23269@lukather>
Message-ID: <20140102200438.GB19720@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Dec 20, 2013 at 11:18:50PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 8f1ae77f466660b6da2455cccecc07ae631fa66d:
> 
>   reset: Add Allwinner SoCs Reset Controller Driver (2013-11-22 21:20:36 +0100)
> 
> are available in the git repository at:
> 
>   https://github.com/mripard/linux.git tags/sunxi-core-for-3.14
> 
> for you to fetch changes up to 73346794b48237b7b4c2a5c02b12e3c4f1da7551:
> 
>   ARM: sun6i: Add SMP support for the Allwinner A31 (2013-12-16 21:33:41 +0100)
> 
> ----------------------------------------------------------------
> Allwinner core changes for 3.14
> 
> This mostly adds the reset controller initialisation for the A31 and the SMP
> operations for this SoC.
> 
> ----------------------------------------------------------------
> Baruch Siach (1):
>       dt-bindings: fix example of allwinner interrupt controller
> 
> Maxime Ripard (4):
>       Merge branch 'sunxi/drivers-for-3.14' into sunxi/core-for-3.14
>       ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER
>       ARM: sunxi: Register the A31 reset IP in init_time
>       ARM: sun6i: Add SMP support for the Allwinner A31

This branch contains the driver changes for 3.14 too. Is that really necessary?
That's just an independent RTC driver.

I would prefer if the SoC support code was kept either separate from drivers
(we can handle trivial merge conflicts), or that the SoC code was applied
before drivers, since we normally use that merge order
(fixes->cleanups->soc->dt->drivers->boards).

So, care to respin for us? Thanks!


-Olof
