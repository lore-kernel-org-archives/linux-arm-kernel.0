Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86440C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E80D20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8ORhzk9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PjAWnJ6/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BRbIno95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E80D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uCFh8/G/2yP0Bzog6m3AyWWfLn6S6lYxVvzJD+MayZQ=; b=E8ORhzk99vba13
	uoMNThHxefobfrFHb0f5tBb7xfMj6fHdLgycWdg5nuO9HK2vrRTLkF/SwHGXqXqXHi8poIg2ptIEZ
	2FhL6weq+YCqi0+vjQUASB13lOp6Gsfu1F/M2t9ExICbAvNzkyfYCaU4VoPv0h9B0BjLVE3bCIdm+
	iBrww5oYNg/aD+QyaKpsuJ/Djhq3/W0zU6WTUvFm1VX6ofNSZSnENdJ6RL9XB7jCpHupESYQXJ1ee
	cEv7jAfKbfMxLU07hmb7QfycTIDwKkrmhtGndQQwHUoyXXHBrJ56DnjL35/mZ9keZlzlgk3YOUsIu
	MyRZ4Q5ktDIxL4WwUExw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk18x-0006tL-C0; Thu, 17 Jan 2019 06:27:11 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk18q-0006c6-BL
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:27:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C82C9605A0; Thu, 17 Jan 2019 06:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547706422;
 bh=FyUHP3fDWokjIe3y+UIDwQefiT1yCtiYh6dqDGm6Enw=;
 h=From:To:Cc:Subject:Date:From;
 b=PjAWnJ6/j8AqjTeu91HIdndyprhbXTEI9o2AHobC6JWP7WsrYb3fPdUVSZ3kwFFxv
 djyrRYoS3pXG5kXefJiZ6b0kVnIywB6igu+QQHMGMeTL3FZlXCWm/ClDCEmO8czB+X
 Gvv1OcTSDAMiZAy1uUkjLO19Yfm63TOP0zdlbvRk=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A8B3C608FB;
 Thu, 17 Jan 2019 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547706413;
 bh=FyUHP3fDWokjIe3y+UIDwQefiT1yCtiYh6dqDGm6Enw=;
 h=From:To:Cc:Subject:Date:From;
 b=BRbIno95eW/Kv+hQG4tB6lSfSXDujH8bdIGdIPlYHp0i2dRpukGNwdb23pNL3AxrD
 MqVyrhbvXylOM0jhCHuyFAeUYmEh6gzHqH759Xny7LQyoNHlJVu+zFPd5rmz7rS8Sj
 cQtI1QNLc9019JWCP7AonRnFaRVK8NjTO2kQaEE8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8B3C608FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Kees Cook <keescook@chromium.org>, Joel Fernandes <joel@joelfernandes.org>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>, Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] pstore/ram: Fix console ramoops to show the previous boot logs
Date: Thu, 17 Jan 2019 11:56:20 +0530
Message-Id: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_222704_608022_9704396A 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
arguments") changed update assignment in getting next persistent
ram zone by adding a check for record type. But the check always
returns true since the record type is assigned 0. And this breaks
console ramoops by showing current console log instead of previous
log on warm reset and hard reset (actually hard reset should not
be showing any logs).

Fix this by having persistent ram zone type check instead of record
type check. Tested this on SDM845 MTP and dragonboard 410c.

Reproducing this issue is simple as below:

1. Trigger hard reset and mount pstore. Will see console-ramoops
   record in the mounted location which is the current log.

2. Trigger warm reset and mount pstore. Will see the current
   console-ramoops record instead of previous record.

Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---

I guess commit msg can be improved.
---
 fs/pstore/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 96f7d32cd184..441a44215456 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
 		     struct pstore_record *record)
 {
 	struct persistent_ram_zone *prz;
-	bool update = (record->type == PSTORE_TYPE_DMESG);
+	bool update;
 
 	/* Give up if we never existed or have hit the end. */
 	if (!przs)
@@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
 	if (!prz)
 		return NULL;
 
+	update = (prz->type == PSTORE_TYPE_DMESG);
+
 	/* Update old/shadowed buffer. */
 	if (update)
 		persistent_ram_save_old(prz);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
