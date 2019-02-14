Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B118C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1C1218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hHm0joab";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQG7VAF2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lAGM5Fmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1C1218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXyKLlcuwIJ/jsdi3RTNTGdBtAW2ke9lw+P8DR+4nMQ=; b=hHm0joabrFkSuh
	XrjOg78wM29KloH5wHp/WQw/tgZF7EcDFXry6tROeZFSyhL/pNTCfiD9rdgDeEXu7zd2swLLCcsFp
	IoRA/RqLQaSV5OQB5BvHB7g2DtMKuRSo1fLy34CMP5wLf1xzEBsAC7pfWVcq4rll6Xdu1RD9w7CKk
	5LPal3UHgmrZABtYtOgbJh6IdbUxoFx9OMNL8EMqILXaz7XU3GMA6KglG2BQKryWl7Pa9Ks4YxnMk
	JcVckZP4JfqSLwT7FcTvbCoXkcmEj60UM7r5mIOhGmXMsTjtjXcR0tXkyJCRBCB99NEUYQn+8biI9
	JkaFu3VYTwOdtir/YgEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIfo-0003xc-6h; Thu, 14 Feb 2019 15:11:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIf2-0002yt-Qs
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=; b=mQG7VAF2R8t/4isewoOQPBI8i0
 NqFfRKBkQ6bEBwdA8+A7IiQ13v0cpWl0wTmyTODO1GyIbroMkmNy7JR1iY1/YZYZBAtqhFlwSGqpR
 rmu003wRjkAei/QKvVL4CwyKwCTZdeHoaD63BRtlPiIkPZe/XOUbw5SY8/HdBjMPb+XarnZGtbm8L
 n+M95SLTrvUyZpnramybFJTt25U3iNKIpiP0EVnu0TVrb4X4MM7wvXGp3Ztl9hMJ/vHFSfTfJdoeM
 BtmFZJrAHZo6SMNQ4gSV9Om5UnywX07+O9cN9LWguFzCqjs/PBKKi1c6y6RkpTmyUnlUbql0Quchc
 R9akb++Q==;
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIOC-00062h-1R
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:25 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so6609282wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
 b=lAGM5FmkFOzhuGm8hihDzDp24yLDTJRuRFhRnXooQn59nuqRkQdRXYjYS+8XDL3gTC
 zY3aEFFjnt3WX1j6Bo0B+ego9QaF5Lj/7K09jV2Tv/pHhH7u3SdFwIajiN+z+BdmD+iA
 HoF8FMrHBtZq4nrY6lLEr5jb1M5feRLTLEz9xk1qhWnUk95tpFTz1w+Ym2Eey2EyarEE
 CrhVAihTS6OK+qqN1pN3NnVxD+Adg0e5/NOUbeHxwZfuGYgwx1Q77YsMiYxo8ZiLiByR
 8Rd9G5MXFu8rXb6aG6wdBJdb7hoNwNR5GB7ql7xBvy6CV/JtRnwaWGfDbm4mWxxTuthY
 yqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
 b=TQZuIczCMU97GVnVFO5PActoMdo0iNx9gep6iFdMzrbqpVrOANXcpKa7tld/dXcglZ
 XMlW/f24M3a5plOcsmrMrVojQfR2MDjODaGtd8T9ZEQYEak+jMiQlwP6ayXbL85eCnAF
 HkCCjgsX0EFDBx6bK+yFc79obuOE+KQRIrzalYzFeKkj6PmhpgFYZaZZwJ+nQSUhcP1O
 WnRnAiaCNVuWFmblmoVEfKp2uTUSlEFF3DXPsKeqrm+oaQjIoGkMypb3F/0WU2oiFunr
 G71MTR3EKJq8wkDJRli3poqMQ0WQgPPYRmyUd/AUsoK4VL43svF7ighfYyBnClVBdpu/
 3dMg==
X-Gm-Message-State: AHQUAuarWOn961A23lpq1MksXOYYtJKLGNTTvPqANwinE2oQnmZbtW96
 04eIaQU1ikN8Yw+eqFJDWpc//Q==
X-Google-Smtp-Source: AHgI3IYYMOKkHOZIFummh/UeZ68UyO57CsV/dlHGSXu0ERJ78EgGMLfWVhz3rlQDlK9MCkIowwD7ig==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr2953977wmf.105.1550156002069; 
 Thu, 14 Feb 2019 06:53:22 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date: Thu, 14 Feb 2019 15:52:27 +0100
Message-Id: <20190214145231.8750-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095324_150244_CBA0D4C4 
X-CRM114-Status: GOOD (  15.22  )
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
