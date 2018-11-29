Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E4C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:01:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDF521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zy/Yh+ge";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liz5cM5e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvcYZ3GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDF521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=03wZpdG8bGQrb1ZPKjSsbdsKMysFk+x9U6rr8FDXUOs=; b=Zy/Yh+ge6FimYwhUhvhOuHs7wU
	TtVNu3V0MfQbrEysO1FkkGgsnssDu2p1d+eLtHqN/Z52/HrhJOULw4+geLTjyjYjUQkHAOK7DPbCn
	G1VqiRGfRiQU3sivUwvwr8a3BNVVC915DS7BggkWzoPXhhzo1Yh+nAE6e1z43a6cdxqowS5n/Hfhj
	I61B8skjhdG0mDdmFpQYx/ps74iNDi2Ix58UT+PvPjAg6+VnZ9JJVbbP02aNYRYiM/WQiHBzdX0J/
	0JmUt8E1gF4ahcryIs7bQUUnwRqBWGFfiBorbXD3KdpVTzbweHV+z0d2ZybsS9VWWC9joaZ7faPMS
	TyCmBDdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQd1-0006bb-Qq; Thu, 29 Nov 2018 18:01:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQcc-0005uQ-0S
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 18:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j+EEeIQ8OjgKMk3l12109V9jWSNPdJq8ZcmjQ3ZkaQ8=; b=liz5cM5eloAv2fezPHWmYEhR2
 CQ+3w0b6fsy/0gQlDcSbDEYa+g41pKBEZGjyV7ZcCCjPTu0qhwU0+OIj0B+gW8Ue70zuc9BzW6R0D
 1YtfNthfbJmy5kUC3HJkmDJCsvJQOsrvcvOZy8Jk23nUSbY7v06nYbN6tEbc0abQjRL33jj3gqz71
 ajsToByryS976Q6J4bi1x/qZi7D62lhdVipAYZL6DVIMsFsJoRZEokkE4yNS1FUXMnOrB6jH749h6
 n01yPh7GwvRAOMSN+K1usNzgEnrotIwq5ql8RP07PIcRoMM6Y5RetUL+KYXCqA0AzVF4r41aUUPbr
 yj1JGcKRw==;
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPr-00058t-EJ
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:57 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so2523112ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j+EEeIQ8OjgKMk3l12109V9jWSNPdJq8ZcmjQ3ZkaQ8=;
 b=bvcYZ3GHOuNglPJo4PiEY9K7KfzwSQGeJ4tmewO/g/Yu3xWHquRm0tnoluQCIN8Gnb
 AjHWuHuSFdoKAwmZlQ+e2qP+HemBxddn0JGzfNKjQDsQr5Ab5t+zKWM5A1nR8dCKa2iZ
 ssMiBbaqHyQvPJYCg8Ipl6Gluutr4BDnX/nmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j+EEeIQ8OjgKMk3l12109V9jWSNPdJq8ZcmjQ3ZkaQ8=;
 b=PQaCsBO+jlcbSjhJDNbAvyIQlCDLg9HEomCtEZOjP4Ec07RwhqhRV/NVsbkkt10g0q
 Bm6xexvhmCbN4x3mm06ThSvYqUcfzIZ4wN0QlN16gqt5cEkL+ISnxvC0TMAHTJhvcOvw
 dJLKv1T18L8fclDIjlQAFCaIbLjitUaM/4cl1szv7d1CK6aCa8kc/8+eIe0NTH0MuEw1
 ez9qjzKqEt8v5i+DFzn8Py5UaVHVOPJ9OaVGxZ0+cWzPSS4geYZRmmt3cWAygkMgEKxZ
 3WE1ECK62OoUT+o0CBXMt+eXGhWvG+cd+1b+EW78b4WjwJj64CO+dJbDManCihHyRrNh
 PBEA==
X-Gm-Message-State: AA+aEWYKuq5xUv4G8LZcI/R2U1wTK1MZLCDOosQ+b+wyJZD2n7QT+KcR
 KkgZgBuB2ixGWE1CQSurQFvufA==
X-Google-Smtp-Source: AFSGD/UGOq9K9BxR66pfI/HJC8oYOClHD0rw9Tx1kGcB89/sYAmm9Q3eO+0KlfFRBTfNVzRUVMCVOA==
X-Received: by 2002:a2e:91d1:: with SMTP id
 u17-v6mr1720629ljg.160.1543513663478; 
 Thu, 29 Nov 2018 09:47:43 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:42 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 20/27] drivers: firmware: psci: Introduce
 psci_dt_topology_init()
Date: Thu, 29 Nov 2018 18:46:53 +0100
Message-Id: <20181129174700.16585-21-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_174755_479858_6E5441CF 
X-CRM114-Status: GOOD (  19.41  )
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

To be able to initiate the PM domain data structures, let's export a new
init function, psci_dt_topology_init() and make it call
psci_dt_init_pm_domains(). Following changes to the ARM64 code, invokes
this new init function.

At first glance, it may seem like feasible idea to hook into the existing
psci_dt_init() function, instead of adding yet another init function for
PSCI. However, this doesn't work because psci_dt_init() is called early in
the boot sequence, which means allocating dynamic data structures isn't yet
possible.

Moreover, additional following changes need to understand whether the
hierarchical PM domain topology has been successfully initialized,
therefore let's store the result from the initialization attempt into an
internal PSCI flag.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Simplified patch, by moving PSCI OSI related changes out into other
	  more appropriate patches.
	- Add a flag to store the result of the PM domain initialization.
	- Updated and clarified changelog.

---
 drivers/firmware/psci/psci.c | 18 ++++++++++++++++++
 include/linux/psci.h         |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 19af2093151b..5b481e91ccab 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -91,6 +91,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
+static bool psci_dt_topology;
 
 u32 psci_get_domain_state(void)
 {
@@ -741,6 +742,23 @@ int __init psci_dt_init(void)
 	return ret;
 }
 
+int __init psci_dt_topology_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
+	if (!np)
+		return -ENODEV;
+
+	/* Initialize the CPU PM domains based on topology described in DT. */
+	ret = psci_dt_init_pm_domains(np);
+	psci_dt_topology = ret > 0;
+
+	of_node_put(np);
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4f29a3bff379..16beccccbbcc 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -55,8 +55,10 @@ extern struct psci_operations psci_ops;
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+int __init psci_dt_topology_init(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline int psci_dt_topology_init(void) { return 0; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
