From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 10 Sep 2018 09:02:58 -0700
Subject: [PATCH v3 0/3] arm64: dts: qcom: pm8998: Add ADC node and die
 temperature channel
Message-ID: <20180910160301.237538-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the DT node for the QCOM SPMI PMIC5 ADC and a channel
for the die temperature.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

The driver for the QCOM SPMI PMIC5 ADC landed in the 'testing' branch of the
'iio' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=e13d757279bbc59776c8435fb94e54b5a58bdd0b

Matthias Kaehlcke (3):
  dt-bindings: iio: vadc: Fix documentation of 'reg'
  arm64: dts: qcom: pm8998: Add adc node
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../bindings/iio/adc/qcom,spmi-vadc.txt         |  4 ++--
 arch/arm64/boot/dts/qcom/pm8998.dtsi            | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.19.0.rc2.392.g5ba43deb5a-goog
