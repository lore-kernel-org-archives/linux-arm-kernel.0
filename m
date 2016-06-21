From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Jun 2016 01:07:29 +0200
Subject: [PATCH 0/5] Fix and improve clock controller for the RK322x SoCs
In-Reply-To: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
References: <1466484811-26923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <13345941.K3V3BNYxTY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juni 2016, 12:53:26 schrieb Xing Zheng:
> Hi,
>   These patchset fix some clocks bugs, and improve clock configuration
> for i2s/spdif/MAC on RK322x SoCs.

applied to my clock-branch with the following changes:

- fixed the error in patch1 - missing ")" in
      COMPOSITE_FRAC(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
-                       RK3288_CLKSEL_CON(7), 0,
-                       RK3288_CLKGATE_CON(0), 11, GFLAGS),
+                       RK2928_CLKSEL_CON(7), 0,
+                       RK2928_CLKGATE_CON(0), 11, GFLAGS,

- adapted patch2 accordingly
- split out clock id addition into separate patches, as they need a shared 
branch. Xing please remember to add clock-ids to the header in separate 
patches.


Heiko
