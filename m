From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 08:07:58 -0500
Subject: [PATCH 0/2] Marvell Armada 375 and 38x timer support
In-Reply-To: <52FA1FBD.90906@linaro.org>
References: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <52FA1FBD.90906@linaro.org>
Message-ID: <20140211130758.GX8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Tue, Feb 11, 2014 at 02:03:57PM +0100, Daniel Lezcano wrote:
> On 02/10/2014 08:07 PM, Ezequiel Garcia wrote:
> >Hello Daniel,
> >
> >This small series adds support for the two new Marvell ARM SoCs:
> >the Armada 375 and Armada 38x.
> >
> >These new SoCs are based on Cortex-A9 CPU cores, and share a
> >number of peripherals with their predecessors in the mach-mvebu
> >family. The core support (arch/arm/mach-mvebu) for these SOCs have just
> >been posted, and we're aiming at having this merged for 3.15.
> >
> >The A375 SoC timer is modeled matching the A370 timer, while the
> >A38x SoC timer is modeled matching the AXP timer. However, we'd like
> >to keep the compatible strings as SoC-specific.
> >
> >In the past, we've had trouble chosing a common compatible string, resulting
> >in the introduction of per-SoC compatibles. Such compatible-string change
> >of course implies breaking backards compatibility, and was only possible
> >after agreeing that the old compatible wasn't used in production.
> >
> >So, in order to avoid such problems, we think it's better to keep them
> >separate.
> >
> >Gregory CLEMENT (2):
> >   clocksource: armada-370-xp: Add support for Armada 375
> >   clocksource: armada-370-xp: Add support for Armada 38x
> >
> >  .../bindings/timer/marvell,armada-370-xp-timer.txt | 13 ++++++++----
> >  drivers/clocksource/time-armada-370-xp.c           | 23 +++++++++++++++++++++-
> >  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> Applied to my tree for 3.15.

Please hold off until we've resolved the discussion regarding adding
unneeded compatible strings.  It's under patch 6 in the main series
adding support for this new SoC.

  [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the system-controller driver

thx,

Jason.
