From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 30 Jul 2015 12:32:03 +0200
Subject: [PATCH v3 0/4] mfd: Improve DT binding docs for max77686 and max77802
Message-ID: <1438252327-28427-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

This series contains some improvements for the Device Tree bindings of
the Maxim MAX77686 and MAX77802 multi-function devices.

This is the third version of the series that addresses issues pointed
out by Sergei Shtylyov and you.

Patch #1 changes the max77686 binding to not suggest using a deprecated
property of the regulator DT binding.

Patch #2 changes the max77686 example to use a generic node name instead
of the chip's name.

Patch #3 adds a DT binding for the mfd portion of the max77802 that was
missing.

Patch #4 moves the regulator portion of the max77686 to the regulator's
DT binding sub-directory since it is a better fit for this information.
This fourth patch needs an ack from the regulator sub-system maintainer.

Changes in v3:
 - Fix typo in ePAPR document name. Suggested by Sergei Shtylyov
- Add Krzysztof Kozlowski Reviewed-by tag to patch #3.
- Capitalise all acronyms. Suggested by Lee Jones.
- Use relative path to refer other bindings. Suggested by Lee Jones.
- Use IRQ_TYPE_NONE instead of 0 in example. Suggested by Lee Jones.
- Add Krzysztof Kozlowski Reviewed-by tag to patch #4.
- Add Lee Jones Acked-by tag to patch #4.

Changes in v2:
- Add Krzysztof Kozlowski Reviewed-by tag in patch #1.
- Use the correct "maxim,max77802" compatible string.
  Suggested by Krzysztof Kozlowski
- Use a pmic generic node name for the max77802 node example.
  Suggested by Sergei Shtylyov.
- Use a generic name for the max77686 node in the regulator example.

Javier Martinez Canillas (4):
  mfd: max77686: Don't suggest in binding to use a deprecated property
  mfd: max77686: Use a generic name for the PMIC node in the example
  mfd: Add DT binding for Maxim MAX77802 IC
  mfd: max77686: Split out regulator part from the DT binding

 Documentation/devicetree/bindings/mfd/max77686.txt | 63 ++-----------------
 Documentation/devicetree/bindings/mfd/max77802.txt | 26 ++++++++
 .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
 3 files changed, 101 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt

-- 
2.4.3
