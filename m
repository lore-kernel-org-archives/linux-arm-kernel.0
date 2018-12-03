Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4EDC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E6B20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfUXerG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E6B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=neRJeaY3ADesZG9KV3QgfdpZQAkbUItN28Db49Qbf+g=; b=dfUXerG7BEAiKi
	0OuV+oyrWgVpVFChSG1oo7eFp4umhG8+Wg4wNhky41ahVQdynmTZH7C4D6tyGD2MGGaTDXOlmi++O
	jWJtU7k8uECZN7dFkhYXsAsOQuXnMYsjo7YuTpGsBEs18Pja3yWb6MvKLkZ3EB0icc4L1wfFkw043
	Ft44RYTOnAI3qtWMOQoX4qf0TZS1x5c7mW1R2YCyB81jaEeB6HMJmMMc51MHpcore5ZxnWRBsJCH+
	brpU8ddM26M9QV0H9LX3FTKyW/0gpFTUFT8CaW+5I5cvdnU8gbXDxcgmvd7sKRfE4pjygA55Jn2mU
	RTGbHVUzm/AiECtx2OGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvtv-0007n1-W9; Mon, 03 Dec 2018 21:37:12 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpd-00021d-PL; Mon, 03 Dec 2018 21:33:11 +0000
Received: by mail-oi1-f194.google.com with SMTP id b141so12332134oii.12;
 Mon, 03 Dec 2018 13:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EbWQDLPCbsKZ/jTml8zWdkBSWrjRpmG+Fka3SM1fKF0=;
 b=DeRHHJ0D2/mqOQA/jIZpxYML0tYVPzNgH66PlMHaksy1fwS/hXfXIxNyE7v5D1HxVU
 DyqdpG2ruMC4M/C197YDD2kEPoOtMylUrB/Vzxj5NY5LnJxV9vFFhCN425ckr0nm1EVL
 tSS+ytNu3zszm8Mu2L1obWrJfT7vc07ysprErmGdlZcK/OocLjLFRNGSxhz0KCzhC8MN
 f/qlMo3/6nYjRs92ZJf2EkdCsbJm6fPOD9pY8HuYS5uzLe+ks7LdZy/dPFyyB2c5HI9W
 0ZijGj6r9v03929e4cbSRX99sUBMPZi+M/rB8HtsozcW8KeZZBZx+FN++O47XL0pbGte
 Gu9g==
X-Gm-Message-State: AA+aEWZRaceE5V4Hx+yAJBPiIc9DjNQxDe0/oPCzKsmHRog9cHcHKrlU
 mZJNbDoHTjrWW6CO6pejGA==
X-Google-Smtp-Source: AFSGD/V3Vqy/ysnTec/O1sbXJSZ+zMxmTt4WYHwqKLcmvmZ7MpaOM6U142Kn2f63j+5T8IQ+skEyKQ==
X-Received: by 2002:aca:308f:: with SMTP id w137mr11478589oiw.49.1543872754472; 
 Mon, 03 Dec 2018 13:32:34 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:33 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/34] dt-bindings: arm: Convert cpu binding to json-schema
