Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126CDC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15C12087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSlDk1eE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C9neayi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15C12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HxsnnFMlYegj2TmTQ+4mmWMI+7fAUkRgWGgWMF8OtpM=; b=rSlDk1eEDhLzed
	AEGphovcFiCtUUB9Kp58kFR15h/9+LjLpaITxr4ey0k6p73bFSW69+CSR7LIAp8NPnNguLrFE63xa
	9lgvzp3gO8jyMFsknl3j0ipsmI0ynSNHSLxBKVmQqwSgUAKwn6X5FIdj14ZyQm8dtcolcaiF0/f4B
	OBVmBUfUyjcNAmisynqT7pVcQz4QtVLXnE7eXtR2cLf4RFj1FwmAp5cwM4xbhEUY8VcEJ66injZH4
	F4fdK+uyKN1Egva75pRfNoJ6wbWERE+RyWaNFx2ZRs8ZPPmMb8AvR+Kl79sEjjr4c+Im7vSzB/yHt
	0mtnUdXwvd6Ds27oXSJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVIW-0006Jm-1g; Thu, 13 Dec 2018 18:01:20 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVIC-00062x-Bi
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CWcL/Rs9KXzJcRDbvRIDgM9ZNPsgv24LAzEZVp2+Om8=; b=C9neayi/mlHXQib/ebCniPaLN4
 X4szvNS8AmEYeSiZE/xtCmpJJ4MfhumLVcf4q7u0GDDv61WVFtAoBPZn9qBvdoW42CtOUCw8KKu2L
 0yWLJ2XukB5S/LeV5My3nnpngu9RJP4rQT/iLUReKnGCKmE6HEHlkH/cS/eaVOnHsA2E=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49256 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVI0-0003s8-IV; Thu, 13 Dec 2018 18:00:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gXVHy-00088e-JK; Thu, 13 Dec 2018 18:00:46 +0000
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
Date: Thu, 13 Dec 2018 18:00:46 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_100100_395957_5ACF9047 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-qcom/platsmp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 5494c9e0c909..99a6a5e809e0 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -46,8 +46,6 @@
 
 extern void secondary_startup_arm(void);
 
-static DEFINE_SPINLOCK(boot_lock);
-
 #ifdef CONFIG_HOTPLUG_CPU
 static void qcom_cpu_die(unsigned int cpu)
 {
@@ -55,15 +53,6 @@ static void qcom_cpu_die(unsigned int cpu)
 }
 #endif
 
-static void qcom_secondary_init(unsigned int cpu)
-{
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
-
 static int scss_release_secondary(unsigned int cpu)
 {
 	struct device_node *node;
@@ -281,24 +270,12 @@ static int qcom_boot_secondary(unsigned int cpu, int (*func)(unsigned int))
 	}
 
 	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
 	return ret;
 }
 
@@ -334,7 +311,6 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 
 static const struct smp_operations smp_msm8660_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= msm8660_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
@@ -344,7 +320,6 @@ CPU_METHOD_OF_DECLARE(qcom_smp, "qcom,gcc-msm8660", &smp_msm8660_ops);
 
 static const struct smp_operations qcom_smp_kpssv1_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv1_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
@@ -354,7 +329,6 @@ CPU_METHOD_OF_DECLARE(qcom_smp_kpssv1, "qcom,kpss-acc-v1", &qcom_smp_kpssv1_ops)
 
 static const struct smp_operations qcom_smp_kpssv2_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
-	.smp_secondary_init	= qcom_secondary_init,
 	.smp_boot_secondary	= kpssv2_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= qcom_cpu_die,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
