From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 12:43:54 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.7
In-Reply-To: <cover.1459732456.git.horms+renesas@verge.net.au>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
Message-ID: <20160413194354.GQ19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:22:56AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC drivers updates for v4.7.
> 
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.7
> 
> for you to fetch changes up to cd89841fc6dbb6dc11aa113769f39dcd30be720f:
> 
>   ARM: shmobile: timer: Drop support for Cortex A8 (2016-03-28 09:01:31 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Drivers Updates for v4.7
> 
> Loop delay calculation updates:
> * Remove check for no longer supported Cortex A8 cores
> * Correct short calculation of delay
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (2):
>       ARM: shmobile: timer: Fix preset_lpj leading to too short delays
>       ARM: shmobile: timer: Drop support for Cortex A8

I don't understand your naming. THis isn't driver code, this is SoC code.

Anyway, I replied to the drop-A8 patch, the resulting function doesn't make
much sense once that code path is removed (div is always 1). Seems like this
should be cleaned up in other ways instead.

So, not merging this branch for now since I think it should be revisited.


-Olof
