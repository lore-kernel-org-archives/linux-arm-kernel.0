From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Oct 2014 16:57:09 +0300
Subject: [PATCH 0/5] ARM: OMAP3+: DPLL: fix set_rate logic
Message-ID: <1412344634-2798-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

OMAP3+ DPLL code is currently using set_rate op to change DPLL rates.
This is kind of wrong, as it also involves changing DPLL parent in certain
cases (switch between locked mode <-> bypass mode.) This set fixes these
issues by introducing the support of determine_rate and set_rate_and_parent
ops for the DPLL clocks. Also introduces support for set_parent, which
just switches a DPLL between locked <-> bypass modes.

Testing branch pushed at my tree: https://github.com/t-kristo/linux-pm.git
branch: 3.17-rc1-dpll-fixes

Testing done:
- omap2430-sdp : boot
- am335x-bone : boot
- am43xx-gpevm : boot
- dra7-evm : boot
- omap5-uevm : boot
- omap4-panda-es : boot
- omap3-beagle : boot
- omap3-beagle-xm : boot

-Tero
