Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF9C32788
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8F521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifVh8SfS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO5P3hwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8F521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+M8oWndSTOzPkmzi3l/BjVOVBcsF21F0Apwgo3AHFjs=; b=ifVh8SfSexWgZC7GLaBiEWujsl
	YDH6HJ0PbfKJMSdbLRWpx1/ycjoaanlpghvmkvI1wTIfiEnBkCLtlj05RMJwj5/Fhr8mL8QW8ZQaB
	AtrFWV7WaR1zcAlmTI+obv66+RQXoJ9Akm1tqojDE6xB8oiFPStQlym3coyLezDf9OjTazon7BmzO
	T1CJXygGQiQ7AwD+zrvzVBl0slV//dC6RW+zn43Id6YaZIe9pb0r9oiqdKqkIrgcUx8Ja2sdFSs0A
	35k/5OVMMzzSes8uUBAng8EYTxFyVbjBMpA09/LwlWRjdH+OzJtRhTeRDF7pDhFIJOX5pYHgpxbCa
	xkI9rkRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQSn-0005Uv-31; Thu, 29 Nov 2018 17:50:57 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPh-0001Fj-H4
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:54 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so2530819lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Rtb7ncC0WwEMpjQCLG7tBribMPasaZ8gXOaK80cYa2Y=;
 b=YO5P3hwGz2f1/PGj8M6IIJCJ+iADNSFbLBsUFJh+FZ0WQVq2L2h0C6vPtpjcJudSN+
 6iWdepfrH5LRe2GaGEODv4e8urAWb5kwAA/Ub/lmuunyphoDeHrSFmg1i0l5N5P4tPyE
 QD54E4ThDFkrMQtqrBqXe0ymN4yniaZGb4Swc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Rtb7ncC0WwEMpjQCLG7tBribMPasaZ8gXOaK80cYa2Y=;
 b=nJCH3/F0rLG2GbG2XN4sbwFx6J9kcqh7uPyas8fQxT8FyPI8e4wtD72T0Ks0YMLsAC
 heIrlTeeXnCrMXCQ94IQLMjhLaAw1Rhs6iAfxewMzyL/fjqusZQ4B3GugVEf60942XNX
 642bSMPir4Oyq6i8an6JJeRN9hHiOvY8MkQCbZs7iI0f6ytP4kiT14VODDrE5AfPRE3m
 n6HUbVVyBfxBpAI8cyL6ClVVnrPbp4ErDiREzgUV9aM3sR4KiBoPyT5trPZbBneGc0k4
 Ql3E0FeDLLgJkxj084IfrAwBp38VQaxWZ67vynzCvue7OhPBL2j38MTp8BcxxPkPPw3p
 C+uw==
X-Gm-Message-State: AA+aEWYQYUsnujylWe2URc68dGvU0rEfczvhroQJwyA3kN/Y66VK4Glv
 FgrKrvxfg+D7s5lWDyvXIuk7Hg==
X-Google-Smtp-Source: AFSGD/VLjWAQoPNsfdrAeTLoSV15h4LBoJmHssLv9tcjNYnWxIaJytuQxOgS2zsBwJGIgj+JV0GVVQ==
X-Received: by 2002:a2e:131a:: with SMTP id
 26-v6mr1850088ljt.107.1543513652968; 
 Thu, 29 Nov 2018 09:47:32 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:32 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 14/27] drivers: firmware: psci: Simplify error path of
 psci_dt_init()
Date: Thu, 29 Nov 2018 18:46:47 +0100
Message-Id: <20181129174700.16585-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094746_550710_463014B9 
X-CRM114-Status: GOOD (  16.69  )
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

Instead of having each psci init function taking care of the of_node_put(),
let's deal with that from psci_dt_init(), as this enables a bit simpler
error path for each psci init function.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 631e20720a22..6bfa47cbd174 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -678,6 +671,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -685,7 +679,10 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
