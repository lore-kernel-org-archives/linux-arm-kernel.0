Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43338C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:53:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1628321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yetd0lfN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq4RLwG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1628321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EfO2m1NXiMKYMdDlO93OPJTCDeiMVtEuSVTky3Mo2SI=; b=Yetd0lfNif+sRHgIV8nX6hpmyC
	/EsyVyX4YawsM0ZGwmpqR8CKzZBvgDt0j5E/IVTPOUZDWRPhoDUgY/Hh9o3Wo5ONGFkWblQGBa6iV
	n64A5Z5KFpIt/EgSLb/N+MrK54jQddirM6PQxIQ9XXGLNycy3DH6y+DF1d7pu0n6ddQlTedpCVcZE
	+b3HarkrZ4pyweJWrXvxN+pjkP/IbP0uS8Ya4UgAUph1XoTZEVq7Tgt4HyPxyRRqBnoBE0199cQxl
	8yiCFFFp+ez19xkU5IT/jJ8nrMk1d0wmqi+RjqY8K5502vZu+wkrlGOYxP/kyGLgfaaprR4dewfle
	kV7K9HDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQVG-00082T-1L; Thu, 29 Nov 2018 17:53:30 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQQ2-0001dx-8H
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:13 +0000
Received: by mail-lf1-f66.google.com with SMTP id p17so2119835lfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=creKAO5CsDdP5/fdWi07H8cJaJAAKbloLoHhussbOK8=;
 b=Oq4RLwG9RC6q2KpDvl5rQwPShMgDUxq9Bcao8uuCY9Q4AUGv2qJ6j4CCs4QQpzURNm
 TPpTC3Cm6RmvLVIsxY6SlVz5CJCcQKq09+p++pgz9zsmI8exx5qUyut7Q3F4AYFnUW5Q
 CrFgG6cAu86X9HxVLNMns/Wgs98w0VXiRfNds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=creKAO5CsDdP5/fdWi07H8cJaJAAKbloLoHhussbOK8=;
 b=sSLQh6V+PkbYkrJaPpcSyrnpos2Aj5MYanyd49tR9cqqhYK5kyuJOoGhc+TN9yhynP
 t01vaMOvmU15s+mfPZE8qJB162ihr1dwvi1NgWM1o1xGSXB0VVOYI24cPNhKAKnucYYk
 tTO7qWCVdOj0hRadw3ZPJ8MTKY3SBJRDC4FM5AOZk+9aLPNhtY6lSaqCTKRbdKooNnoY
 2febrKCIyndgaw+9cPzGdLL/MgDTROfAlpfsSee6YACNgPOHPwDTu7DXVjlo6BxODnNr
 cdbdQqvFG4JFQ81S2XEKp/fv+rzRVq72nHelZmbBvQGdUfuxdaXEqR9XfUwEMqsDzHrB
 U+Ow==
X-Gm-Message-State: AA+aEWZ6hR7ibh6BAQx861h7AYRdhN5auYJT0q96dqQMQ4mwIhOPqb8R
 aGau7ruCBoPa/wM6wmw/7w1OfQ==
X-Google-Smtp-Source: AFSGD/XXZec1/y3UQsrlSnc/06AM5EYbLIVlOfcxbfHPLR90+FhEc7xHuwtxbcuBhvmXGgdvSxh8tw==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr1724953lfc.124.1543513673516; 
 Thu, 29 Nov 2018 09:47:53 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:52 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 25/27] arm64: kernel: Respect the hierarchical CPU
 topology in DT for PSCI
Date: Thu, 29 Nov 2018 18:46:58 +0100
Message-Id: <20181129174700.16585-26-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094806_291951_280C8B23 
X-CRM114-Status: GOOD (  14.35  )
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
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
 Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To let the PSCI driver parse for the hierarchical CPU topology in DT and
thus potentially initiate the corresponding PM domain data structures,
let's call psci_dt_topology_init() from the existing topology_init()
subsys_initcall.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 arch/arm64/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4d59a72f8b0b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -364,6 +364,9 @@ static int __init topology_init(void)
 {
 	int i;
 
+	if (acpi_disabled)
+		psci_dt_topology_init();
+
 	for_each_online_node(i)
 		register_one_node(i);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
