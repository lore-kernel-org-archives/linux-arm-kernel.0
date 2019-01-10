Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AA1208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SWaoGLrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA1208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XT/GxWsP4YLK5VbVRQNnWaVJUT638UbHlWd1g/UdPhI=; b=SWaoGLrOhfnq1G
	DYVzFdiCW37nKJbSk2I8eaxt/x5RUuJUFjCq8pUm3YGhHSRbtCJhc+o2cBoLWEC1WCzVLBxRVsvgf
	2OAp3HbWeGg7q6A0zzFcEZI8NabybCGfO1/S30b3nkwCr9itvMz339mC1jM/Q5r3s6qZ7TGFcsyVN
	N65D46beCuIFC6YnAkCbABtE4SrOC2cOfFYLZ6KUq9tA14zEurx/32ujopp6zkDxmqmvnzXijJTvC
	u3MBKdxTOGJAEc5WM2Olf1Zsc9F3CPtI4++OM+nKILJLlGYe5RXhGcqwkEWgaBDQW5ZUkBIwmfxZu
	4yLKCLlUmGQidFPThKwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghics-0000Gp-Rw; Thu, 10 Jan 2019 22:16:34 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghicp-0000GP-FH
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 22:16:33 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so10601563oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 14:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FUzrvJeCP/Uefe73lE9qVhQ6gchhxLspPlMJYTQFUYk=;
 b=JX188Z/V6YlwDIfHsF87ACU7McbFiU1rU01Pk8D3fkkTyYnXbQYPfqAO/vr1wBjEkP
 7/xrzwlQ8ebr9xYn8JgRjZsjWS5aXOygqY5UF3FEUnjFFW//FNYjvOzs+6arSd5Br7dD
 hjw+aj5TrvIhB24yV4C8XFot5HbUEpZeRJYJeqRpSa8mZsr4dZHSzTFyCfzVgeh/a0hr
 /1j9l31B9+cci8qHfixm2guBntSuyTpqUjrD3Qv0Y7s4GBQYvSaXYGJ+1Pp5B/7PdJ21
 xGEpD8x2eTUoMWrwOsYBFbyxxg+rw6he8X86GClMduXeAl7aFqbbZ8Ny548T77BlKMG9
 hR4w==
X-Gm-Message-State: AJcUukdLERbObjUMxKV1lITBB+iZ2+SGjnqKg2OqQv84VrdLh+kekVYC
 bI3G1bRhJGbKAflagzgYUg==
X-Google-Smtp-Source: ALg8bN7Xt7+BBCXLQ2orGqHjFrpjaVVQ7W9X+OKjQzs5ZaQrufVTwKAKhO2gToMUMlM1qoKu06KtxQ==
X-Received: by 2002:aca:a86:: with SMTP id k6mr7957399oiy.334.1547158589407;
 Thu, 10 Jan 2019 14:16:29 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id v3sm69035242oib.57.2019.01.10.14.16.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 14:16:28 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3] dt-bindings: arm: Convert PMU binding to json-schema
