From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 24 Aug 2015 10:47:17 +0200
Subject: [PATCH v4 0/4] mfd: Improve DT binding docs for max77686 and max77802
Message-ID: <1440406041-25071-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series contains some improvements for the Device Tree bindings of
the Maxim MAX77686 and MAX77802 multi-function devices.

This is the fourth version of the series that addresses issues pointed
out by Lee Jones in v3.

Patch #1 changes the max77686 binding to not suggest using a deprecated
property of the regulator DT binding.

Patch #2 changes the max77686 example to use a generic node name instead
of the chip's name.

Patch #3 adds a DT binding for the mfd portion of the max77802 that was
missing.

Patch #4 moves the regulator portion of the max77686 to the regulator's
DT binding sub-directory since it is a better fit for this information.
Patch #4 needs to be acked by Mark Brown to get it through the mfd tree.

Changes in v4:
- Add Lee Jones Acked-by tag to patch #1.
- Add Lee Jones Acked-by tag to patch #2.
- Reword section about max77802 clock and regulator DT binding docs.
  Suggested by Lee Jones.
- Align max77802 mfd required properties. Suggested by Lee Jones.

Changes in v3:
- Fix typo in ePAPR document name. Suggested by Sergei Shtylyov
- Add Krzysztof Kozlowski Reviewed-by tag to patch #3.
- Capitalise all acronyms. Suggested by Lee Jones.
- Use relative path to refer other bindings. Suggested by Lee Jones.
- Use IRQ_TYPE_NONE instead of 0 in example. Suggested by Lee Jones.
- Add Krzysztof Kozlowski Reviewed-by tag to patch #4.
- Add Lee Jones Acked-by tag to patch #4.

Changes in v2:
- Add Krzysztof Kozlowski Reviewed-by tag to patch #1.
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

 Documentation/devicetree/bindings/mfd/max77686.txt | 65 ++------------------
 Documentation/devicetree/bindings/mfd/max77802.txt | 26 ++++++++
 .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
 3 files changed, 102 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt

-- 
2.4.3
