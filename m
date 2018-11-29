Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F185B21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHwhzMt8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlPyEsAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F185B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=228ST6uDOUKpr6OZCE5ALMGbc7ERdexyu0uETAT4dJs=; b=nHwhzMt8l9SXBpyBw23XZntmCf
	PeVRsukuYgpP7MfjBOPXd2aRljgWe27in67imNLWCSFU9jFusWDNKef4gHp3W8f22Vz7u1DF56pV5
	IdPIoTVxaxms6X82zV9sGrTfCtGiPGc6kRgVgk77xVIO/BIU17VYgfkVMq1ocJTciluyMxSMOSxsL
	ZAlaIIT/cMMB7kc+j4BVQsP8W8l7gOKgrxzvK+s2CWxVbtzBsfRLhmuVGQ8NetBVeVD/FoVlOTm6M
	6cHSGBuzyEqY1P9Z7cVJzQshMeGyR3mEOuEr+zk/PSIYWzICYBvPrhtAoObtg8EproajWoi6M8t8Z
	12mA5bXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQX4-0001YV-As; Thu, 29 Nov 2018 17:55:22 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPb-0001Di-6o
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:47 +0000
Received: by mail-lj1-x244.google.com with SMTP id z80-v6so2520744ljb.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jX+qyQO49fWmt2xQpGUjw4NJQ/8bkzUinDH9qdTMnUA=;
 b=AlPyEsAyB5TTJCSeRQDcqsvnIKB/rMfm0oTmlQA7hqOgZ6aMDexyWveeYmPE2QdbmV
 BmJIUeVUEo68Z1RYBp5Q7w/uSp5wPfc9ZHJqQtiE1cMsCCV0zIMnnI1fU3CrzA3sf76y
 BhqVyyrcH5tH2VK3YAUp3EhPfLgCuB7n6fgBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jX+qyQO49fWmt2xQpGUjw4NJQ/8bkzUinDH9qdTMnUA=;
 b=GqkL3W32La9DtemHKClgHseF+vKrGWUjHCgJ05sSiY9OlMJZomrO+OC9Yn3kfNhlVp
 jFowo7yXV+SAKRXZViFMkK5H1z5YJuFUb1oiYewzkxUNUh5ery1D6gooDvGy2lJa4Dsn
 NUS+wgkPRoQ4BfcHxSm2pK0L0HwKgxwiaWLCLLRNqUa74Nec7PBz5gPPxgyzA79IbO1A
 SpHM1UJwqDYKGPDXnmJH9cjHaRRYoHQXNuDUuVaUrwbiI/aURsr0jffWeEocTGWfXriN
 M+Ej7eW7a/OGvGib847mzuOeODWPBWMxWzCiDZrbsNmRCPgMX9rIzbzJvngrvUWgR4+0
 jkYg==
X-Gm-Message-State: AA+aEWYrArr7oaDbNQJZcuzlKqWdwiTxuzvXHlDmyu9GTHvirRGb24xF
 +mCEKCVC9WsI6F2WlxRIw0r/Sw==
X-Google-Smtp-Source: AFSGD/WMXNnYmUDhhw+Xfxe6yvJ/i67+Rv4G+K+ZK1l5/jdsO6I8LilxuZCD2yTIfDMQsHofrPEMgw==
X-Received: by 2002:a2e:5b93:: with SMTP id
 m19-v6mr1512841lje.115.1543513651192; 
 Thu, 29 Nov 2018 09:47:31 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:30 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical CPU
 idle states
Date: Thu, 29 Nov 2018 18:46:46 +0100
Message-Id: <20181129174700.16585-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094740_117201_8ED9D6D8 
X-CRM114-Status: GOOD (  14.88  )
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
 Lina Iyer <lina.iyer@linaro.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout, simply by converting to calling the new OF
helper, of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cbfc936d251c..631e20720a22 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		return -ENOMEM;
 
 	for (i = 0; i < num_state_nodes; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
