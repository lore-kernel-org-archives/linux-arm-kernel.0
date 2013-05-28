From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 20:58:48 -0700
Subject: [GIT PULL] Renesas ARM based r8a7740 SoC updates for v3.11
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130528035848.GK13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, May 27, 2013 at 05:59:41PM +0900, Simon Horman wrote:
> Hi Arnd, Hi Olof,
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7740-for-v3.11
> 
> for you to fetch changes up to 0a9e1c1eef2b050a16685952ce20575348b94d5c:
> 
>   ARM: shmobile: clock-r8a7740: add TPU PWM support (2013-05-27 17:45:27 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based r8a7740 SoC updates for v3.11
> 
> * Clean-ups from Kuninori Morimoto, Magnus Damm and Laurent Pinchart.
> * Extended clock coverage by Bastian Hecht.
> * Support for initialising GIC from OF by Bastian Hecht.
> * Support for reference DT initialisation by Bastian Hecht.
>   This is used in conjunction with other changes initialise
>   the Armadillo 800 eva board in DT as much as possible.
> * Suspend to RAM and CPUIdle support by Bastian Hecht
> * Build fix for fallout by Arnd Bergmann from suspend to RAM change.

So, looking at this branch, I think you need to reorganize your patches a bit.
You seem to have fallen back to the case of only sorting patches by what
Renesas SoC they are for, while they are clearly of different kinds such that
we would prefer to see them sorted differently for arm-soc.

For example, the fix from Arnd should go in a shared shmobile fixes branch,
ideally. Some of the DT initialization should maybe go in a separate
(shmobile-shared) DT branch. Clock, suspend/resume and other patches can go in
a shared SoC branch across all of shmobile though.

Care to respin? I had a handful of comments on the patches as well, and I'll
continue to look at some of the other ones.

Since you'll have to respin, we might as well see the reshuffling into shared
shmobile branches, so I'll drop the three merges I had already done of
SoC-specific branches. I'll follow up on the ones I claimed to have merged.
None had been pushed out anyway.


Regards,

-Olof
