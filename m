Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A98C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29C52070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="as8G2rp9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U72NF7bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29C52070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2JjvipgvWfpnZaAp9DBpitM/LANZl/MAxNyZLMlgERU=; b=as8G2rp9AhdQESP7c1OrQrBlqT
	Bg8gH5FweWz7t94zRB9CXOSk0tRoA6GKZiwGVcWiR5mbHCe5zvTiqt90US6TaTJzY2SyDD1pAT3Im
	jpXeO5CD3hV88eb0t+QytvA5LF+KEfW8IU9UzhfO5WR9LBoAFV+ccjNq53XRpjfXusc9wzj8r1yIY
	6OE8o0RdY6eSQjC32R8PizWpbTifU4NihHgfMznY2EdbbwKj9kBy1LkON3lbkVb1aqT5APv4gZ86l
	e8hVOpgARbniY6xXjjvLiyV6mg15gP3n4Z88X9/DBiixzRUkwzOh00GVTb7C5u7xsuHnEPfMnKGiy
	6VPM6dfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYJ9-0005mo-TK; Mon, 24 Dec 2018 22:02:43 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHe-0004HT-Mv
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:19 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so12523972wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=udGuEX53oRB5GV/3f+gVr+zAATNu7u19AoIlIUxdTxs=;
 b=U72NF7bm7zVcZBnH2rCG7LhaNv6Wl3/T8yT8P8uvpwnHTjTZnlFKcgrKE8BJ7HguUX
 c7pel5om9TouzlgT31UTRUiYtZeoFkQlLz8xDCMPjz7l+e5U8S9y5+P4/KMWICArT0EA
 MeN8UlkaiBQZ1Y4T9yWJoKoICesLXMwSL5AXrBf5FDFpws/fkD6zcjSXISemTIMC55gy
 DlnYUCbmdqF4wkxJAFtZgaBawkGbdRdORO3FkiWBXVuEQG225eSSAp1/aPntilr4gFLB
 UAC+W+faQgsDbYNkFGbmuFjWv7kQi28NWjtkAV8RYbKVXg9rTQfnmDBT8n9UO9pDawTS
 ujQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=udGuEX53oRB5GV/3f+gVr+zAATNu7u19AoIlIUxdTxs=;
 b=mQZa/4a3bTqv1NZFI6VjrqjjXdD/U0vXSoPj3jqO0IxK51RET49jnM9/lNQTJQMDmM
 CsnU8eVQ0t09xYKw38K8FxLuX263KZuUprhsj/vQp8GsfT8TvvM70jM4gic1ev7y4oN0
 6N/HgUea79vQVcUPr0tj5gRw31fWzuzGx1sX5ZAYxuXKyPWinFrGEQK3JHLXaHm9Gy6/
 ukwopekrKOcUZtHH/x47mGG1Wvu11ykXKnDMH5mOzatbD9jDH3+J5/RcWuWN/wctQzo+
 /wRmTfBUCvCHkJiKuRggo38nqaYqvnEhCmf1Yal9n+bKVaC4WDNJeBDH5WIy6vrK8Kog
 Tpaw==
X-Gm-Message-State: AJcUukdfq0mnF3oDrvEHlml+XGiRm1j1SFefuBlVp2E213O3yAEN1RZl
 +NjdgfEfI0Hy0OsTPoyC56A=
X-Google-Smtp-Source: ALg8bN6YCAr6jpBroycEmEomnBH6mIaMhIowdt8+KhGh1DaMYHkKnkplkuJQZbKV+nDKLdUMVhwvZg==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr12680550wrs.75.1545688859102; 
 Mon, 24 Dec 2018 14:00:59 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:00:58 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 04/14] spi: fix typo in SPI_STM32 help text
Date: Mon, 24 Dec 2018 23:00:30 +0100
Message-Id: <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140111_108036_2FEB885B 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Fix typo from STMicroelectonics to STMicroelectronics.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..ceb6b7e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -665,7 +665,7 @@ config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  SPI driver for STMicroelectonics STM32 SoCs.
+	  SPI driver for STMicroelectronics STM32 SoCs.
 
 	  STM32 SPI controller supports DMA and PIO modes. When DMA
 	  is not available, the driver automatically falls back to
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
