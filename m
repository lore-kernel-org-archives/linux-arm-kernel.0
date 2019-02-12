Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E81EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298232184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o5om9V/T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2J/4S67k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tmyvHaXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298232184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ev7UY7Xa3TUY7yBYpJr8w2M7bKydBJhKzKPB2S87xl4=; b=o5om9V/TJbzMVX
	OawYHgC3TWYRJlKZYW1pbjzhPfXluMw7nrTKVVyBajnfBTTLGP4Qlus3dQdeCdU+WvT/hOjW9rv03
	0QD/pZxyiF+T0hmU+4MeXGLCqBmIq/k2eLxP7Hr7xA805uVM6cMDcS+pATcPImHeefIit0qc1V+bd
	xZhJfyyaiUfpW+leHhaWdfRRsf0dHd79IIKC84A5Iq060+ZHd+rJNtoRhmg96PorpxTJyj7/zgivj
	5HpNbasnag/QYnSEqSQV9XxwgKHARxi5Qn7U8X8d1YkC6w0BYzSrC7lKkth+qZrIQ0vQeOFOS0qFG
	TXUlyfUyXoYbCOEWGQRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVyl-0004H6-4O; Tue, 12 Feb 2019 11:11:55 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVxj-00037j-3r
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 11:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=; b=2J/4S67kVzIaJb8g2i7inupUV7
 UIsP6gzCJSl6eJdRhBI2Tcrt81OxbE7Ol3ICdeD7Rh7dHEoEj7sEQtexVnqv1mhdjIH0tkIe+z1q0
 Kk0tx0iyHLHFWxllxzCgoe3lmjHyKrlX9RXEgoXWMInu+a9MFySk1Hxn5wiz3Y7z8FoG2FR5jhQVp
 FzLSonI48BpIriv4XNywdDvM7R4nu+h6ZIgmYT2jcVcIHeCKpLbBaRgkitwUHboBDW46J9GbrkW1v
 yEuZrFAAKsPBCeh6kSExvD3aS7YG76+lzK5moYSvTQXRPnxBuC1hOXu3rubOKoAsUTZNNq+cctedz
 ZQwm2bAQ==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTN-0002Ey-33
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:30 +0000
Received: by mail-wr1-x441.google.com with SMTP id q1so2079691wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
 b=tmyvHaXhafzoZCETK6pLl+VJISSXXE+MLu/MWUEXKZcKqffCjnTOApiQTSB260rV4D
 rNPniVKOTNjrsZB/o9x54UiXTI+OZrcLLMaabXzOuSUJpXHSv0azcSeGtbxwpIfwYVQc
 87EIxJN0iNsWJyaovldtXZRk96qPbFyfWVdtJZAZC2UK6UosVVT6L2PT7x9hw4QMbU+W
 qidaTf/db8bwFEP/2HaVALAEVbGTibc0CvyQfbHHA5vQaDL1QZtG9h063v/P0uzLWn2t
 +GUZ9JGOWsEHFiObmB+Tp4a9IBOkhN2cSa7i/X8ftMOtDDITv1VEomm0JBZC3WOWPxxP
 ZLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yRSCRg5rDKszKeNaGzOxkxAIRW2gEt2oxrvbVDGGZhU=;
 b=LQt/vVXryXBO8QXEAJHUy85QF0YAEKT7whHgCb+ucmKhatYzHKvBgvQ30UUZD1C+pS
 yZZi6ynAkK977Nzq8/3W1RZhNJp6YR6If479DGiYvoKl4mxhPGnutAjN/osJEdJlo5pz
 T5ZtitRmAZ1j20fu5wp6EannCCT/QcBz858Zd7KNVtf1qHZ/BK3RJyt6zhZjQTCa4scj
 O5dNOzsWsYYKG8jUtZEaPGWmZYYyH2x++UCDc53UwLT9RWSXn6p33w/qZkgTJqvuXlGH
 A4cjf9vycT2rLs0v9JomqZ2l+uF3dtzTwaPMRbEme0XH5COnDnt/TwdXstFNPj8gjQNR
 NldA==
X-Gm-Message-State: AHQUAubS6/cKwzfNw2tdWyYfyK9pwiwFIDQVB7+S8UKBSaNuQvem82uV
 LPXyv3O7NXPKx+1U/whgSKa+Dn7sVCE=
X-Google-Smtp-Source: AHgI3IbS4foHUw7pK0o8dw5W1zhYL+xNCC1cGGH6wgWM3eKHfvqmvzGvPWBcbdoWdS9w4oqFSmYiBA==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr2229874wrs.94.1549967964889; 
 Tue, 12 Feb 2019 02:39:24 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 24/37] ARM: davinci: cp-intc: add a wrapper around
 cp_intc_init()
Date: Tue, 12 Feb 2019 11:38:22 +0100
Message-Id: <20190212103835.7768-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_053929_252491_B7654B1A 
X-CRM114-Status: GOOD (  15.76  )
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

We're going to extend the cp_intc_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/da830.c               | 5 +++++
 arch/arm/mach-davinci/da850.c               | 5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  | 2 ++
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index f81c92b9cf07..1ae7dcb8f59d 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -694,7 +694,7 @@ static void __init da830_evm_map_io(void)
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da830_init_irq,
 	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1cc49e7bf128..8022ca8ac4ef 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1522,7 +1522,7 @@ static void __init da850_evm_map_io(void)
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index eb6a9465f229..815f155eb349 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -623,7 +623,7 @@ static void __init mityomapl138_map_io(void)
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 7f852722ff08..673d890c2e3e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -461,7 +461,7 @@ static void __init omapl138_hawk_map_io(void)
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irq,
 	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ca903c9105e4..5cfd30c57429 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -821,6 +821,11 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+void __init da830_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da830_init_time(void)
 {
 	void __iomem *pll;
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 486d53481636..6df6994c0f26 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -759,6 +759,11 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+void __init da850_init_irq(void)
+{
+	cp_intc_init();
+}
+
 void __init da850_init_time(void)
 {
 	void __iomem *pll0;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ab4a57f433f4..1618b30661a9 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,10 +88,12 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
+void da830_init_irq(void);
 void da830_init_time(void);
 void da830_register_clocks(void);
 
 void da850_init(void);
+void da850_init_irq(void);
 void da850_init_time(void);
 void da850_register_clocks(void);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
