From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  8 Aug 2018 12:13:36 -0700
Subject: [PATCH 0/3] arm64: dts: qcom: pm8998: Add ADC node and die
 temperature channel
Message-ID: <20180808191339.16875-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the DT node for the QCOM SPMI PMIC5 ADC and a channel
for the die temperature.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

My understanding is that some of the ADC channels are/can be universally
useful on devices with a pm8998, while the use of others is device specific
(e.g. AMUX). Siddartha / QCA folks, are there other generally useful ADC
channels that should be added here?

The driver for the QCOM SPMI PMIC5 ADC landed in the 'testing' branch of the
'iio' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=2c909be15f45c96d3dc6a84e56a76e5c3c7a60ae

(This series has a trivial conflict with the temp alarm series mentioned
above, if desired I can rebase it on that, I wasn't sure whether it's a
good idea to create a dependency on it)

Matthias Kaehlcke (3):
  dt-bindings: iio: vadc: Fix documentation of 'reg'
  arm64: dts: qcom: pm8998: Add adc node
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../bindings/iio/adc/qcom,spmi-vadc.txt        |  4 ++--
 arch/arm64/boot/dts/qcom/pm8998.dtsi           | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog
