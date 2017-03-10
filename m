From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 10 Mar 2017 16:11:39 +0100
Subject: [PATCH v16 1/5] dt/bindings: add bindings for optee
In-Reply-To: <1489158703-22241-1-git-send-email-jens.wiklander@linaro.org>
References: <1489158703-22241-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1489158703-22241-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduces linaro prefix and adds bindings for ARM TrustZone based OP-TEE
implementation.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../bindings/arm/firmware/linaro,optee-tz.txt      | 31 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
new file mode 100644
index 000000000000..d38834c67dff
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
@@ -0,0 +1,31 @@
+OP-TEE Device Tree Bindings
+
+OP-TEE is a piece of software using hardware features to provide a Trusted
+Execution Environment. The security can be provided with ARM TrustZone, but
+also by virtualization or a separate chip.
+
+We're using "linaro" as the first part of the compatible property for
+the reference implementation maintained by Linaro.
+
+* OP-TEE based on ARM TrustZone required properties:
+
+- compatible     : should contain "linaro,optee-tz"
+
+- method         : The method of calling the OP-TEE Trusted OS. Permitted
+                   values are:
+
+                   "smc" : SMC #0, with the register assignments specified
+		           in drivers/tee/optee/optee_smc.h
+
+                   "hvc" : HVC #0, with the register assignments specified
+		           in drivers/tee/optee/optee_smc.h
+
+
+
+Example:
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ec0bfb9bbebd..e18a96cf7c3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -168,6 +168,7 @@ lego	LEGO Systems A/S
 lenovo	Lenovo Group Ltd.
 lg	LG Corporation
 licheepi	Lichee Pi
+linaro	Linaro Limited
 linux	Linux-specific binding
 lltc	Linear Technology Corporation
 lsi	LSI Corp. (LSI Logic)
-- 
2.7.4
