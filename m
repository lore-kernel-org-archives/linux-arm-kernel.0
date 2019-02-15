Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E67F21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEeLQ8zs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kTRUMmsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E67F21A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=0G5im6XTNPRE45Swn3wonPUw7manZzjKWOMlizk5yS0=; b=IE
	eLQ8zsQVSv4Y/+aiJ+TVj7w1z9Bqiewt7C+HucgmX8ql1G4D2F+Ez5SLInCu5pbIK2voYIDV/dKcc
	XPu9G0pukcY2T/QHLrrsmu6OeaQXgcdO4zWPca9gWy8/M5PUF8rypuhf+/Gw8cOBP/Bm2VLkcqPBk
	+Psi/Y0wWKOvu6/ko7pd0ZfytOEwVu+QbpI+hcXWV+055Ge8EIPrbNgotkz3VyJyF1NDeHbjjGikg
	B0hrbm8sTbWyP5xMs04gzzvflGM6SZfuq4WO+Gp+FFpHWBzibUZkfi+p+kLeuKuITvwoRkCBu3aaQ
	SjJjWb2ep5VOGCBR6JlbAOkRHQAFYYfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gubAr-0005s0-54; Fri, 15 Feb 2019 10:56:53 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gubAm-0005fx-NV
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 10:56:50 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215105645euoutp01903ceb03bb66e7a7f4333039e3e637df~DhFbpzRrn1112411124euoutp01y;
 Fri, 15 Feb 2019 10:56:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190215105645euoutp01903ceb03bb66e7a7f4333039e3e637df~DhFbpzRrn1112411124euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550228205;
 bh=ZcuQddEHqQXSDA3Go2mmZTk5v1iVE0ZC11pw3hHdEl8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=kTRUMmsab4kUyJRWxefVTMFsUK/6ReGVCJEr7zrAEV2ilFx2/gZQevyhN6ScWvRPL
 iN+41BURRS4mq5U3HFMo14ywiErABk+F6nSBEPahFzAFJxiin3URWSfR9TUJGKFyAw
 EztDGI1iIghyYvQxCUBfvTJRE7LH6cDYu6a8LVyg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215105644eucas1p250b7845c2cb8b160087b566f864ca313~DhFa6MSo02889928899eucas1p2S;
 Fri, 15 Feb 2019 10:56:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.DC.04294.CEA966C5; Fri, 15
 Feb 2019 10:56:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe~DhFaPwUPM2182221822eucas1p1o;
 Fri, 15 Feb 2019 10:56:44 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-11-5c669aec7e6e
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.19.04128.BEA966C5; Fri, 15
 Feb 2019 10:56:43 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY000Q7RQFYR40@eusync4.samsung.com>;
 Fri, 15 Feb 2019 10:56:43 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
