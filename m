Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040072084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNRIGUNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040072084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n5r4mGEYUyuI0ErBrVuy83SdGYikBKTF9LXbC331UzA=; b=gNRIGUNxtxOTMH
	Clz6lNgwJyra87Ex55exWVNjs8QXltQ6G+y5JLK0ssitLZ/k/1XIoKFQhvEH6TotSWb48Hq1S9Isu
	f4K1/uYvFVvO7sTWEVrcebWiIpvNPK1EGmQ061VxigyV9+mcNQlK2Z1aAZEmhWcqd5T4kZquaPbKC
	QEh6Wh9IAS//DuDGUDLtFoKN6akG3+8Lagzw0jA+Ob09nythGzaEsCoEwGuhl8WdX9z1OvGl/7MvR
	X7lq0vgpfpmTMXvvFq5l1/8MHfQlopzqpYf+Nk2pBKONxpaJdhgerW0Wxrj5y4oY5jm2jx4tgVePM
	QFr2RDE7d21V4JufppIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrpZ-0001Qf-Np; Tue, 22 Jan 2019 08:54:49 +0000
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrpS-0001Hg-BF
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:54:47 +0000
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm01.jp.fujitsu.com with smtp
 id 25e1_1ae7_b8827017_0c50_4022_a188_3d2a3f889bf3;
 Tue, 22 Jan 2019 17:54:35 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id BB5B0AC00A4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 17:54:34 +0900 (JST)
Received: from G01JPEXCHKW18.g01.fujitsu.local
 (G01JPEXCHKW18.g01.fujitsu.local [10.0.194.57])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 062EDBD66B0;
 Tue, 22 Jan 2019 17:54:34 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw18 ([10.0.194.57]) with mapi id 14.03.0415.000; Tue, 22 Jan 2019
 17:54:33 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Mark Rutland' <mark.rutland@arm.com>, "'catalin.marinas@arm.com'"
 <catalin.marinas@arm.com>, "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>, "'will.deacon@arm.com'"
 <will.deacon@arm.com>, "'linux-kernel@vger.kernel.org'"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdSyLRrS1IDcSdJoRF6WCq7/B3VdwA==
Date: Tue, 22 Jan 2019 08:54:33 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_005443_089803_46646375 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
memory accesses may cause undefined fault (Data abort,
DFSC=0b111111) due to the CPU Errata (Fujitsu #010001).

This patch introduces the workaround to the problem.
The workaround is to change the fault handler for Data abort
DFSC=0b111111 to ignore this undefined fault, which will only
affect the Fujitsu-A64FX.

Signed-off-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
Tested-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 13 +++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  4 ++++
 arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
 arch/arm64/mm/fault.c                  | 24 +++++++++++++++++++++++-
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 1f09d04..26d64e9 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -80,3 +80,4 @@ stable kernels.
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
 | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
+| Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d3..9c09b2b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -643,6 +643,19 @@ config QCOM_FALKOR_ERRATUM_E1041
 
 	  If unsure, say Y.
 
+config FUJITSU_ERRATUM_010001
+	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
+	default y
+	help
+	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
+	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory accesses
+	  may cause undefined fault (Data abort, DFSC=0b111111).
+	  The workaround is to replace the fault handler for Data abort DFSC=0b111111
+	  with a new one to ignore this undefined fault, which will only affect
+	  the Fujitsu-A64FX.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 82e9099..3a0b375 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -60,7 +60,8 @@
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
 #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
+#define ARM64_WORKAROUND_FUJITSU_A64FX_0100001 42
 
-#define ARM64_NCAPS				42
+#define ARM64_NCAPS				43
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 951ed1a..70203f9 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -76,6 +76,7 @@
 #define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_QCOM		0x51
 #define ARM_CPU_IMP_NVIDIA		0x4E
+#define ARM_CPU_IMP_FUJITSU		0x46
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -104,6 +105,8 @@
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
 
+#define FUJITSU_CPU_PART_A64FX		0x001
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -122,6 +125,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9950bb0..fc0737f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -739,6 +739,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
 	},
 #endif
+#ifdef CONFIG_FUJITSU_ERRATUM_010001
+	{
+		.desc = "Fujitsu erratum 010001",
+		.capability = ARM64_WORKAROUND_FUJITSU_A64FX_0100001,
+		ERRATA_MIDR_RANGE(MIDR_FUJITSU_A64FX, 0, 0, 1, 0),
+	},
+#endif
+
 	{
 	}
 };
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index efb7b2c..37e4f18 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -666,6 +666,28 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 0;
 }
 
+static int do_bad_unknown_63(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+{
+	/*
+	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
+	 * memory accesses may spuriously trigger data aborts with
+	 * DFSC=0b111111.
+	 */
+	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001)) {
+		if (cpus_have_cap(ARM64_WORKAROUND_FUJITSU_A64FX_0100001)) {
+			return 0;
+		} else { /* cpu capabilities maybe not ready*/
+			unsigned int current_cpu_midr = read_cpuid_id();
+			const struct midr_range fujitsu_a64fx_midr_range = {
+				MIDR_FUJITSU_A64FX, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0)
+			};
+			if (is_midr_in_range(current_cpu_midr, &fujitsu_a64fx_midr_range) == TRUE)
+				return 0;
+		}
+	}
+	return do_bad(addr, esr, regs);
+}
+
 static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"ttbr address size fault"	},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"level 1 address size fault"	},
@@ -730,7 +752,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 60"			},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"section domain fault"		},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"page domain fault"		},
-	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
+	{ do_bad_unknown_63,	SIGKILL, SI_KERNEL,	"unknown 63"			},
 };
 
 int handle_guest_sea(phys_addr_t addr, unsigned int esr)
-- 
1.8.3.1
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
