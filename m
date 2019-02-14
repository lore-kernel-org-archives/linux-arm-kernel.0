Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD25222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5r2xaD/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N6LgMgUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD25222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrsYHEMeLRAA7QOhA4wasU/MAYkhNnrkIsC1jmRQLAg=; b=k5r2xaD/ic4Ped
	QFmK7LK89BJiHiSQQABkqhL5nylI3u/F+6/Z+e2dCOMhCvpo0LNvh/eavS4rPw0XUNhQO+w6He5WY
	c12YEBgUoNVBy2qz4U6nYu4nopJZba4/FYGLrmOWTGosnbwNaNqBw22wD7kPEcYFngpwzI1BgQG4W
	ipFwOW8YHhFzxzFuAXbL9ay1p/CX5TmbBh7Q4cx80B2msJMhkUiqPTEOAWEmqgvTrQf5bK6zrCAG6
	lcpLLXE6seK2pY04AhXUTuRko2lHJgp1thkAu39IlnO9y9yO4e/ZP3qajlYsC/N+mVPRspLuDpfyy
	GWB9QOg8+BWJMYgeEOQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guISQ-0003WX-Ah; Thu, 14 Feb 2019 14:57:46 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO7-0005Vf-PK
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:43 +0000
Received: by mail-wm1-x341.google.com with SMTP id x10so6329133wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
 b=N6LgMgUTg+IZYFt1oItzJT+GVnkquYSUpsRiAzEskKWsnn9GKKLqkfTnLEYL55NRvt
 nZLAORkcFV6pE5JPEOqswH6+C4rn32KNWjBR02E8bag/gNt1JkL5DuyJ8T32Wz/L29fJ
 XKPbrErYXUQSpj6vJIQN8g+0wqfhvzlmBdd933MsuyYMqK7++/pPyK1TcFuO4bKuxshm
 tp9UO+h3u9EovUU6bzJWzLuXEnDyl3mTeOPzzbJ8yuZ0hPjWB73r/7aZFyWS/Ia/FfYI
 0mDDzWVdwiGaOLHAFRPJPmXudu6r69OpjBDi9jHMh4sut43DVc3OstmqZs0RneJGQ0VT
 Sv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
 b=fOxfkT+EbJKWWB7KryB0xDYtSxZP7xOgULEnv/3/qxIf9sB55k4Jph+uDEtTFaEZcr
 Z72bk3wxjgdWRgbM2iAhJVWoU+U9CVgZXW+JJk6IvC2V97Cj+axItNV9ONWuYUjovMg4
 nqagrpa2EQhMMdDAKUEF7cOFFWjzACgtbDSPjYuAq+d0Z37eoCy6ZkxW+hBp9CCO4EaL
 /bK9jSOoZbim/JZwjMzDHCHPI9YXhE+bYEwLJzEm815Q3oaEkN17poISJ+xTgSntoQTN
 vPjE6kEFz6P3zvxyD2mm0oTaK1epq0DqglUw/L+htv0gJK6FYf63Qp8Fm6orBshXrtrY
 N24Q==
X-Gm-Message-State: AHQUAuaVk3vOT8Rg7XKimHuUk/LZtkvWfc5Q2/vWFmgeV+q8zEGZL50C
 SgE7rYSi59T/4gRXZwHY1alk8Q==
X-Google-Smtp-Source: AHgI3IYYKY32gqWw7jHi8P2zRTLmHHDukiDKhcI8CUc4XNefmXsaDTt25Daz2M+QWuSENJPiLXvSKQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr3157487wmf.38.1550155998500; 
 Thu, 14 Feb 2019 06:53:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 30/37] ARM: davinci: cp-intc: request the memory region
 before remapping it
Date: Thu, 14 Feb 2019 15:52:24 +0100
Message-Id: <20190214145231.8750-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065320_359038_E2CE1523 
X-CRM114-Status: GOOD (  12.18  )
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