Date: Fri, 15 Feb 2019 11:56:38 +0100
Message-id: <20190215105638.17476-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7djP87pvZqXFGGw6JWuxccZ6Vouf7VuY
 LM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFuun/WS1+PTsH7vFpf6JTBYzJr9kc+D2uHzt
 IrPH+xut7B47Z91l99i0qpPN4861PWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
 m9a/zAWzxCrW33jE2MB4SKiLkZNDQsBEYsbe2YxdjFwcQgIrGCVmX+thg3A+M0rcXHqIBabq
 wstLLBCJZYwSD5c9Z4dwGpgkti5oZgOpYhMwlOh62wVmiwi4SfxbdwhsFLNAO7PEiyfTwRLC
 Ah4S/Q+3MoHYLAKqEk29n1hBbF4BW4k1aw6xQayTl1i94QAzhL2ATWL3vCQI20Xix7tOVghb
 RuLy5G6wkyQEmhkl2mfMYodwehglts7ZATXJWuLw8YtgHcwCfBKTtk0HmsoBFOeV6GiDhoCH
 xOoL39lBbCGBWInv578zTmAUX8DIsIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwLk//
 O/5lB+OuP0mHGAU4GJV4eFdkpMYIsSaWFVfmHmKU4GBWEuEtnJEWI8SbklhZlVqUH19UmpNa
 fIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHR6JOeWWBg2fHt/woefvnatnn7XxMx
 rbg78/Mfl9p/dZLvED/QuCbmuFnvlO9Ne+XUns55cLLf9fz5B2qsu81rPScJp9U17nz2YcOS
 G8dmy25dxXnvqWrp4n2K9QubP69MDJzCf1W5ZtI5/7S2yPnBclGiq9Kcv795rTi7+OTaI/L7
 OPgdK85lKrEUZyQaajEXFScCAGCsKgvHAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsVy+t/xa7qvZ6XFGPw8omuxccZ6Vouf7VuY
 LM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFuun/WS1+PTsH7vFpf6JTBYzJr9kc+D2uHzt
 IrPH+xut7B47Z91l99i0qpPN4861PWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
 m9a/zAWzxCrW33jE2MB4SKiLkZNDQsBE4sLLSyxdjFwcQgJLGCVaP/5hhnCamCS2nDvIDlLF
 JmAo0fW2iw3EFhFwk/i37hAbSBGzQCezxLzpe1hAEsICHhL9D7cygdgsAqoSTb2fWEFsXgFb
 iTVrDrFBrJOXWL3hAPMERq4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAkNq27GfW3Yw
 dr0LPsQowMGoxMO7IiM1Rog1say4MvcQowQHs5IIb+GMtBgh3pTEyqrUovz4otKc1OJDjNIc
 LErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjAYNUt9EnvpNE1x1pe6x1/NlkyyXSjz5nGa4
 3vkJm1FUT2X7xrXLpss95xd5t/CmZ+6S5WkTM4XmMivucw85wHRR5rj2TRl/ibPdtZ5VLite
 +WqJWYaGbp9n7tKtwlLrFMBxW0HsPluar+aLw3sO7nt/PHox29W64u6HNr8+qxyOiQ8z7DNZ
 ocRSnJFoqMVcVJwIAB6tt4YlAgAA
X-CMS-MailID: 20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe
References: <CGME20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_025649_066052_E6183681 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kevin Hilman <khilman@baylibre.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Marian Mihailescu <mihailescu2m@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
perform low-level platform initialization. This results in a try to install
HYP stubs for the second time for each CPU and results in false HYP/SVC
mode mismatch detection. The HYP stubs are already installed at the
beginning of the kernel initialization on the boot CPU (head.S) or in the
secondary_startup() for other CPUs. To fix this issue MCPM code should use
a cpu_resume() routine without HYP stubs installation.

This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
XU3/XU4/HC1 boards.

Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
v2:
- fixed support for Thumb-mode kernel
---
 arch/arm/common/mcpm_entry.c   |  2 +-
 arch/arm/include/asm/suspend.h |  1 +
 arch/arm/kernel/sleep.S        | 12 ++++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index ad574d20415c..1b1b82b37ce0 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	phys_reset_t phys_reset;
 
-	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
+	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
 	setup_mm_for_reboot();
 
 	__mcpm_cpu_going_down(cpu, cluster);
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 452bbdcbcc83..506314265c6f 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -10,6 +10,7 @@ struct sleep_save_sp {
 };
 
 extern void cpu_resume(void);
+extern void cpu_resume_no_hyp(void);
 extern void cpu_resume_arm(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a8257fc9cf2a..5dc8b80bb693 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -120,6 +120,14 @@ ENDPROC(cpu_resume_after_mmu)
 	.text
 	.align
 
+#ifdef CONFIG_MCPM
+	.arm
+THUMB(	.thumb			)
+ENTRY(cpu_resume_no_hyp)
+ARM_BE8(setend be)			@ ensure we are in BE mode
+	b	no_hyp
+#endif
+
 #ifdef CONFIG_MMU
 	.arm
 ENTRY(cpu_resume_arm)
@@ -135,6 +143,7 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
 	bl	__hyp_stub_install_secondary
 #endif
 	safe_svcmode_maskall r1
+no_hyp:
 	mov	r1, #0
 	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
 	ALT_UP_B(1f)
@@ -163,6 +172,9 @@ ENDPROC(cpu_resume)
 
 #ifdef CONFIG_MMU
 ENDPROC(cpu_resume_arm)
+#endif
+#ifdef CONFIG_MCPM
+ENDPROC(cpu_resume_no_hyp)
 #endif
 
 	.align 2
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