Date: Thu, 10 Jan 2019 16:16:28 -0600
Message-Id: <20190110221628.25021-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_141631_512310_281C83B8 
X-CRM114-Status: GOOD (  20.23  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert ARM PMU binding to DT schema format using json-schema.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Don't allow arm,cortex-a15-pmu to be a fallback for arm,cortex-a7-pmu
- Update MAINTAINERS

Will, you can take this.

 Documentation/devicetree/bindings/arm/pmu.txt | 70 ---------------
 .../devicetree/bindings/arm/pmu.yaml          | 87 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 88 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
deleted file mode 100644
index 13611a8199bb..000000000000
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* ARM Performance Monitor Units
-
-ARM cores often have a PMU for counting cpu and cache events like cache misses
-and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
-representation in the device tree should be done as under:-
-
-Required properties:
-
-- compatible : should be one of
-	"apm,potenza-pmu"
-	"arm,armv8-pmuv3"
-	"arm,cortex-a73-pmu"
-	"arm,cortex-a72-pmu"
-	"arm,cortex-a57-pmu"
-	"arm,cortex-a53-pmu"
-	"arm,cortex-a35-pmu"
-	"arm,cortex-a17-pmu"
-	"arm,cortex-a15-pmu"
-	"arm,cortex-a12-pmu"
-	"arm,cortex-a9-pmu"
-	"arm,cortex-a8-pmu"
-	"arm,cortex-a7-pmu"
-	"arm,cortex-a5-pmu"
-	"arm,arm11mpcore-pmu"
-	"arm,arm1176-pmu"
-	"arm,arm1136-pmu"
-	"brcm,vulcan-pmu"
-	"cavium,thunder-pmu"
-	"qcom,scorpion-pmu"
-	"qcom,scorpion-mp-pmu"
-	"qcom,krait-pmu"
-- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
-               interrupt (PPI) then 1 interrupt should be specified.
-
-Optional properties:
-
-- interrupt-affinity : When using SPIs, specifies a list of phandles to CPU
-                       nodes corresponding directly to the affinity of
-		       the SPIs listed in the interrupts property.
-
-                       When using a PPI, specifies a list of phandles to CPU
-		       nodes corresponding to the set of CPUs which have
-		       a PMU of this type signalling the PPI listed in the
-		       interrupts property, unless this is already specified
-		       by the PPI interrupt specifier itself (in which case
-		       the interrupt-affinity property shouldn't be present).
-
-                       This property should be present when there is more than
-		       a single SPI.
-
-
-- qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
-                     events.
-
-- secure-reg-access : Indicates that the ARMv7 Secure Debug Enable Register
-		      (SDER) is accessible. This will cause the driver to do
-		      any setup required that is only possible in ARMv7 secure
-		      state. If not present the ARMv7 SDER will not be touched,
-		      which means the PMU may fail to operate unless external
-		      code (bootloader or security monitor) has performed the
-		      appropriate initialisation. Note that this property is
-		      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
-		      in Non-secure state.
-
-Example:
-
-pmu {
-        compatible = "arm,cortex-a9-pmu";
-        interrupts = <100 101>;
-};
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
new file mode 100644
index 000000000000..52ae094ce330
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Performance Monitor Units
+
+maintainers:
+  - Mark Rutland <mark.rutland@arm.com>
+  - Will Deacon <will.deacon@arm.com>
+
+description: |+
+  ARM cores often have a PMU for counting cpu and cache events like cache misses
+  and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
+  representation in the device tree should be done as under:-
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apm,potenza-pmu
+          - arm,armv8-pmuv3
+          - arm,cortex-a73-pmu
+          - arm,cortex-a72-pmu
+          - arm,cortex-a57-pmu
+          - arm,cortex-a53-pmu
+          - arm,cortex-a35-pmu
+          - arm,cortex-a17-pmu
+          - arm,cortex-a15-pmu
+          - arm,cortex-a12-pmu
+          - arm,cortex-a9-pmu
+          - arm,cortex-a8-pmu
+          - arm,cortex-a7-pmu
+          - arm,cortex-a5-pmu
+          - arm,arm11mpcore-pmu
+          - arm,arm1176-pmu
+          - arm,arm1136-pmu
+          - brcm,vulcan-pmu
+          - cavium,thunder-pmu
+          - qcom,scorpion-pmu
+          - qcom,scorpion-mp-pmu
+          - qcom,krait-pmu
+
+  interrupts:
+    # Don't know how many CPUs, so no constraints to specify
+    description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
+
+  interrupt-affinity:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      When using SPIs, specifies a list of phandles to CPU
+      nodes corresponding directly to the affinity of
+      the SPIs listed in the interrupts property.
+
+      When using a PPI, specifies a list of phandles to CPU
+      nodes corresponding to the set of CPUs which have
+      a PMU of this type signalling the PPI listed in the
+      interrupts property, unless this is already specified
+      by the PPI interrupt specifier itself (in which case
+      the interrupt-affinity property shouldn't be present).
+
+      This property should be present when there is more than
+      a single SPI.
+
+  qcom,no-pc-write:
+    type: boolean
+    description:
+      Indicates that this PMU doesn't support the 0xc and 0xd events.
+
+  secure-reg-access:
+    type: boolean
+    description:
+      Indicates that the ARMv7 Secure Debug Enable Register
+      (SDER) is accessible. This will cause the driver to do
+      any setup required that is only possible in ARMv7 secure
+      state. If not present the ARMv7 SDER will not be touched,
+      which means the PMU may fail to operate unless external
+      code (bootloader or security monitor) has performed the
+      appropriate initialisation. Note that this property is
+      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
+      in Non-secure state.
+
+required:
+  - compatible
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 39fcdbf38969..3f15010e5883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1159,7 +1159,7 @@ F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
 F:	drivers/perf/*
 F:	include/linux/perf/arm_pmu.h
-F:	Documentation/devicetree/bindings/arm/pmu.txt
+F:	Documentation/devicetree/bindings/arm/pmu.yaml
 F:	Documentation/devicetree/bindings/perf/
 
 ARM PORT
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
