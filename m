Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E8BC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5514222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TaFf9kqV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS05PJ+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5514222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DFKREbJWC+Gf/ZuUUzA0b3uVqUGSGsnNdaS03cgH1cQ=; b=TaFf9kqVUS7e2CKg2vxpqEMXUh
	m6WNJlG5DOMJblpB5z3YozW0Q9rOpDAyii7XZLVo+qyrki11kXUgEGTFAjFYFFIqdUR5TV8kCacQ/
	Tn7Gy77bATfIPsmAw9k1j8xlesUtM8+5gH7CvTbUrL63zNMzB8puZWPmBsgPgt9K4/BWjkFLMgdfL
	hz/ElpI/Dos/DIbDvwHIFszMK9Fbw7RkxZi964Y2AslA62LOjPwwmT1MfIwy2apNkEQn+Spy+8xrg
	cYBh/bfY2jkcMgG38LXzONxOhtvVYkn+tlUSlBBtSLsXGi25kYr0bxXpq1CLMk+DqZQxfllB9kA+Q
	F+FtqRAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrHJ-0001xn-ID; Wed, 13 Feb 2019 09:56:29 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrHA-0001p9-0K
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:56:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id i12so1775243wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fM3DtWzdm7lzNMZ5rtfBSNROL8nNsUNCCP9M4XkP7Cs=;
 b=IS05PJ+AujhhHNnbN/gJsZA9ubDgDZV+VgnzCvaP8/104J+n/9CKqBbRAO4lQVKcD/
 aA9o+KITB2HYtwyAlhLrVwa4dGDCziuw/XmE9Ofkbn668lrGbMHQnB8aWRlEkuRDJ9pP
 p0SPNqcrS84DSGImVJnFSd2ERHyK+jV9nBAW8Et4eMxOXlTGSfuKNoX8kmXlXDUbTcF8
 4NEEbl2oywDAaIADntO73bbsQCs5DtsXRsqHQ9PI1PzHqfdPlXXS45FIMFlcjkGIXgZd
 7/AEL3HKvDB22qaxFuJZrmXjJnTV/EeY6i7G2MMSp2IS1kQUpYCIox87Mawy/RKkJrKS
 o1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fM3DtWzdm7lzNMZ5rtfBSNROL8nNsUNCCP9M4XkP7Cs=;
 b=FebuPy7z/QSSaRmF3t4c23e7ZqohV351nvRzPKyctSsqWPpASpVIobH2tL9HH4hRZQ
 DRSgkvT2kLos8173rFi1sR8CkcA6B0BnDOu3eCeZAXxTQbopH8vF6Ov8AZrNV+wTsv6m
 NtmLvEOYDMkKu4uhVVGG4jbZOsjzVPNSJl2vHAWwroDFLaxmDiYwLO8jxP6H0jtICenH
 7Y6k/iXRKDTVbu6FKtLRmS6/kJtfvZzhHQHPQceeKutFlo5zcVCy+XC7pdsE+7mJQiN2
 bfJdrGhnyxO/zcJUiZ3gJOct7ecrNDPqxFkE5mQLjbjZs9Mt2A9QlM1noRcTy8PGHZWb
 p1gg==
X-Gm-Message-State: AHQUAubSw9w5VORSTG7K8OK6sqJXYpQnr0bzWjLFYtrnLMyjvrkgg8Xo
 oBTOTg5plZ0mU0iv1lJyFUGO+A==
X-Google-Smtp-Source: AHgI3IZu/qqrCsaG42W6vlIrjCqFfYCA5BLN654/s5Br5us1Fb8R+aYAv9rRekALAyFFqmx5KI5Atg==
X-Received: by 2002:adf:8919:: with SMTP id s25mr6317360wrs.38.1550051778345; 
 Wed, 13 Feb 2019 01:56:18 -0800 (PST)
Received: from lmecxl0911.lme.st.com
 ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
 by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 01:56:17 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH 1/2] ARM: errata 814220-B-Cache maintenance by set/way
 operations can execute out of order.
Date: Wed, 13 Feb 2019 10:56:12 +0100
Message-Id: <20190213095613.31045-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_015620_042518_EBF53218 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Jason Liu <r64343@freescale.com>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Description:
The v7 ARM states that all cache and branch predictor maintenance operations
that do not specify an address execute, relative to each other, in program
order. However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation, this would
cause the data corruption.

This ERRATA affected the Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.

This patch is the SW workaround by adding a DSB before changing cache levels as
the ARM ERRATA: ARM/MP: 814220 told in the ARM ERRATA documentation.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/Kconfig       | 10 ++++++++++
 arch/arm/mm/cache-v7.S |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..6f608558e22a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1227,6 +1227,16 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
+config ARM_ERRATA_814220
+	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
+	depends on CPU_V7
+	help
+	  The v7 ARM states that all cache and branch predictor maintenance operations
+	  that do not specify an address execute, relative to each other, in program order.
+	  However, because of this erratum, an L2 set/way cache maintenance operation can
+	  overtake an L1 set/way cache maintenance operation. This ERRATA only affected the
+	  Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 2149b47a0c5a..7ff7b4c197cc 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -163,6 +163,9 @@ loop2:
 skip:
 	add	r10, r10, #2			@ increment cache number
 	cmp	r3, r10
+#ifdef CONFIG_ARM_ERRATA_814220
+	dsb
+#endif
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ switch back to cache level 0
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
