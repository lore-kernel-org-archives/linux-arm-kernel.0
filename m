Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D7217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2AY5Ea6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="AJn3vb5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D7217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KU/M/l7ARtQSAW5FURSfQNRxTEtZtJgw22079m+TjGQ=; b=X2A
	Y5Ea6sCYhx6d0EaW2mVDzKedCK3UkdISdGTIZkSd4U5EucFfoAuH7yDcZabShsHS7qiY2x6Zy2NUs
	f226D6IwwEe/T75h7rS7HXCCg0uaTSl0J2EDzq8j9dTPRiRYoz0/C0QDlfsTMdheo6WrGk82EL5tV
	DfUW2zymiQcHGtkwRzXi2G9ugB37jiCZxOFHj59eXVO4Apv1JJgEB+mOLMOzeMliUiL8UtsMXYYJR
	nOC2jEKXZ6/smHKH51ON9T3GsmtxUSHzGy7JOnfBiO+uzPlpNZmlhUxKoQQo0I5lQ9NcxJvEq2BjE
	l+wHwcmOxVx2S8phwJwjbJH4qoAknuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZy9v-0003MO-Pm; Thu, 20 Dec 2018 13:14:39 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZy9s-0003L5-AV
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 13:14:38 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so926159pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 05:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ingics-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=rZhe25yQxkee0DtZS6VfNe2KF6R6wBu8BVFsWVclt2c=;
 b=AJn3vb5iEDv0wG1r5mtU9gNCyW9nUhx/QfFMwzhBq7frWVC7B0emdfZHPE/ESkCU5h
 x82BW4ne+GG2zffyUCiHdNWvK/oNNs+3pgR22fC0hDBXFvAk6XAlFDgh/5FLDQSq+38a
 FHfXb/TVK2fPKYlt4B0kkgZImJKpLkDp7iuMf0MFOnX4wJUKS/UWLD5LdVItElb3RIi1
 HdpRdW9B0Vrvz/iqgz6oAOTqI3CoAStcv4lerVlFHp9DrP+gvTEdIJLSx33+D9ZXO3Cz
 IVfHqiHNq2muTi0Ecsb5UzISk+3LnPet8FZZ8FUHaVWlq4Z9EwvOyTIFueiFV3+Z6flF
 QKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rZhe25yQxkee0DtZS6VfNe2KF6R6wBu8BVFsWVclt2c=;
 b=OXdf+/y7C2OOoWVs4YPG27kiIXh7WHp/OpZwJRqaM0fQDTfppEH073+DgfFrxovDVK
 MkwZBSsO4i1s8ZyUI7jChFX6Z5Xk4YOj+gISl+xAOSZ8pxIhCe+yhcR8VLHhhAsm7DGo
 Z7fHn6h2+c9IPKn/HRv/jI6DM+dilb3hWcMrL3cZiC/TI5yqsLCXW/SmIA9xrIGg/dVe
 EyRfs9VHyaPs7H59gKcOs9UabO1QrtHvA2xQY5r1PiwF6+Dz0CRmnKVJVGo2lmZhC1ek
 ZkiVSVjnn9wC74JvC3Px21HrPoYyIjenFejcI3/aWy4bkRcrr9TOrCcqDq8vcVc6Er1k
 J1bw==
X-Gm-Message-State: AA+aEWaY2B59fhArww68VPt5OenywD0oWuTjBiDCLD+eqmcnA5NfD+zl
 w79tBsgzXeNNyRLhurK908gXDA==
X-Google-Smtp-Source: AFSGD/WFdsvM4dJigaOkv3/+JygBy9zb7HhBF2P2bY9EkX9nkoWDMLfCZ/1Esp/oDdLOwpQoxmoITw==
X-Received: by 2002:a65:4381:: with SMTP id m1mr22652931pgp.358.1545311665106; 
 Thu, 20 Dec 2018 05:14:25 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net.
 [36.239.205.170])
 by smtp.gmail.com with ESMTPSA id b7sm40809404pga.39.2018.12.20.05.14.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 05:14:24 -0800 (PST)
From: Axel Lin <axel.lin@ingics.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq
Date: Thu, 20 Dec 2018 21:14:13 +0800
Message-Id: <20181220131413.21922-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_051436_775469_7ECC98B7 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: Axel Lin <axel.lin@ingics.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

mcp16502_suspend/resume_noirq is only used by SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
when CONFIG_PM_SLEEP is defined.
So use #ifdef CONFIG_PM_SLEEP instead CONFIG_SUSPEND guard.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch replaces below patch I sent today.
regulator: mcp16502: Fix build error when !CONFIG_SUSPEND && CONFIG_PM_SLEEP
Changed the subject line because after commit 308144ce8e51 ("regulator: mcp16502: code cleanup")
it's not related to build error now.

 drivers/regulator/mcp16502.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 809a664733a4..cb11fb206899 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -497,7 +497,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int mcp16502_suspend_noirq(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -517,10 +517,7 @@ static int mcp16502_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#else /* !CONFIG_SUSPEND */
-#define mcp16502_suspend_noirq NULL
-#define mcp16502_resume_noirq NULL
-#endif /* !CONFIG_SUSPEND */
+#endif
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops mcp16502_pm_ops = {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
