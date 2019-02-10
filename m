Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:12:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962F3213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTzE1qm9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="hzcZ9rxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962F3213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZFfqQ405rTlGaXDsdsNjLQu7m2kn4h4siiOBxe2vhsc=; b=FTzE1qm96ZRTzI
	bKlG6DxmcZ84GAc8Mdaz/bshwIecuKnhc9uhHn+zOpLIQj5mY0bY2/4zrpX84szflgC8RC+ipaEUG
	KMkGpP+V2+HFGBVVVnoTdd4G1lO0JeXC5nmZJJL/ZpMdvaIoP3WMfA2e+a63O/AWWCngNVVXH2QD2
	HufzgQACi1akfax0lfjiHPqrR3k6FJ8ng559YpMAAguU/loqPcFnU8Ndv1WGpFzauPwGsTV2Ze9EN
	CCGN5xD0fQ5KM9HgSAR4Jz68TfiloiWFtWX0Xfpk1LfTE6LahYlxW+0i0VkDDsVotl3x3kRxytq9B
	uLqPTp2JkvAJjmuScYsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsyGp-0007Io-Sg; Sun, 10 Feb 2019 23:12:19 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsyGl-0007IT-IP
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 23:12:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so14001876wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id;
 bh=oVLeNIK2v7xGD88oxSGqKlkJywd3+U5L9XFsrljhhLM=;
 b=hzcZ9rxz7nfFwp5Lv4608WnwEwk7Fn3pd2GWJSDGEN+TJ+1R0A4u4ErCW5Ryj9MkFT
 gzKSpCxjqeIKSvcgjj/adMTCZBkbtjnex89YR1xDWSq6S3++bZi+IoIda3R5JQP9K/3s
 rQmbDQ8XncYENJQIrlz9DAyyvv/lt+/aRLbs1T0TFm02ZmoEOTWw2rhkIEtSfmEnONs3
 TkG4S+nHUTaV1oVBakOZdkDSIwrrgxPrmDgwrw1UZJyK8bqrzNb9JB9Nu93f0KGUwQMv
 fFHhZS43Unq8LTFf8+j7DBjenGD4UgGoAVmtvqD7AKI0/okoO2I6LoWqoqSxTJUfI6JO
 WZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=oVLeNIK2v7xGD88oxSGqKlkJywd3+U5L9XFsrljhhLM=;
 b=O6H6fKF+MVxSEqSZtVjHqcRDe9Yl12WaqR2QTar1uWbEMmwCZro30U1b5UKTmL3AtL
 TYj3jfBQM+62mZsR/jTzZcKqL4A6Alr9wmAshWYTQqJ4/f9S6xU3EFaNHjNFvUJvXruE
 Nw3AYi1VZvUueUwfH4v/mQ7hhKKsKBVzhKwLC5+wcn2fW6yHeD7VG0sAcPwhRIitfflX
 M6LihE10BOaUILKEP83lTC4f9Zj5qzn2K89rvvr799whvEkyX83fKkU51G70yRRCjhXv
 mD4oVEoYAZvAyP4K+MwxYZvIBa7b2O61G4EwQKs5yHeJge1PBvWM9lGVlHtrJWWpK0FG
 P7yA==
X-Gm-Message-State: AHQUAuZ7cEE4pqfwrDmjH81eR/IA/adF9VnMCo9YS9YoM/gk04h0eYbL
 0/UqUI0PDBuOmAgBZsThuMWbIA==
X-Google-Smtp-Source: AHgI3IZ3Y2ayJZ8czzdu9TXxKnXntPmATptyuoV5GjnC7k5wWo+C4KDcl3pYAlxNRATx6ciESl446g==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr6992103wmi.37.1549840334025; 
 Sun, 10 Feb 2019 15:12:14 -0800 (PST)
Received: from localhost.localdomain
 (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
 by smtp.gmail.com with ESMTPSA id y22sm21101858wrd.45.2019.02.10.15.12.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 15:12:13 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nico@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] ARM: MCPM: Add provision for platform specific wfi alternative
Date: Sun, 10 Feb 2019 23:12:12 +0000
Message-Id: <20190210231212.20470-1-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_151215_607055_1D76CC9D 
X-CRM114-Status: GOOD (  15.95  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On some platforms (in particular the Exynos5260) the wfi is not
executed directly by the operating system but by trapping into the
secure monitor. This allows us to replicate the behaviour of the
vendor supplied kernel using the MCPM framework.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/common/mcpm_entry.c | 8 ++++++--
 arch/arm/include/asm/mcpm.h  | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index ad574d20415c..524be627c87e 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -289,8 +289,12 @@ void mcpm_cpu_power_down(void)
 	__mcpm_cpu_down(cpu, cluster);
 
 	/* Now we are prepared for power-down, do it: */
-	if (cpu_going_down)
-		wfi();
+	if (cpu_going_down) {
+		if (platform_ops->wfi_alternative)
+			platform_ops->wfi_alternative(last_man);
+		else
+			wfi();
+	}
 
 	/*
 	 * It is possible for a power_up request to happen concurrently
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index acd4983d9b1f..96fdb41ac626 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -223,6 +223,7 @@ struct mcpm_platform_ops {
 	int (*cluster_powerup)(unsigned int cluster);
 	void (*cpu_suspend_prepare)(unsigned int cpu, unsigned int cluster);
 	void (*cpu_powerdown_prepare)(unsigned int cpu, unsigned int cluster);
+	void (*wfi_alternative)(bool last_man);
 	void (*cluster_powerdown_prepare)(unsigned int cluster);
 	void (*cpu_cache_disable)(void);
 	void (*cluster_cache_disable)(void);
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
