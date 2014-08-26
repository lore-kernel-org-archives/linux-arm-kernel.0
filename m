From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 18:09:29 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clock Fixes For v3.17
In-Reply-To: <cover.1408926048.git.horms+renesas@verge.net.au>
References: <cover.1408926048.git.horms+renesas@verge.net.au>
Message-ID: <20140826090929.GA1210@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 10:09:47AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC clock fixes for v3.17.
> 
> This pull request is based on third round of Renesas ARM based SoC
> lock updates for v3.17, tagged as renesas-clock3-for-v3.17,
> which you have previously pulled.
> 
> I would like the first to patches considered for -stable.

On reflection as these fixes do not fix any run-time problems
I would like to withdraw my request for them to considered for -stable.
I would, however, still like them considered for v3.17.

Thanks

> The following changes since commit a0f7e7496d56ac2da7c684e2035815318c17973a:
> 
>   ARM: shmobile: sh73a0: add CMT1 clock support for DT (2014-07-15 13:34:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-fixes-for-v3.17
> 
> for you to fetch changes up to 58b80ad6472c0fa12926dfa1f9103d3a326bdf18:
> 
>   ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR (2014-08-22 09:59:54 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Clock Fixes For v3.17
> 
> * ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR
> 
>   This resolves a problem introduced by 4bfb358b1d6cdeff
>   ("ARM: shmobile: Add r8a7791 legacy SDHI clocks")
>   which was included in v3.15.
> 
>   This fix does not have any run-time affect at this time.
> 
> * ARM: shmobile: r8a7790: add missing 0x0100 for SDCKCR
> 
>   This resolves a problem introduced by 9f13ee6f83c52065
>   ("ARM: shmobile: r8a7790: add div4 clocks")
>   which was included in v3.11.
> 
>   This fix does not have any run-time affect at this time.
> 
> * ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name
> 
>   This resolves a problem introduced by a0f7e7496d56ac2d
>   ("ARM: shmobile: sh73a0: add CMT1 clock support for DT")
>   which was included in v3.17-rc1.
> 
>   This fix does not have any run-time affect at this time as the clock in
>   question is used by a SCIF device that is not enabled by default.
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7790: add missing 0x0100 for SDCKCR
>       ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR
> 
> Simon Horman (1):
>       ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name
> 
>  arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++--
>  arch/arm/mach-shmobile/clock-r8a7791.c | 2 +-
>  arch/arm/mach-shmobile/clock-sh73a0.c  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
