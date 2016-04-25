From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 10:07:41 +1000
Subject: [GIT PULL v2] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <cover.1461209970.git.horms+renesas@verge.net.au>
References: <cover.1461209970.git.horms+renesas@verge.net.au>
Message-ID: <20160425000741.GA24966@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 21, 2016 at 01:44:30PM +1000, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC fixes for v4.6.

I apologise for not making this clearer in the initial posting.

This is v2 of this pull request. The changes since v1 are:

* Include "ARM: dts: r8a7791: Don't disable referenced optional clocks"
  which is needed as a companion to 'Revert "ARM: dts: porter: Enable
  SCIF_CLK frequency and pins"' to resolve re-enable serial on the
  porter board.

* Include 'Correct preset_lpj calculation which may lead to too short delays'
  this was previously part of a separate pull request, which is being
  reworked. On Geert's advice I have promoted it to be a fix for v4.6
  rather than an enhancement for v4.7.

> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.6
> 
> for you to fetch changes up to c531fb27e9699eaee478ee5686a3cca5dee73602:
> 
>   ARM: shmobile: timer: Fix preset_lpj leading to too short delays (2016-04-20 08:52:55 +1000)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.6
> 
> * Correct preset_lpj calculation which may lead to too short delays
> * Correct handling of optional clocks on r8a7791 to restore
>   access to the serial port the porter board
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: timer: Fix preset_lpj leading to too short delays
> 
> Sjoerd Simons (2):
>       ARM: dts: r8a7791: Don't disable referenced optional clocks
>       Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"
> 
>  arch/arm/boot/dts/r8a7791-koelsch.dts |  1 +
>  arch/arm/boot/dts/r8a7791-porter.dts  | 14 +-------------
>  arch/arm/boot/dts/r8a7791.dtsi        |  5 +----
>  arch/arm/mach-shmobile/timer.c        | 28 +++++++++++-----------------
>  4 files changed, 14 insertions(+), 34 deletions(-)
> 
