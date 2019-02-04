Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7147DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AAA2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kwA8Y/pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AAA2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9QlXxwQIF3q690SdMSoWbYyauspSw8AIKqh5aCR6bFU=; b=kwA8Y/pq7jLREW
	qk3Krc2B77Av4htTnUWlqakxOx85xHN8r7KHXTv8I+NOZORpR9LbOaxwWk/aQDIVINuvEXnfdHBd/
	wqcfoIkhWwhdUSr68WfGIWOiRBSsL225DZZo/WAbnm2/MW6I3dfNV+/HLAwfUEWiVN64Zx7lYZ2Yd
	pidU2ekT8Q7w8r976coTSD0m6qGjafvsuP8W71/ncSZHvMManADCFNaapYVZhWIGHXOkNwdWSbuys
	xgHls6KjXhFbgKyDLXoLX50z26WzFYcBsQwZvXFCr3g/ZJgtYz31FCAG/WDcXgL8VFVnQfqYZDScI
	se683e9TzeYeKIWPskdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhka-0003GJ-SO; Mon, 04 Feb 2019 17:09:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkY-0003Fv-9K
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:09:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C383EEBD;
 Mon,  4 Feb 2019 09:09:37 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 414C73F589;
 Mon,  4 Feb 2019 09:09:36 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	mark.rutland@arm.com
Subject: [PATCH 0/5] Fix Arm system PMU hotplug issues
Date: Mon,  4 Feb 2019 17:09:03 +0000
Message-Id: <cover.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090938_336225_26CA5C6C 
X-CRM114-Status: GOOD (  12.90  )
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

Hi all,

Following the report of a preemption-related bug in arm-cci, it turns
out there's a fair bit of cleaning up to do in this area. I've started
here with the Arm drivers that I'm fairly familiar with - I suspect the
hisi/qcom/xgene ones suffer from similar issues, but it's going to take
me a while longer to figure them out in detail.

Robin.


Robin Murphy (5):
  perf/arm-cci: Fix CPU hotplug race avoidance
  cpu/hotplug: Export __cpuhp_state_add_instance_cpuslocked()
  perf/arm-ccn: Fix CPU hotplug race avoidance
  cpu/hotplug: Add locked variant of cpuhp_state_add_instance()
  perf/arm_dsu: Fix CPU hotplug races

 drivers/perf/arm-cci.c     | 22 ++++++++++++----------
 drivers/perf/arm-ccn.c     | 25 +++++++++++++------------
 drivers/perf/arm_dsu_pmu.c |  8 +++++---
 include/linux/cpuhotplug.h |  6 ++++++
 kernel/cpu.c               |  1 +
 5 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
