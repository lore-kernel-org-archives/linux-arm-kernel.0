Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B211C32788
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B07621019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRYZyWRu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbDpQVTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B07621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=H7vd4VR+0J5FELyzZLeBRJ5Ovs+bvwvJAitPbtTv8Ns=; b=kRYZyWRuPXhtKOWWY394/zzHgi
	jVvnVEJY45GJzZGOspYfGANxbHXIzSu8ApcToI9PYq+fiDlnOsOFdzrrVhkmLQdJI0OJab3pL2XYB
	AFUU2IVIUb7IYyWz3FWPPVjjpxwTV1DnKD22Rj87w3UBKy/0Ycw8AzRmjCH8n+qAP4qzKmV7cBPoX
	qzYL0K+0Vjt9ZH+bGN9up3ceI+2mxnMRf9SGSDRCOpXVbtVHa5pkSex14fQy9ooC0SWvKXfgF3tdi
	A8plrxcylceNRUtKDhI8eFkM1+5tnvhlzYqejzEHE6ECaPGl+9jWnDvwfwCG1ojIjfZT/b6veolpD
	iYdnZR8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQSV-0005Ff-87; Thu, 29 Nov 2018 17:50:39 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPZ-00018j-RP
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:48 +0000
Received: by mail-lf1-x141.google.com with SMTP id u18so2087883lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BlcCn6JUkPvrmaJts0baXJ0tND3p8k02JN8jSxGv1B4=;
 b=LbDpQVTsDKH8Vlu8mCK1a/Q1So8giOTNrXCaxWic4ge8hs50DGuGqiu3yznF/H6DfO
 +aQ7qnYWh/XOAWTWRcJ69MBuJZNFn7LZR1kGuYEVa9jboM1knEsNrcqiNH7VfRM3ilvO
 gSEgA1FPTdTRPV2AKN8BL60FONcnUzCXet0/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BlcCn6JUkPvrmaJts0baXJ0tND3p8k02JN8jSxGv1B4=;
 b=letA1BUTQarzzg8VqRr7LJ8abNYIQw3JHghrT/MR/zDE7xgAIfmUKIkVsNhn3f9j+t
 eb1y2wVq9Kj+fsXfui5cnRk227GoPZOyTVzmP4C2r272/pcj+FqslKmcZzMrMqOPeXP2
 OjbYLjhOZQh0hX64sYMGflS8ckVrAg7WQ8w9bAznqKtJ0r+ATx7ItS7rKlQ9MFj3lXpn
 PJcnTu1umVWU05J4pLN8ffEcrLmfzdxuPbaavDx8of2FC2xMG0AHjo4GBWkFxskSRBDw
 vYIfhCuSVJwl9svzGLdiO1+EuSezEL6F+TIYvMPrS06x+Lypk56JKBZueuaxowDgWUBS
 9J5w==
X-Gm-Message-State: AA+aEWbEceCJ16dKToWFswWmZXipf81rp89yGnLXvTNEllMiXn8NwBK7
 e6DRQzT8oV1URQizV+gDHlKOxg==
X-Google-Smtp-Source: AFSGD/XL0A9ZxXXbqP0IGeMxZKK3Hk3+2ZxFydPtpCZkLTo460VYANs3KWIUvoIrurCDJv1WpTGhcQ==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr1733898lfe.63.1543513645918; 
 Thu, 29 Nov 2018 09:47:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:25 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 10/27] MAINTAINERS: Update files for PSCI
Date: Thu, 29 Nov 2018 18:46:43 +0100
Message-Id: <20181129174700.16585-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094738_265866_79701D4F 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..9805444711ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11919,7 +11919,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
