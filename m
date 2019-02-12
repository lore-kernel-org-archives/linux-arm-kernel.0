Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CF420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIoHCsrH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TM389Kqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CF420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXyKLlcuwIJ/jsdi3RTNTGdBtAW2ke9lw+P8DR+4nMQ=; b=nIoHCsrHhDvpVS
	Us+r/sIfsc+pq3wTyA81BTq2058mmZ1N5InVEkO7uiN004oU5nJ4IE5ayPVfXDwiXgBUQ2Xl40m32
	uAg5RbVmqA4Mhd5XeL3Hy24OnVAZ1TB4RnzTQr+XUjRrU6b0Tfvz2BsT9IhHv3qPBrZT3w+JWbCUT
	TWpjxQpa2VEa1Xz9Gs5ckOANBn7XmfoEKbSKHnRAYHXClyBFbJTwnNz3OCRVF713voyqc0ThgOg/U
	ln7D6g7M4YxY7F0sj0Z58CP1yjCawj8j4JFtM2ImFPh6e57dZ2kT5LkLsCPqjgb5VDAV9mlLHcjbd
	vkiC6WPmb2RH2uGh4pCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVZ5-0005Si-L0; Tue, 12 Feb 2019 10:45:23 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTT-0006Se-W4
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:40:12 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so2070301wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
 b=TM389KqpbC5bwmcLby+pr8tycR9fW8iIapHqkDS3YAxCSk0GwBqD7TeL5otfm+yD/2
 YlBbaAVmGvFdmrRUbm+gQPjpzGwSaj3lUTjVwoSxERa2C6fRaMvG7WsXDQa8Rnew2z2f
 AuLVOzSvaTSBw5bhjFSZH4MuGdKJLAi4nA6YfLZ3ZjFnOMijp7x001Vz67vcxvz+LAz5
 mSkba2Jo3pe2shxwGTHLiUvD7Ek1w0omMv86dBoTTYU5WyqG9rvmpgQK7tj2AaJeOW5G
 5Gl9h/88+SPMd9p0ORmwLL6LQYcjdnrhbfU42SHd55fJUv/6G80b4R9fbLT4FQUDCPbN
 DhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
 b=QAYl9vKsvCbRvH9w/DxEFkLSsYgBZojNboR+tEib9NCZhZBb+cUkhTm4/0n1v03qRY
 ol4YIFMIx5Q7wuj6n0FrNOTwuEk4urqbNxJxVuj7hiMPzt9apY4cx9L7RoirYmfsU8Nl
 ZticShD0FwohhMYt8TTw60trA4noO9O3gTp/pxEGYeX6PyTqeSjcG558zO92jeqO+yPF
 6dKmj0gsRaWOlz9evGBBk5hhcnpAL3/Kj31qP8jEITIdhjEEFXBBSq9vZ16+Jb/H9lc5
 gEn8O1qTIXRiOgw++YNMgKExRPo6hFJaevC8QQsd4Q2ERucvL34YJp9HNZtUCeZ5Ohfm
 QMlw==
X-Gm-Message-State: AHQUAuaWK7fB+8Il6PtijnIwVk8tdSo+YTqCywN7Z1U4EGxhSbZBvJpa
 Ydu3/1kt6/v6DffCVNxNRJAXRw==
X-Google-Smtp-Source: AHgI3IartXzIlq/q5l3UPJBAx/H12112fxsKERl/fL3xF1FHDQrBG/gg0x9juN2adFb6mxtJI3klBQ==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr2273753wrg.230.1549967974733; 
 Tue, 12 Feb 2019 02:39:34 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:34 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date: Tue, 12 Feb 2019 11:38:31 +0100
Message-Id: <20190212103835.7768-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023936_158165_7BBDC7EE 
X-CRM114-Status: GOOD (  12.64  )
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 1bf11fa8be76..f88b7f0978aa 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
 
 static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_cp_intc_base + offset);
+	return readl_relaxed(davinci_cp_intc_base + offset);
 }
 
 static inline void davinci_cp_intc_write(unsigned long value,
 					 unsigned int offset)
 {
-	__raw_writel(value, davinci_cp_intc_base + offset);
+	writel_relaxed(value, davinci_cp_intc_base + offset);
 }
 
 static void davinci_cp_intc_ack_irq(struct irq_data *d)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
