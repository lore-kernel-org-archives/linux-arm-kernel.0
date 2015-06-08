From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  8 Jun 2015 19:10:41 +0530
Subject: [PATCH 0/6] clockevent: Migrate to new 'set-state' interface
Message-ID: <cover.1433768426.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas/Daniel,

This series converts few clockevent drivers to the new set-state
interface. This would enable these drivers to use new states (like:
ONESHOT_STOPPED, etc.) of a clockevent device (if required), as the
set-mode interface is marked obsolete now and wouldn't be expanded to
handle new states.

Once all the drivers are migrated to the new interface in future, we can
remove the code supporting '->mode' in clockevents core.

Drivers converted in this series are selected based on the diff they
generate. These are different diffs we shall have for most of the
drivers and any suggestions/improvements for these patches will be
applied to other drivers as well.

This is based of tip/master from few days back due to dependency on
clockevent_state_*() helpers.

Only the first patch is tested on hardware, others are ONLY compile
tested.

Cc: Andres Salomon <dilinger@queued.net>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>

Viresh Kumar (6):
  clocksource: arm_arch_timer: Migrate to new 'set-state' interface
  clocksource: arm_global_timer: Migrate to new 'set-state' interface
  clocksource: bcm2835: Migrate to new 'set-state' interface
  clocksource: bcm_kona: Migrate to new 'set-state' interface
  clocksource: cs5535: Migrate to new 'set-state' interface
  clocksource: em_sti: Migrate to new 'set-state' interface

 drivers/clocksource/arm_arch_timer.c   | 61 +++++++++++++++++-----------------
 drivers/clocksource/arm_global_timer.c | 37 ++++++++++-----------
 drivers/clocksource/bcm2835_timer.c    | 17 +++-------
 drivers/clocksource/bcm_kona_timer.c   | 24 ++++++-------
 drivers/clocksource/cs5535-clockevt.c  | 24 +++++++------
 drivers/clocksource/em_sti.c           | 39 ++++++++--------------
 6 files changed, 92 insertions(+), 110 deletions(-)

-- 
2.4.0
