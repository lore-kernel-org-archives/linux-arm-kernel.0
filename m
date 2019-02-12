Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD2CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1C52083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bvutk9Jq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLO8gMBM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mLvKm8fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1C52083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrsYHEMeLRAA7QOhA4wasU/MAYkhNnrkIsC1jmRQLAg=; b=Bvutk9JqaUh7lu
	JghJXsWjgWFKlELTIKY8OEKKIf6gPQaE/c3lNCHBBwf0aUPqxTXAlv0PBBQWJLX7Qb6wBGyJg1NkL
	mAoMNMYnENAgHWYKSShwk+XLLTJcVcTHWeaRcvtvJG0mnhPHMp7IpzfqgrT32KsDbWWVdOyxjTgNJ
	nSy9pH5rSG63jGoFVmvlwEp9ij+NcavElVVEmR8vLg4gdGuLvklnZT35CfTSxwAl6tG9fk4wTdA8P
	o40XPzPMN6aS780lcXF4id5HbdMk60rCl1nWZZqtctz2lq6yQtMU6yxAanOUHE1hEfKGPT8vWTy1V
	PLskS3klqscXvkKkIRQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVj6-0004Mr-U4; Tue, 12 Feb 2019 10:55:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtViL-0002Da-KN
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 10:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=; b=CLO8gMBMTdyDek/R54gdFXkV0P
 95d8khSNHGJ6B9+iCxfQ3ShNcuzo48GMH1tAXutw4QReT2H3/aZ72koZhegW6BEtS7RibhMycuol3
 enTrXzeL6Nkjv5iAA5w9J5aRWfBhwp4VwzJLiK+XJbkEB0PORRKIEJ+U8QJCcBylnUJlSiR3FA67a
 jOMPM8jnUtSZ6XxMOR9n4Yudw3xwyZvFhC81ubSxql5sVNfkqJbbro35hukPlDPGP2eipAL/LKoct
 NABHg8INP2IY++B2PYsL9+2i+1ITJelUGkdbKQyR9BVyDj+d53aSf5BiGyWFPnsKQcsEV9apkZLXX
 N7QxWMzg==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTR-0003mP-Ic
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:35 +0000
Received: by mail-wm1-x343.google.com with SMTP id q21so2433904wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
 b=mLvKm8faBmaSZPHhItRIrOvDCDbvaF74ATZ9/dNkb0nIZKKBbdor5rGls7iviDTPQf
 9nf/8vXwNbd6qj1fLcOyn01tHibzGG6oelnOQ5JAuEbLnHVcFrDWQ5JBiZevuiAj5QxS
 6cVh3EtDraj+vfcOQtkK9FRYQooStyuElkq9Pwfd0t3LPOXFe4CgdulB7xwYPUkYzsVr
 boZd4X1emt2mfICY/z+e/cFlSt4BzNRZ+j7/4lCLilOUfNUGSGEt723bUUzDtDYQ98M0
 Tow2dQDvp+5DsjM8EbCMeOptuDhhPwmUimYeBGGxLYXvNjFV5uh5Q1Hm2g61mzfAVA0p
 a7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
 b=UeLzYX2+t337XZ0P4pSknqbrHDauLWfeHiigOCNlKA03hCmoVxr7naIOvaeH+4EMPg
 xPjSzGHTY+8LeSa30BvYn/CXoOGs+iFIcAwEwIe/Dvms+Zi8y+2SSwPwTo9Kv1J+veEr
 9e8+q3QCPlXJmfssRvWwihk/ACl6CjUAlgc3p7uUJgRT1qFAPyPJ3RFfnHyvJKDbLa8i
 sNCGX1YbVtz2hgytPdGPe1rnEqj7AsWMw95oVCM4T1FrJ4FKdF1YgTPxGGnLjT36+lly
 R3Y6gFUWnE2VQkGVWhjs/N9oOJMUHftnIpBOVHi+WSyzxwkONh+ATnLaKUJ6+jo/hJrM
 xVIg==
X-Gm-Message-State: AHQUAuYWNDjdLIl+BBPb9kLt4GgcyAIuyoJbxDwt50H4qdbykOxSe0Nb
 2XtwFW2FZnzru5ieOFTGkHA02Q==
X-Google-Smtp-Source: AHgI3Ibx+3G3YCOQ/z6DfdWlABUsf04RZB2zekk9W4VeB74BGyH7ukL7QCGXdthZbAf/BelDZCV3FQ==
X-Received: by 2002:a1c:7710:: with SMTP id t16mr2232819wmi.81.1549967971406; 
 Tue, 12 Feb 2019 02:39:31 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 30/37] ARM: davinci: cp-intc: request the memory region
 before remapping it
Date: Tue, 12 Feb 2019 11:38:28 +0100
Message-Id: <20190212103835.7768-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_103933_632825_3BF5FF73 
X-CRM114-Status: GOOD (  14.18  )
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

Add a missing call to request_mem_region() before calling ioremap() to
make sure it's not been requested by another user.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f56a4275083f..6ab56af3be6b 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -164,6 +164,15 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 {
 	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
 	int offset, irq_base;
+	void __iomem *req;
+
+	req = request_mem_region(config->reg.start,
+				 resource_size(&config->reg),
+				 "davinci-cp-intc");
+	if (!req) {
+		pr_err("%s: register range busy\n", __func__);
+		return -EBUSY;
+	}
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