Date: Mon,  3 Dec 2018 15:31:56 -0600
Message-Id: <20181203213223.16986-8-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133246_325639_DEA98BF6 
X-CRM114-Status: GOOD (  20.15  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert ARM CPU binding to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
 .../devicetree/bindings/arm/cpus.yaml         | 507 ++++++++++++++++++
 2 files changed, 507 insertions(+), 490 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
deleted file mode 100644
index b0198a1cf403..000000000000
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ /dev/null
@@ -1,490 +0,0 @@
-=================
-ARM CPUs bindings
-=================
-
-The device tree allows to describe the layout of CPUs in a system through
-the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
-defining properties for every cpu.
-
-Bindings for CPU nodes follow the Devicetree Specification, available from:
-
-https://www.devicetree.org/specifications/
-
-with updates for 32-bit and 64-bit ARM systems provided in this document.
-
-================================
-Convention used in this document
-================================
-
-This document follows the conventions described in the Devicetree
-Specification, with the addition:
-
-- square brackets define bitfields, eg reg[7:0] value of the bitfield in
-  the reg property contained in bits 7 down to 0
-
-=====================================
-cpus and cpu node bindings definition
-=====================================
-
-The ARM architecture, in accordance with the Devicetree Specification,
-requires the cpus and cpu nodes to be present and contain the properties
-described below.
-
-- cpus node
-
-	Description: Container of cpu nodes
-
-	The node name must be "cpus".
-
-	A cpus node must define the following properties:
-
-	- #address-cells
-		Usage: required
-		Value type: <u32>
-
-		Definition depends on ARM architecture version and
-		configuration:
-
-			# On uniprocessor ARM architectures previous to v7
-			  value must be 1, to enable a simple enumeration
-			  scheme for processors that do not have a HW CPU
-			  identification register.
-			# On 32-bit ARM 11 MPcore, ARM v7 or later systems
-			  value must be 1, that corresponds to CPUID/MPIDR
-			  registers sizes.
-			# On ARM v8 64-bit systems value should be set to 2,
-			  that corresponds to the MPIDR_EL1 register size.
-			  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
-			  in the system, #address-cells can be set to 1, since
-			  MPIDR_EL1[63:32] bits are not used for CPUs
-			  identification.
-	- #size-cells
-		Usage: required
-		Value type: <u32>
-		Definition: must be set to 0
-
-- cpu node
-
-	Description: Describes a CPU in an ARM based system
-
-	PROPERTIES
-
-	- device_type
-		Usage: required
-		Value type: <string>
-		Definition: must be "cpu"
-	- reg
-		Usage and definition depend on ARM architecture version and
-		configuration:
-
-			# On uniprocessor ARM architectures previous to v7
-			  this property is required and must be set to 0.
-
-			# On ARM 11 MPcore based systems this property is
-			  required and matches the CPUID[11:0] register bits.
-
-			  Bits [11:0] in the reg cell must be set to
-			  bits [11:0] in CPU ID register.
-
-			  All other bits in the reg cell must be set to 0.
-
-			# On 32-bit ARM v7 or later systems this property is
-			  required and matches the CPU MPIDR[23:0] register
-			  bits.
-
-			  Bits [23:0] in the reg cell must be set to
-			  bits [23:0] in MPIDR.
-
-			  All other bits in the reg cell must be set to 0.
-
-			# On ARM v8 64-bit systems this property is required
-			  and matches the MPIDR_EL1 register affinity bits.
-
-			  * If cpus node's #address-cells property is set to 2
-
-			    The first reg cell bits [7:0] must be set to
-			    bits [39:32] of MPIDR_EL1.
-
-			    The second reg cell bits [23:0] must be set to
-			    bits [23:0] of MPIDR_EL1.
-
-			  * If cpus node's #address-cells property is set to 1
-
-			    The reg cell bits [23:0] must be set to bits [23:0]
-			    of MPIDR_EL1.
-
-			  All other bits in the reg cells must be set to 0.
-
-	- compatible:
-		Usage: required
-		Value type: <string>
-		Definition: should be one of:
-			    "arm,arm710t"
-			    "arm,arm720t"
-			    "arm,arm740t"
-			    "arm,arm7ej-s"
-			    "arm,arm7tdmi"
-			    "arm,arm7tdmi-s"
-			    "arm,arm9es"
-			    "arm,arm9ej-s"
-			    "arm,arm920t"
-			    "arm,arm922t"
-			    "arm,arm925"
-			    "arm,arm926e-s"
-			    "arm,arm926ej-s"
-			    "arm,arm940t"
-			    "arm,arm946e-s"
-			    "arm,arm966e-s"
-			    "arm,arm968e-s"
-			    "arm,arm9tdmi"
-			    "arm,arm1020e"
-			    "arm,arm1020t"
-			    "arm,arm1022e"
-			    "arm,arm1026ej-s"
-			    "arm,arm1136j-s"
-			    "arm,arm1136jf-s"
-			    "arm,arm1156t2-s"
-			    "arm,arm1156t2f-s"
-			    "arm,arm1176jzf"
-			    "arm,arm1176jz-s"
-			    "arm,arm1176jzf-s"
-			    "arm,arm11mpcore"
-			    "arm,cortex-a5"
-			    "arm,cortex-a7"
-			    "arm,cortex-a8"
-			    "arm,cortex-a9"
-			    "arm,cortex-a12"
-			    "arm,cortex-a15"
-			    "arm,cortex-a17"
-			    "arm,cortex-a53"
-			    "arm,cortex-a57"
-			    "arm,cortex-a72"
-			    "arm,cortex-a73"
-			    "arm,cortex-m0"
-			    "arm,cortex-m0+"
-			    "arm,cortex-m1"
-			    "arm,cortex-m3"
-			    "arm,cortex-m4"
-			    "arm,cortex-r4"
-			    "arm,cortex-r5"
-			    "arm,cortex-r7"
-			    "brcm,brahma-b15"
-			    "brcm,brahma-b53"
-			    "brcm,vulcan"
-			    "cavium,thunder"
-			    "cavium,thunder2"
-			    "faraday,fa526"
-			    "intel,sa110"
-			    "intel,sa1100"
-			    "marvell,feroceon"
-			    "marvell,mohawk"
-			    "marvell,pj4a"
-			    "marvell,pj4b"
-			    "marvell,sheeva-v5"
-			    "nvidia,tegra132-denver"
-			    "nvidia,tegra186-denver"
-			    "nvidia,tegra194-carmel"
-			    "qcom,krait"
-			    "qcom,kryo"
-			    "qcom,kryo385"
-			    "qcom,scorpion"
-	- enable-method
-		Value type: <stringlist>
-		Usage and definition depend on ARM architecture version.
-			# On ARM v8 64-bit this property is required and must
-			  be one of:
-			     "psci"
-			     "spin-table"
-			# On ARM 32-bit systems this property is optional and
-			  can be one of:
-			    "actions,s500-smp"
-			    "allwinner,sun6i-a31"
-			    "allwinner,sun8i-a23"
-			    "allwinner,sun9i-a80-smp"
-			    "amlogic,meson8-smp"
-			    "amlogic,meson8b-smp"
-			    "arm,realview-smp"
-			    "brcm,bcm11351-cpu-method"
-			    "brcm,bcm23550"
-			    "brcm,bcm2836-smp"
-			    "brcm,bcm-nsp-smp"
-			    "brcm,brahma-b15"
-			    "marvell,armada-375-smp"
-			    "marvell,armada-380-smp"
-			    "marvell,armada-390-smp"
-			    "marvell,armada-xp-smp"
-			    "marvell,98dx3236-smp"
-			    "mediatek,mt6589-smp"
-			    "mediatek,mt81xx-tz-smp"
-			    "qcom,gcc-msm8660"
-			    "qcom,kpss-acc-v1"
-			    "qcom,kpss-acc-v2"
-			    "renesas,apmu"
-			    "renesas,r9a06g032-smp"
-			    "rockchip,rk3036-smp"
-			    "rockchip,rk3066-smp"
-			    "ste,dbx500-smp"
-
-	- cpu-release-addr
-		Usage: required for systems that have an "enable-method"
-		       property value of "spin-table".
-		Value type: <prop-encoded-array>
-		Definition:
-			# On ARM v8 64-bit systems must be a two cell
-			  property identifying a 64-bit zero-initialised
-			  memory location.
-
-	- qcom,saw
-		Usage: required for systems that have an "enable-method"
-		       property value of "qcom,kpss-acc-v1" or
-		       "qcom,kpss-acc-v2"
-		Value type: <phandle>
-		Definition: Specifies the SAW[1] node associated with this CPU.
-
-	- qcom,acc
-		Usage: required for systems that have an "enable-method"
-		       property value of "qcom,kpss-acc-v1" or
-		       "qcom,kpss-acc-v2"
-		Value type: <phandle>
-		Definition: Specifies the ACC[2] node associated with this CPU.
-
-	- cpu-idle-states
-		Usage: Optional
-		Value type: <prop-encoded-array>
-		Definition:
-			# List of phandles to idle state nodes supported
-			  by this cpu [3].
-
-	- capacity-dmips-mhz
-		Usage: Optional
-		Value type: <u32>
-		Definition:
-			# u32 value representing CPU capacity [4] in
-			  DMIPS/MHz, relative to highest capacity-dmips-mhz
-			  in the system.
-
-	- rockchip,pmu
-		Usage: optional for systems that have an "enable-method"
-		       property value of "rockchip,rk3066-smp"
-		       While optional, it is the preferred way to get access to
-		       the cpu-core power-domains.
-		Value type: <phandle>
-		Definition: Specifies the syscon node controlling the cpu core
-			    power domains.
-
-	- dynamic-power-coefficient
-		Usage: optional
-		Value type: <prop-encoded-array>
-		Definition: A u32 value that represents the running time dynamic
-			    power coefficient in units of uW/MHz/V^2. The
-			    coefficient can either be calculated from power
-			    measurements or derived by analysis.
-
-			    The dynamic power consumption of the CPU  is
-			    proportional to the square of the Voltage (V) and
-			    the clock frequency (f). The coefficient is used to
-			    calculate the dynamic power as below -
-
-			    Pdyn = dynamic-power-coefficient * V^2 * f
-
-			    where voltage is in V, frequency is in MHz.
-
-Example 1 (dual-cluster big.LITTLE system 32-bit):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x0>;
-		};
-
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x1>;
-		};
-
-		cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x100>;
-		};
-
-		cpu@101 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x101>;
-		};
-	};
-
-Example 2 (Cortex-A8 uniprocessor 32-bit system):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a8";
-			reg = <0x0>;
-		};
-	};
-
-Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,arm926ej-s";
-			reg = <0x0>;
-		};
-	};
-
-Example 4 (ARM Cortex-A57 64-bit system):
-
-cpus {
-	#size-cells = <0>;
-	#address-cells = <2>;
-
-	cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-};
-
---
-[1] arm/msm/qcom,saw2.txt
-[2] arm/msm/qcom,kpss-acc.txt
-[3] ARM Linux kernel documentation - idle states bindings
-    Documentation/devicetree/bindings/arm/idle-states.txt
-[4] ARM Linux kernel documentation - cpu capacity bindings
-    Documentation/devicetree/bindings/arm/cpu-capacity.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
new file mode 100644
index 000000000000..298c17b327c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -0,0 +1,507 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM CPUs bindings
+
+maintainers:
+  - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+
+description: |+
+  The device tree allows to describe the layout of CPUs in a system through
+  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
+  defining properties for every cpu.
+
+  Bindings for CPU nodes follow the Devicetree Specification, available from:
+
+  https://www.devicetree.org/specifications/
+
+  with updates for 32-bit and 64-bit ARM systems provided in this document.
+
+  ================================
+  Convention used in this document
+  ================================
+
+  This document follows the conventions described in the Devicetree
+  Specification, with the addition:
+
+  - square brackets define bitfields, eg reg[7:0] value of the bitfield in
+    the reg property contained in bits 7 down to 0
+
+  =====================================
+  cpus and cpu node bindings definition
+  =====================================
+
+  The ARM architecture, in accordance with the Devicetree Specification,
+  requires the cpus and cpu nodes to be present and contain the properties
+  described below.
+
+properties:
+  $nodename:
+    const: cpus
+    description: Container of cpu nodes
+
+  '#address-cells':
+    enum: [1, 2]
+    description: |
+      Definition depends on ARM architecture version and configuration:
+
+      On uniprocessor ARM architectures previous to v7
+        value must be 1, to enable a simple enumeration
+        scheme for processors that do not have a HW CPU
+        identification register.
+      On 32-bit ARM 11 MPcore, ARM v7 or later systems
+        value must be 1, that corresponds to CPUID/MPIDR
+        registers sizes.
+      On ARM v8 64-bit systems value should be set to 2,
+        that corresponds to the MPIDR_EL1 register size.
+        If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
+        in the system, #address-cells can be set to 1, since
+        MPIDR_EL1[63:32] bits are not used for CPUs
+        identification.
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^cpu@[0-9a-f]+$':
+    properties:
+      device_type:
+        const: cpu
+
+      reg:
+        maxItems: 1
+        description: |
+          Usage and definition depend on ARM architecture version and
+          configuration:
+
+          On uniprocessor ARM architectures previous to v7
+          this property is required and must be set to 0.
+
+          On ARM 11 MPcore based systems this property is
+            required and matches the CPUID[11:0] register bits.
+
+            Bits [11:0] in the reg cell must be set to
+            bits [11:0] in CPU ID register.
+
+            All other bits in the reg cell must be set to 0.
+
+          On 32-bit ARM v7 or later systems this property is
+            required and matches the CPU MPIDR[23:0] register
+            bits.
+
+            Bits [23:0] in the reg cell must be set to
+            bits [23:0] in MPIDR.
+
+            All other bits in the reg cell must be set to 0.
+
+          On ARM v8 64-bit systems this property is required
+            and matches the MPIDR_EL1 register affinity bits.
+
+            * If cpus node's #address-cells property is set to 2
+
+              The first reg cell bits [7:0] must be set to
+              bits [39:32] of MPIDR_EL1.
+
+              The second reg cell bits [23:0] must be set to
+              bits [23:0] of MPIDR_EL1.
+
+            * If cpus node's #address-cells property is set to 1
+
+              The reg cell bits [23:0] must be set to bits [23:0]
+              of MPIDR_EL1.
+
+          All other bits in the reg cells must be set to 0.
+
+      compatible:
+        items:
+          - enum:
+              - arm,arm710t
+              - arm,arm720t
+              - arm,arm740t
+              - arm,arm7ej-s
+              - arm,arm7tdmi
+              - arm,arm7tdmi-s
+              - arm,arm9es
+              - arm,arm9ej-s
+              - arm,arm920t
+              - arm,arm922t
+              - arm,arm925
+              - arm,arm926e-s
+              - arm,arm926ej-s
+              - arm,arm940t
+              - arm,arm946e-s
+              - arm,arm966e-s
+              - arm,arm968e-s
+              - arm,arm9tdmi
+              - arm,arm1020e
+              - arm,arm1020t
+              - arm,arm1022e
+              - arm,arm1026ej-s
+              - arm,arm1136j-s
+              - arm,arm1136jf-s
+              - arm,arm1156t2-s
+              - arm,arm1156t2f-s
+              - arm,arm1176jzf
+              - arm,arm1176jz-s
+              - arm,arm1176jzf-s
+              - arm,arm11mpcore
+              - arm,armv8 # Only for s/w models
+              - arm,cortex-a5
+              - arm,cortex-a7
+              - arm,cortex-a8
+              - arm,cortex-a9
+              - arm,cortex-a12
+              - arm,cortex-a15
+              - arm,cortex-a17
+              - arm,cortex-a53
+              - arm,cortex-a57
+              - arm,cortex-a72
+              - arm,cortex-a73
+              - arm,cortex-m0
+              - arm,cortex-m0+
+              - arm,cortex-m1
+              - arm,cortex-m3
+              - arm,cortex-m4
+              - arm,cortex-r4
+              - arm,cortex-r5
+              - arm,cortex-r7
+              - brcm,brahma-b15
+              - brcm,brahma-b53
+              - brcm,vulcan
+              - cavium,thunder
+              - cavium,thunder2
+              - faraday,fa526
+              - intel,sa110
+              - intel,sa1100
+              - marvell,feroceon
+              - marvell,mohawk
+              - marvell,pj4a
+              - marvell,pj4b
+              - marvell,sheeva-v5
+              - marvell,sheeva-v7
+              - nvidia,tegra132-denver
+              - nvidia,tegra186-denver
+              - nvidia,tegra194-carmel
+              - qcom,krait
+              - qcom,kryo
+              - qcom,kryo385
+              - qcom,scorpion
+
+      enable-method:
+        allOf:
+          - $ref: '/schemas/types.yaml#/definitions/string'
+          - oneOf:
+            # On ARM v8 64-bit this property is required
+            - enum:
+                - psci
+                - spin-table
+            # On ARM 32-bit systems this property is optional
+            - enum:
+                - actions,s500-smp
+                - allwinner,sun6i-a31
+                - allwinner,sun8i-a23
+                - allwinner,sun9i-a80-smp
+                - allwinner,sun8i-a83t-smp
+                - amlogic,meson8-smp
+                - amlogic,meson8b-smp
+                - arm,realview-smp
+                - brcm,bcm11351-cpu-method
+                - brcm,bcm23550
+                - brcm,bcm2836-smp
+                - brcm,bcm63138
+                - brcm,bcm-nsp-smp
+                - brcm,brahma-b15
+                - marvell,armada-375-smp
+                - marvell,armada-380-smp
+                - marvell,armada-390-smp
+                - marvell,armada-xp-smp
+                - marvell,98dx3236-smp
+                - mediatek,mt6589-smp
+                - mediatek,mt81xx-tz-smp
+                - qcom,gcc-msm8660
+                - qcom,kpss-acc-v1
+                - qcom,kpss-acc-v2
+                - renesas,apmu
+                - renesas,r9a06g032-smp
+                - rockchip,rk3036-smp
+                - rockchip,rk3066-smp
+                - ste,dbx500-smp
+
+      cpu-release-addr:
+        $ref: '/schemas/types.yaml#/definitions/uint64'
+
+        description:
+          Required for systems that have an "enable-method"
+            property value of "spin-table".
+          On ARM v8 64-bit systems must be a two cell
+            property identifying a 64-bit zero-initialised
+            memory location.
+
+      cpu-idle-states:
+        $ref: '/schemas/types.yaml#/definitions/phandle-array'
+        description: |
+          List of phandles to idle state nodes supported
+          by this cpu (see ./idle-states.txt).
+
+      capacity-dmips-mhz:
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          u32 value representing CPU capacity (see ./cpu-capacity.txt) in
+          DMIPS/MHz, relative to highest capacity-dmips-mhz
+          in the system.
+
+      dynamic-power-coefficient:
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          A u32 value that represents the running time dynamic
+          power coefficient in units of uW/MHz/V^2. The
+          coefficient can either be calculated from power
+          measurements or derived by analysis.
+
+          The dynamic power consumption of the CPU  is
+          proportional to the square of the Voltage (V) and
+          the clock frequency (f). The coefficient is used to
+          calculate the dynamic power as below -
+
+          Pdyn = dynamic-power-coefficient * V^2 * f
+
+          where voltage is in V, frequency is in MHz.
+
+      qcom,saw:
+        $ref: '/schemas/types.yaml#/definitions/phandle'
+        description: |
+          Specifies the SAW* node associated with this CPU.
+
+          Required for systems that have an "enable-method" property
+          value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+
+          * arm/msm/qcom,saw2.txt
+
+      qcom,acc:
+        $ref: '/schemas/types.yaml#/definitions/phandle'
+        description: |
+          Specifies the ACC* node associated with this CPU.
+
+          Required for systems that have an "enable-method" property
+          value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+
+          * arm/msm/qcom,kpss-acc.txt
+
+      rockchip,pmu:
+        $ref: '/schemas/types.yaml#/definitions/phandle'
+        description: |
+          Specifies the syscon node controlling the cpu core power domains.
+
+          Optional for systems that have an "enable-method"
+          property value of "rockchip,rk3066-smp"
+          While optional, it is the preferred way to get access to
+          the cpu-core power-domains.
+
+    required:
+      - device_type
+      - reg
+      - compatible
+
+    dependencies:
+      cpu-release-addr: [enable-method]
+      rockchip,pmu: [enable-method]
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a15";
+        reg = <0x0>;
+      };
+
+      cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a15";
+        reg = <0x1>;
+      };
+
+      cpu@100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a7";
+        reg = <0x100>;
+      };
+
+      cpu@101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a7";
+        reg = <0x101>;
+      };
+    };
+
+  - |
+    // Example 2 (Cortex-A8 uniprocessor 32-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a8";
+        reg = <0x0>;
+      };
+    };
+
+  - |
+    // Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,arm926ej-s";
+        reg = <0x0>;
+      };
+    };
+
+  - |
+    //  Example 4 (ARM Cortex-A57 64-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <2>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x0>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x1>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10000>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10001>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x0>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x1>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10000>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10001>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+    };
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
