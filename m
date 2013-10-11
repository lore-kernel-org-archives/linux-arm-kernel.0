From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 11:03:24 -0700
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.13
In-Reply-To: <52582A67.6050108@baylibre.com>
References: <52582A67.6050108@baylibre.com>
Message-ID: <20131011180324.GV29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

* Benoit Cousson <bcousson@baylibre.com> [131011 09:50]:
> Add the minimal DTS support for DRA7xx based SoC core.
> Add the initial support for N900 and gta04 phones.
> Enable USB3 on OMAP5 evm board.
> Add support for cryto accelerators
> Add new IGEP AQUILA board
> Add AM33XX EDMA support
> Update HSUSB node to use the reset-gpios fmwk

Looks good to me, but we're getting self-inflicted merge
conflicts in two places now with Paul's hwmod changes,
and my defconfig changes.

Can you please respin without the following two patches:

49bcd824c1c0db32fe4de0c1ba3ee36defdb11ca ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies
736c4bb159c793b00331261438deb982cbac3c03 ARM: OMAP5: hwmod: add missing ocp2scp hwmod data

I can pick the two patches above and apply after pulling in
Paul's branch first.

However, if other branches are based on this, then we just
need to deal with the merge conflicts, and there's no point
in redoing your branch.

Regards,

Tony
