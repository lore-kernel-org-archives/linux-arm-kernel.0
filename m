Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD336C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C712087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S9PUQ7a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C712087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F38j2RmDkaxqI3pTOELm3HOz2TsmOLIeAxkB5F1iQhg=; b=S9PUQ7a2OjwfTv
	fxNSBlxusUafDpxi/mB95A9pqbnYYwuePZGGVEQ26sUz9QVep94QJWSRxJR1WgKhOAhx3WNuH9v5U
	hbIvzM7UAk1Sh/kah0S6jcQWYY2WskVFFvamEFG/unlUCPNlfZ3YT44HoNDt6Cxr+n+AlokA5nKGV
	7KLw0AHSelggvoX5bqKgVU8J45iqg6gCq1Z+XI+bnGiJ8vCAvQcBN+F36/sewvkjcNipby6YjoEfd
	ojY1H5xT3zcAV5/a9ujmWl3h02cxfCFcj0YBNgmh8DtHOXXYA32cs/vmyLeZ9sSUQcWEjoqJEVOhJ
	ErsUjqCvFwr0ZISvylNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhlB-0004PQ-9J; Mon, 04 Feb 2019 17:10:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkd-0003J7-R5
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:09:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0DB15AD;
 Mon,  4 Feb 2019 09:09:43 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AAA93F589;
 Mon,  4 Feb 2019 09:09:41 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	mark.rutland@arm.com
Subject: [PATCH 2/5] cpu/hotplug: Export
 __cpuhp_state_add_instance_cpuslocked()
Date: Mon,  4 Feb 2019 17:09:05 +0000
Message-Id: <76aa8ce6c6526aeb2ccfce04b203b0a24f50a097.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090944_454724_EB6BF7F5 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is the only member of the family not exported already, but
happens to be the one I need to fix a bug in a modular driver.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..c1bd8ed7546e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1683,6 +1683,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	mutex_unlock(&cpuhp_state_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);
 
 int __cpuhp_state_add_instance(enum cpuhp_state state, struct hlist_node *node,
 			       bool invoke)
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
