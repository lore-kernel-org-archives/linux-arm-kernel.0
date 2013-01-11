From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 11 Jan 2013 15:08:29 +0100
Subject: [PATCH 0/2 v2] at91/ssc: fixes on ASoC tree for 3.8
Message-ID: <cover.1357912706.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Olof, Arnd,

This series goes on top of Linus' v3.8-rc3 and fixes an error that
we have while compiling DTBs for AT91:
ERROR (phandle_references): Reference to non-existent node or label
"pinctrl_ssc0_tx"

ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2

I have included pending material that is dealing with SSC and pinctrl. The
pinctrl part can be merged more easily now that the big pinctrl update for AT91
has been merged upstream.

This material was designed to enter Mark's fixes queue, but as discussed with
Olof, we can imagine merging everything through arm-soc or split the series (of
2 patches) and let them progress upstream separated (option that I do not like
even if I know that the consequences are not so dramatic).
So please, Olof, if you feel confortable with this series, tell us what you
prefer and we will make our best to make this material go forward...

Thanks for your help, best regards,

v2: - remove the fix for typo in SSC status property: already merged upstream

Bo Shen (2):
  ARM: at91/dts: add pinctrl support for SSC peripheral
  ASoC: atmel-ssc: add pinctrl selection to driver

 arch/arm/boot/dts/at91sam9260.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 32 +++++++++++++++++++++++++-------
 drivers/misc/atmel-ssc.c           |  8 ++++++++
 6 files changed, 149 insertions(+), 7 deletions(-)

-- 
1.8.0
