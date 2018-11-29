Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B8C169D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23FE21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmDEODE1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyz98YEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23FE21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=00TX3QVwlTr0njIQLGJ5iF4WqvfSFqx/3Ui8M6hcBAM=; b=jmDEODE1KYI75iXpYvWJ8tixbA
	5spHC5Ly/Zbywy44cjKyigB0JD/jvEryfMvCS1ipSy3Ne/jWbZyUrx5T2itgWClFHiW8eUREgwgKx
	uYv1ZV/VQ03bCc5F4kCL2y6MypjeHgVI6ojYm74pOVk5Q0MRadofmqobkoGZX6cW/HxvGxNV9+tcc
	X69CXpJtC7k+2D4AECcRNuCjgEd2yc5Fgq/vhNMfhrQ7NafO+U8TGwIpfgM8jf2V2/DVnT6NBdkWu
	pCkkL4bSXWeyt3eMFJydAv7NlzcAlJFDQ/U+IeCzUGmyN1CeXiGZX0p6scU0dozqF4hle1x95729r
	UEhdEuNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQPa-0001Jy-Of; Thu, 29 Nov 2018 17:47:38 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPK-00016t-Lv
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:24 +0000
Received: by mail-lf1-x144.google.com with SMTP id c16so2096575lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wHLi6pu6OM2Azv5/kwu0Ob81t5zQUxyFdokpJxjiCqo=;
 b=Vyz98YECSi26BpZm6Fp/koCfwpQEh6q8wR8+PqOvcBGBXMSORNNtVp8FIuvTmApdcA
 spVnS5Ly4vqUn8gMTVIymJbdrSm8Q5GZxfWR3dHMwGi4ZSC/6CFOisGBsLX4Cpc7HN+J
 /E9X/oXoPnaWxskiSk/Mkicq7TZn5s598XYVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wHLi6pu6OM2Azv5/kwu0Ob81t5zQUxyFdokpJxjiCqo=;
 b=I8RsAS9z/Rx+RvypDWfof7aH4XOWKIMaNZZCsJRy7RiMRHntaV6QmhB9n1fnB4SGx1
 mK4MPcEcCZdhjbTCJitCXtdCsRRUIArzkeUp5HHZUu5awz3prB1dH6HkvIX700y6fxls
 pv6OUDEDKraUdyvLyGzWAwN3URor1awODL2nZE0Fm4VqzIz66X2oAncgUAwThc7lwq9t
 LTBw+jqAXKAShDWmpOLLhMg6qCo9iTdz/YvrpJKYsvDO3Fo4fhWdCTkfEHHqmJY2FEDD
 NOFun5NjWdgze5D6T5JeoTNI3Y2txPy41YGMlzj2P+DNMLTL3wo8U99BQdHfiDkk8UhR
 SwCQ==
X-Gm-Message-State: AA+aEWaPnlDXUUnFNJzzsqARXLKRUMrYtAGh3P/fdCgPISQEWnrJWXBu
 4D6tfPmOrEXSwJD9/j+e9kGxwQ==
X-Google-Smtp-Source: AFSGD/W7C32Dqw7iLR/IU7LYrqadO8+82qTRlLuRMFSRsZK67JfSbWWo94wTBDjlbA9G3WID43cSSw==
X-Received: by 2002:a19:f204:: with SMTP id q4mr1713196lfh.133.1543513637387; 
 Thu, 29 Nov 2018 09:47:17 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:16 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 05/27] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Date: Thu, 29 Nov 2018 18:46:38 +0100
Message-Id: <20181129174700.16585-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094722_730635_64385C4B 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Lina Iyer <lina.iyer@linaro.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lina Iyer <lina.iyer@linaro.org>

Update DT bindings to represent hierarchical CPU and CPU PM domain idle
states for PSCI. Also update the PSCI examples to clearly show how
flattened and hierarchical idle states can be represented in DT.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Change in V10:
	- Clarified that the new hierarchical representation is orthogonal to
	  OS-initiated vs platform-coordinated PSCI CPU suspend mode.
	- Clarified the representation for "arm,psci-suspend-param" in regards
	  to the flattened vs hierarchical model.
	- Added power-domain-names property to the CPU nodes, as to avoid
	  future churns, if ever multiple power-domains specifiers.

---
 .../devicetree/bindings/arm/psci.txt          | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d52492..e6d3553c8df8 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,173 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+ARM systems can have multiple cores sometimes in hierarchical arrangement.
+This often, but not always, maps directly to the processor power topology of
+the system. Individual nodes in a topology have their own specific power states
+and can be better represented in DT hierarchically.
+
+For these cases, the definitions of the idle states for the CPUs and the CPU
+topology, must conform to the domain idle state specification [3]. The domain
+idle states themselves, must be compatible with the defined 'domain-idle-state'
+binding [1], and also need to specify the arm,psci-suspend-param property for
+each idle state.
+
+DT allows representing CPUs and CPU idle states in two different ways -
+
+The flattened model as given in Example 1, lists CPU's idle states followed by
+the domain idle state that the CPUs may choose. Note that the idle states are
+all compatible with "arm,idle-state". Additionally, for the domain idle state
+the "arm,psci-suspend-param" represents a superset of the CPU's idle state.
+
+Example 2 represents the hierarchical model of CPUs and domain idle states.
+CPUs define their domain provider in their psci DT node. The domain controls
+the power to the CPU and possibly other h/w blocks that would enter an idle
+state along with the CPU. The CPU's idle states may therefore be considered as
+the domain's idle states and have the compatible "arm,idle-state". Such domains
+may also be embedded within another domain that may represent common h/w blocks
+between these CPUs. The idle states of the CPU topology shall be represented as
+the domain's idle states. Note that for the domain idle state, the
+"arm,psci-suspend-param" represents idle states hierarchically.
+
+In PSCI firmware v1.0, the OS-Initiated mode is introduced. However, the
+flattened vs hierarchical DT representation is orthogonal to the OS-Initiated
+vs the platform-coordinated PSCI CPU suspend modes, thus should be considered
+independent of each other.
+
+The hierarchical representation helps and makes it easy to implement OSI mode
+and OS implementations may choose to mandate it. For the default platform-
+coordinated mode, both representations are viable options.
+
+Example 1: Flattened representation of CPU and domain idle states
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000011>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000031>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+Example 2: Hierarchical representation of CPU and domain idle states
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
+	};
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
