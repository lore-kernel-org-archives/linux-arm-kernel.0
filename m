Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC8DC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD81E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/Eh54PP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSpGVm6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD81E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XsgKTbhNHmwCsNkZ5iOta6xhasot6UbwbtBdekckeqA=; b=M/E
	h54PPGORGYMMFAK245FtdW7HsL+BzDKZxJzGCoNJMUTLB0SoxQGsObYe0ibLHFxfQe30FWYCGpqLr
	9CfDMqyIq8hw1GzC4zFYHnDYwRnaccO14/V9kRFHk6vk9U7N+ipTOYRaRO+GKBc4muWN/fYmDjKuY
	GtgSOeZWG4Kc+YxnWapCBXOUIM6fgkscY9N1OL4YgzfZKg7hEgnhZiZDvFl+42g+65kaO9KHcVsv1
	QQKfTRJA70UMW2khNCoHvHeQf+PCUsLCAHES1UdN1r8/m1lly0T3MZfTEoAwUECvIuyjl1WuAmC5P
	QVko+rByCeqgoUr3mInVA1JsiQEDeiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh4L-0000NQ-Gf; Mon, 04 Feb 2019 16:26:01 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh4J-0000Mr-7F
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:26:00 +0000
Received: by mail-wr1-x443.google.com with SMTP id r17so512231wrp.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gj4CO8cKmeYrRRbK9pmA1l2CtkIGPY5k/yuxkvfaR0I=;
 b=iSpGVm6bk6aqVVi6UgCSx6Ltk72BPZUwH9m/dakwPfH66odYZZnNC6MuA7N3jYacPj
 hgi+vjkJTXK0Lyhy+xFs9YpnJg8zyIp/WFMTP8YfHMiZwDwEJcMSXD/ktxxYRtqSXYB4
 3+floKLMmdYOzoFyGWxLCzafuY4mOBR7mIxXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gj4CO8cKmeYrRRbK9pmA1l2CtkIGPY5k/yuxkvfaR0I=;
 b=k0xieO+7pdFvqrQitOhGE+/MiF/KPp5mKbNBNc/ZtAfIgT1jHsglXcW4UoirLlPOPj
 I93MJaJ+qoBQZhhSNLCYgnXOWn5HVexp54b5sGnyGmHSPeYiGkoHnxTb5vK0VYSh74fr
 N3xiqzKXWOz2kh/885CBUHbaCtvNhQQNTPIQbSZRr7TRXdItnpdKLHuUEmFt4NThj4UW
 vIvB+GQE6p8Y1zkD4vfXQwvAmMSJc2fti++CTEiENTs8cGnyRfT0HDwuaVCJjc7SSpMS
 KDiNTOh1HK22x5T3KXJdTea9VBRCAyzyQJyzHiM+uu5mO0SD/BAhRhaz8CZOz9gurYxS
 toWg==
X-Gm-Message-State: AHQUAuaWj5Oepj1ghVeq1W/u1Jw9XqcoFD8HGP7+yHYp2h6IF6tRlqPl
 4Tj2iTPxT1xlkjfWu1RdHNYisg==
X-Google-Smtp-Source: AHgI3IYguOK+dM/9om6QfOgjjrMG44+JJ3V9kjMBviVQPvGe1GyoA3P+vG/ut4gB+CnLAU/37KPzsg==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr114174wru.291.1549297557099;
 Mon, 04 Feb 2019 08:25:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
 by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 08:25:56 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date: Mon,  4 Feb 2019 17:25:51 +0100
Message-Id: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082559_265516_87999B1D 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-renesas-soc@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org,
 thara.gopinath@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix time accounting which has the same lock contraint as for using hrtimer
and update accounting_timestamp only when useful.

Vincent Guittot (2):
  PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
  PM-runtime: update time accounting only when enabled

 drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
