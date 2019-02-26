Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4720C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I3gWaKCh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfhQSPA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=B1Dpm1PAh8KonVOLj2lyEeghbEaIvkx09hwu1/gGsa8=; b=I3gWaKChIC48UkwELb/tl6dB6/
	IiixiGlceDfihSXYtJh8YzIpRVSYmCg2d4YDQBqVDa4bNqu81cMsqeti1ggRScv6wpT07tkG7kkaw
	uvOsNmUnsyjneI3ewuDz7ybboacEGFlfox2PWL2Ae9qIsCRDGgEcokZKuPX1Arr+sO9rXFV3oi5xH
	gmp9RD08sARIaGGLzDP4tQLm8nABKy2KWB95QsRlmKCHtEVv0ydVNiccRt0jKJZIlhWkPH+WWLAVG
	l7IkHVG/LsP7HF4fAP3gVmPYkdcQhcNchktwxQlQ57Bin6svKiZtCe1yKoh4mtbwsy5eLwNF4l+Zh
	tu6sYlpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye8e-0007Ce-4O; Tue, 26 Feb 2019 14:55:20 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye7z-0005Os-HD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:42 +0000
Received: by mail-lf1-x143.google.com with SMTP id a8so4044072lfi.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CizRMe2YmHoMDQUcJ8913XbNFEFzGgJHDQtzao5WKiM=;
 b=kfhQSPA9AMik5mPi+zuWznWRU+Lb20kx5Yl1pd6vQyrPRfnG2ZYWVm4Hs9i5AjRK0b
 GnRrB3iYlXym2YsokbhWJCIunemOZzuO9vuqHFOLcbCrDm3wSn0ZApSiB3kPmMZT4ZVe
 dmDlZ3gGNBUQRE0rvOZn3OW2DWmlz6edcGX8vVCXxzAE2yqcdM3MZffJJb7PJBdYLj5l
 5oQcGO+AlfUyq47Vsk9LJnj3r6W/fZpU73n4kFJDER7GNwbFFwflAQ8+q7a+UCe6ax7Z
 8ZJPmf7ugZk/AuUGSuMdngYkcUPATcadWzlgy7bJo/HoChaXuWSMnkbwXRIT90W6tXrv
 Rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CizRMe2YmHoMDQUcJ8913XbNFEFzGgJHDQtzao5WKiM=;
 b=X/8oTbMNHddgExo/VKBaWpKCd1GZISI/DXJO5s0mXADLDiaMuAQnVx+UZzREojP3R+
 fZkiPOLZtNpqweODqdCtCwZr8iwok5TzzN84Fp/d55Vl8IuCeeJaqup0ohsYvk14Ve7o
 f4ARcTg7rIjCOoZ+i6BCiRb/aml8tocDvqJhlkX4eZzFRPQJP9GByZGUBLK0z/MNoD95
 9hvtDTsA7CUYdM3K0TBf7veU4mwF+WZAddVrapV8CpYPqM3nm9+hFZDAfNH5+VT2VYyq
 1l5vH2nqxiYExvx0KACgv0y3SYrMkl/9Gy9f5EM1Mni/7Io+FYFmf5Pniu8JvEnx4J5Y
 4v0w==
X-Gm-Message-State: AHQUAuaNWJxT03yYHmy8Hgy1k9jEWILB0Ik/OaR4wh6VcTQLv1RWsZvq
 /1Tnz/3uYxYj/r0tAGY3YKRB+A==
X-Google-Smtp-Source: AHgI3Iaxn87jYxFUqbmB5XhLkCIJqJ/F1RTwFyjp9WrstSdbqh+lc5QmyHlpoFkyjdolp9R2+2X54Q==
X-Received: by 2002:ac2:4154:: with SMTP id c20mr1623972lfi.74.1551192877411; 
 Tue, 26 Feb 2019 06:54:37 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:36 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 4/8] cpuidle: menu: Convert to
 tick_nohz_get_next_timer|hrtimer()
Date: Tue, 26 Feb 2019 15:54:11 +0100
Message-Id: <20190226145415.19411-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065439_836377_3AF41373 
X-CRM114-Status: GOOD (  16.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Rather than using tick_nohz_get_sleep_length(), let's convert to use the
more flexible tick_nohz_get_next_timer|hrtimer() APIs. This should have no
functional change, but allows following changes to later drop the
tick_nohz_get_sleep_length() API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/governors/menu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 61316fc51548..95e9122d6047 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,14 +286,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
+	ktime_t now = ktime_get();
+	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
+	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
-	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
+	/*
+	 * Compute the duration before the next timer, whatever the origin
+	 */
+	delta_next = ktime_sub(next_timer, now);
+	data->next_timer_us = ktime_to_us(delta_next);
+
+	/*
+	 * Compute the duration before next hrtimer which is the tick
+	 * or an earliest hrtimer
+	 */
+	delta_next = ktime_sub(next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
