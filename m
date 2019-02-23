Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4029920661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7TnmFhD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDySiRAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4029920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BJ9VLMbXD2bMafhQoaWeE04/QmdD39J0rpeTvofbBrk=; b=p7TnmFhDtewcALQ2/+no1SqEI2
	FVq90QGCMItYrHKtYZGEIlUV+wGHbiE9ekZUyL8H23Up3S4IzUvDg7MhiTH1PorFzKeNDTJt5bV8r
	/Hyuqb9yQQTIfYC6gYDzU6rHe54lx+dY5j10io1tS5NLcTJC/A7nuaKDfkcwpFixa4drcBrKJyVuM
	qMR4zIpDvD2eN5I+lgfX2BoZ12EzhAOUIpEfNtt4MlcHHJ2LlOYsrfxCgkmhXV8maQnO7aurlTjfT
	0qoy/yOWXzv06k1f8JbkPJu6KpehNKdrOUR+cEx0d/b62kpCSyvTwbFgP/6RDqNhDqYCtkc8XQaWn
	8zPTuCXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX3M-0002ga-E7; Sat, 23 Feb 2019 13:09:16 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX2H-0001Q3-Hy
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:18 +0000
Received: by mail-wm1-x341.google.com with SMTP id y15so4279797wma.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HqlZ9y60+g61RglAPoiE/a+Pic8KuxjtCcTeAXdOW8w=;
 b=UDySiRAEDlj+2/nVLaWr1kRMDEterDlOGCjGMrfb5Qcyxd3BCAjB9t+XzXvOc70r3G
 hElqqI6om74Ug3hEio91Ol9EbkkFnJh2QrbqlI8cYMgnmPq0FzrF+EzGPU/HkOk5LeoQ
 jAQfXM2AF4+g3cZ/2w0YDGcpBJ0D1pLuZ8DWVLzmc/V/cFVS+7td9moAOrKf0WPbUW3d
 iF/+XVkeqPq8o5/wskCbGn7u2XlxHuISEU3/imhDFYLwjNvihWjcT4Q3IAWMKbit+t3N
 DmTgqKugwVilOQIhbZ4Ma4I57VG1bBKd6WiDIxAQgzjGmOr3Fs6ht00liZAW+d4iraDk
 QJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HqlZ9y60+g61RglAPoiE/a+Pic8KuxjtCcTeAXdOW8w=;
 b=gODzb10DcZ5GN47HPPkvYUvN9l4bFFKE1mnlZbmibokhU15Dd++kB+ctaSHql3dh0n
 1owZPbzH6qScGK33b2QbSlOMywswGwFN75xDY+rhTScuxK86C1ZnUdiKVH4PvIAi5se4
 WzLVrtp/29/UqAcgl9ayT7pDTcF3oxWr85HXtvuIuUtJlUTK7wqYDXvvV37bLa3a/XyQ
 ISoBf2QHHDxud2eqEnVXRiA1Qk+PpKwPd2C7136o2VZsJOnQyI/dDs1Ijp8Qf8EISeiS
 LFTzfm/roZnoC6bzMktYf5aMEOAeg8mCE1Pkk3zc+TR4O+H6kJpDf0Ydpdw4paDIfFif
 acNw==
X-Gm-Message-State: AHQUAuZW7+69aRTRcAEjDw3ifRlYWbrgM5zgAWUDN6UdqeT11aOkbA6+
 cu595ARVEzsH6q4eREtise0DGA==
X-Google-Smtp-Source: AHgI3IYxiS+rGiapRCkzcSK+HOI3psbZAHYZpe7CQU9xEIZxBMd7B1DR4p+Dsn0MoLQtcD+1MEkOWQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr5676166wme.93.1550927288008; 
 Sat, 23 Feb 2019 05:08:08 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:08:07 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 09/18] clocksource/drivers/exynos_mct: Fix error path in timer
 resources initialization
Date: Sat, 23 Feb 2019 14:06:57 +0100
Message-Id: <20190223130707.16704-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050809_943399_E68C7FAC 
X-CRM114-Status: GOOD (  15.05  )
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
 <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 647ea9fc752f..33e90c080877 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
