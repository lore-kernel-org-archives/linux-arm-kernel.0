Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FCC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D756920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q0jhw6cr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSVc/DD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D756920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=b2xi1+1XNkmJYWxbOM/MZpy6sEig63WR5azVWYPt4o0=; b=Q0jhw6crU7JGBrUDPEgqfDWwyf
	hxg/kTIY6uFiGs7qvYm22gYJwW9pw0P2bDHrfBOHShvdm/Lpm9ryEhVCyEhopofca6+r7opjrgORu
	BAD3yRltsBDNj+79P8whzmk+K03sFeLfvahsENCj17QLfS4dsITVzR/HACwPLcu6yFzYXpid0RQtJ
	gbnnhc86XbhNRyxyAX3nGssMAehXw7GhWcSf9Q+If5P6dOt7iXlzt0h49JbHAy7PzmmMmOjPjklFB
	vSWYN2BXXtaSk132XF3X7xAs78U0UFk4DPfKFBVsEKbw3u3wr/wyy9PkHwwR8Jde65QgB9Zx6Sk1I
	tnFJ0e+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX2r-00020m-6a; Sat, 23 Feb 2019 13:08:45 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX29-0001HB-Kz
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:03 +0000
Received: by mail-wr1-x444.google.com with SMTP id w17so5158959wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1aU82OCB8EaU5gSyx1GLNfzRZ/n+CtM0wF3xQO3ltdE=;
 b=qSVc/DD17GWnUdCpaw7WaO089XVB4WI0aYdiodmu3f4mRuCbyMNJjLWac5g+UrKCQH
 z5WOU7kh32bdNH1BYvU5e73cwM1JmBOGIArhuhbVUZPeYPVjs7OhbIfQPSm06yXJmvZC
 7MePrRJ/7paUPIdNOEjGgDt+YrxchIsvPmno26wEolNiHDFzqNalM2LxtzZhTPHmBoJg
 zlCMZ9qGohEvCxa25K/jTtMRzVF8icL/EeS3xumqm7Bi95oUXE+uABbAD+HAPAZ6W+Z0
 Q22ZJV1TK8DE1kk4ypHu5Pqu3PS/UYih/I0c8u53EQvgweT2Wcg1dwoNOkCMJX9HTkNG
 E/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1aU82OCB8EaU5gSyx1GLNfzRZ/n+CtM0wF3xQO3ltdE=;
 b=bUI4ABu3R8XO82k40lyUxqZ5jGowb6QQXPIdZGc5r4qv2HB9gT8GqBvd3sHuz+yUJW
 5DIQc8PB3k2rtgcbHVehakwZMFvhpgnAZjKAQa3VcPqTv4fSADcJtPFKIKG+5l8i1k7r
 bd1zeXSmPTH/DtohOSECI2mlDx1XJveo/1nx63/UOaeIKhX5DIvHStwZwVKmKiyEWwEG
 1SK53V2QHivcTLcZiCtdGl8R38rHHHmdSL+5ytTTkFFAiNzef8NR8DkMv3gAue2GCZ0V
 5RaxC0RMZnLF/tx/5peNYZaAghIRFr3SqenVKjM8AJGoq8/t7Eabxgt+PBSOuq414say
 wERA==
X-Gm-Message-State: AHQUAuZp8mMidcllRC02wcHj14hHEOH5wrBbbAvTKTgzSBQSSoOXWqX3
 3ybpqLDi+qB5zgFmDmQxCCJgqg==
X-Google-Smtp-Source: AHgI3IbVSKg4gdtbIp6JL/bIu4AfzpxP6z3ySoB1CaQgud8u8kuxTeg7pUq6c1WhDyxFvU9/cajSHQ==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr6191029wrq.90.1550927279831;
 Sat, 23 Feb 2019 05:07:59 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:07:59 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 04/18] clocksource/drivers/exynos_mct: Clear timer interrupt
 when shutdown
Date: Sat, 23 Feb 2019 14:06:52 +0100
Message-Id: <20190223130707.16704-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050801_686056_FA86606D 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 Stuart Menefy <stuart.menefy@mathembedded.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

When shutting down the timer, ensure that after we have stopped the
timer any pending interrupts are cleared. This fixes a problem when
suspending, as interrupts are disabled before the timer is stopped,
so the timer interrupt may still be asserted, preventing the system
entering a low power state when the wfi is executed.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
