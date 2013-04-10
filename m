From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Apr 2013 15:02:54 -0700
Subject: [PATCH 0/3] fixed-rate and fixed-factor clocks in composite clock
In-Reply-To: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
References: <1365515284-32061-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <1365631378-16103-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series to add a gateable fixed-rate clock to the composite clock[1]
highlights some weaknesses in the composite clock's design.  This series
addresses those concerns (and hopefully supercedes that series) by allowing
more flexibility in the clock ops that can be registered for a composite clock,
namely by making .round_rate and .set_rate optional.

The last patch in this series is a respin of Emilio's changes to the
sunxi clock driver which makes use of the changes to the composite
clock.

Only compile tested, not run tested.

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/230004

Emilio L?pez (1):
  clk: sunxi: Unify oscillator clock

Mike Turquette (2):
  clk: composite: rename 'div' references to 'rate'
  clk: composite: allow fixed rates & fixed dividers

 drivers/clk/clk-composite.c   |   49 +++++++++++++++++++++++------------------
 drivers/clk/sunxi/clk-sunxi.c |   33 +++++++++++++++++++++------
 include/linux/clk-provider.h  |   14 ++++++------
 3 files changed, 60 insertions(+), 36 deletions(-)

-- 
1.7.10.4
