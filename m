From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  9 Jan 2018 17:58:47 -0800
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <20180110015848.11480-1-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
Message-ID: <20180110015848.11480-3-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues.
Introduce a DT property to describe the set of GPIOs that are
available for use so that higher level OSes are able to know what
pins to avoid reading/writing.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I stuck this inside msm8996, but maybe it can go somewhere more generic?

 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
index aaf01e929eea..8354ab270486 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
@@ -40,6 +40,12 @@ MSM8996 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- ngpios-ranges:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: Tuples of GPIO ranges (base, size) indicating
+		    GPIOs available for use.
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
