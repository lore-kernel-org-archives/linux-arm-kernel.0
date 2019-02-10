Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F202146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hS1aiL9N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="poEtcwpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F202146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NP5la9Y/A/dkqOFMosNJ9Sdhl7/DdkA+sBh8SH43KnM=; b=hS1aiL9NWeanszPpwj4+VefDzp
	gAxumRMcYLJZyRO5TjbkXmdF1t7Keo8WpJwGdSZ+SxbCX4ihvpeMSNF3ShZPwML1+WbShMwRnZaMn
	9A0RCXA9BXggocz6f+K+VyvgsFZ0ZUX40H/Rvh39Mv43yslRon+rGGfvwjLVpOivxmnJaHzjXKVgu
	4naB5GNLxfrLaszgJZ/a6HF6Isk0b4SOxvYsAQT8QrtH7FTJ5n5XWE1UPHClWOEKTHIRnJmPOmbcA
	yAFFLzPwQSmTJK+QCmn8/OYO16u8Q1/1O+uRI1qVWGn6nBcYHF1HPV3kA0mOoaPDz6ARdpGatXfv0
	m02NJHzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxx7-0001MX-T5; Sun, 10 Feb 2019 22:51:57 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxwX-0000om-Un
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 22:51:23 +0000
Received: by mail-wm1-x342.google.com with SMTP id m1so13956986wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UxJjrGC7S8wuLmEIVFRAlM1pKLfRQfIve9rD0DYFhcM=;
 b=poEtcwpA4f2mQKs6qAiivo18iaDEe7zxRU2bldCaLMf7lll0XSdV8/R4+SElYbzZtW
 5BRKDLmv64DKuYZbay9tKh1PtL0Vlu2IaR3alSYTR7FFv7/gLpHzrbo1qkVIPewwQ9q0
 vpqh/FZ6uMCiCKRXtRq9n2IUtKGpwq6258H2lomwZphLeqQT8zykHM56cj/fg+KiZZ3U
 iXZKxX1klaswCvgYcApmrli2Iu+kPjvajjjWP4JogvJsgmv7lmb6qThWJgGeJEnBeVq1
 wBPeIC9gaqZ+GkmjfPa19skmU5GHkKPBs5v+7o2t3btTsg30yuVY7sKTTXRhwuydTR46
 0rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UxJjrGC7S8wuLmEIVFRAlM1pKLfRQfIve9rD0DYFhcM=;
 b=JskCnBYvpCpJypJq2kMTfii1uQtpWwM3IfxvMdwuQ4CFKuRGgwAdx72StvYQAVHfla
 8ts++Z94guJ/57BuF3HRoI7A9COmkEH/cW3TocyTFleSrfONDdcF2jJW+moMrnTlz9JQ
 f37x0InW40mKa1B5R8m5ioauQlwSCYfv/xItp58F58PgE8rPnqddstrcZ1VySr62C5rH
 BVtERjpsr2VmaJpsVmFjeTYliYFuluOKyoDe13ZS7DlUpBzZAQwVnxRUri6aVcI81T3J
 QTdjkfxl1HjqfKSDuc1SQog4o+K3+Rp8PICDGb9kfaCBpKp3rcXWUmigqFT2l0aRqLZt
 uFDg==
X-Gm-Message-State: AHQUAuYH5rCXv3W4uo1lGkYHhXYeIG2BTK1/lL3bzlpoS2OifKf/zBhc
 We/mGF/1C5+jRFzn0EzgIBrt90aRrov/Dl1c
X-Google-Smtp-Source: AHgI3IZectTBQRReNF8QKgvrBqrQimO7K4hqtf8S/K3t9zoe0a17CHmZfN+pasIL1lTb4VJZ8LxJgA==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr20533185wrr.271.1549839080355; 
 Sun, 10 Feb 2019 14:51:20 -0800 (PST)
Received: from localhost.localdomain
 (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
 by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 14:51:19 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
To: linux-samsung-soc@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] clocksource: exynos_mct: Clear timer interrupt when
 shutdown
Date: Sun, 10 Feb 2019 22:51:14 +0000
Message-Id: <20190210225114.20110-3-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_145121_987622_83B4F16D 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Stuart Menefy <stuart.menefy@mathembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When shutting down the timer, ensure that after we have stopped the
timer any pending interrupts are cleared. This fixes a problem when
suspending, as interrupts are disabled before the timer is stopped,
so the timer interrupt may still be asserted, preventing the system
entering a low power state when the wfi is executed.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/clocksource/exynos_mct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 1e325f89d408..d55c30f6981d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -411,6 +411,7 @@ static int set_state_shutdown(struct clock_event_device *evt)
 
 	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
+	exynos4_mct_tick_clear(mevt);
 	return 0;
 }
 
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
