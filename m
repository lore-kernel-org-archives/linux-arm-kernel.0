Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F081C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E229A2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HeFOKJ76";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I2UR00xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E229A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bvgdyU2lf6DSBaRtbmMsz8A3UGST7nQBJ9IPTXsZvWg=; b=HeFOKJ76EIjRd1
	2vl1lR403cMNVDSokksXNniOvlhnzT/30Hcf9Y6D8OE4L0SccyAH39IByWBMBt88mWfhcaLgzQlRJ
	etU7AInBj1L0FIqQmjgbnp4qwAzrogM5ekfJrE1nVWHISz/UJVwlqp7w29XVSd9Yw6nxVxLrKDgjG
	16eW7aO3DDK36hLNFcm/2G2vrC4R8uMBSMyezRXJlSdnOGv1e8KtdXGmJRniqzIVGnzIdLLISxLp2
	trwQ5s/yZUIj+/x12f2ownOumlxJRjZsZVRzzNSf4qxgHpja2qp8x4y0DHWxv0dw6EPCItSc6XCEY
	LnexdQgKKGC9pXNWuNlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCeL-0002DV-E0; Thu, 31 Jan 2019 13:45:01 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZm-0005ja-JI
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:31 +0000
Received: by mail-wm1-x343.google.com with SMTP id y8so2573724wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RXeq39eWmFtFqzceOwGnZ9UFM2CvQxzUwG5lxEDQOVo=;
 b=I2UR00xSc5Qy4Gmfvcls86a1esPplq06/kGKZbZ15CTISczcRut/ms/OsfFKJ5wBLi
 BioURh9bB3pFUFwFBDMSo2/YbpnYqatXt/4Shk97uO1lFVHBd3yY+uhNNUaQH18RJjh5
 Wf9UGSBgFclG+YFAgxdG5EMbErVImUosa/ck5n9NtYT4GojlBtx292WaB8z2ulA6kkrC
 b9LDGIqSFIaNemKqMQ0qesBZEFnHVlwdcd5gHG4zF2nGM756rDcHAEzrcHAkgir0VDJU
 ogN+CaFnxjvJHkZMhgFxpGHtD7fyEAsOK/VvKk56J9X1crLpoEvKFyVl7W9b89ThdUSO
 MkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RXeq39eWmFtFqzceOwGnZ9UFM2CvQxzUwG5lxEDQOVo=;
 b=Kzoq40Rtd2y0lFqtcD2RnlKw6eK1LGQ64O5nHnHRnGqc2F4wx8BdmnOSeArWfw5bLW
 oe863xARhOi8nuYjNfpkbNozFaZRgJ2I1kGkTakI1Eq6loACK6neW2gu3gk1GU0u3J97
 Ljc6s9XNTT45TfOd82R6lLfHbtOFX5NKWjoyLMhvd+XkkYSwukMJPq+aZdk5hEhP7FwD
 bQqfgL6I2a6gdJ0jnslMnmcQOIdCV+oniMoicw5q0CPZn7EPIYR8UgRLD2luBGIgoMNa
 I6RD41SlpTNKAN4ICh432fYtYjRVk6Q3wHcLHlBac/Vw+IpmLgVLlOws5+g4B3OAoMlU
 5SDQ==
X-Gm-Message-State: AJcUukfuCsKrMPjD2S+sWCJhvvCBIJT6RzWLUQm+nXVaqdhBofk61pwu
 WaFDj912CpUc4rgS03spr81TZA==
X-Google-Smtp-Source: ALg8bN6geK0rY7RKjGKVNo7k31uHEbHPv9XscohM1HlHWkdrFIaOhltZrp4yMJeUiV0ocffkVTIMGw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr29516105wmi.61.1548942016910; 
 Thu, 31 Jan 2019 05:40:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 30/35] ARM: davinci: cp-intc: remove redundant comments
Date: Thu, 31 Jan 2019 14:39:23 +0100
Message-Id: <20190131133928.17985-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054018_863446_7A9F635C 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 780b3f57aa59..b5ace86c419f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -55,7 +55,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -64,7 +63,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -187,7 +185,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (WARN_ON(irq_base < 0))
 		return irq_base;
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
