Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1F421872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kTP5m18F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KT9krPyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dIFYnjdDrAz4yPfLwZHQit99FCwPPZFPTFO8pcTjkZw=; b=kTP5m18FN//2xYW6Jqoy9rid1Y
	mQ8gClOXLOxktummWc0oPOwh0lg9BrRkZcvESCHtf5tj6I4DPIY8l6TB9xybzZ2ITt7/GpgG1B7G9
	QbCLWHZNjdfL8FUvRMOlMuev4rAHM5K9o/bzpwG/2jqq78UX2Cu3uygJQvWnRHmZZ8x233Gd3qK10
	VJ3QwfBdpUReWSZSD4S0WiLvU4nK24BlSUAMLnoOyGQE2G6fbqucBvzaG27lB0BFOuI+ugRLpcI4v
	gNmvU+L9GuiE3ecuSn0rIOd6D7jj+9IpJktNYAONFVMQUGiLIqwAF6xgS8FDJGlOR4nZlc5PFeJwr
	0y94aX1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpcf-0003N3-85; Thu, 07 Feb 2019 19:46:09 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpcR-00039e-Av
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 19:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eHhQhinaswkSZ3tDxgVYX2eml2+lVrUAEK+ZSfFmm8k=; b=KT9krPyyX0yIHTIIdzjt5J2aC
 DZI3YM5cNbXxCgJ+1ApkHjTUIdIDrqcqAle6i4wn5HwkYbmsmxOZqRF8Okfhp+1ToUOXuQQ8aHjFn
 J5uslk/09sKu9lqjVe2sCkKpHQGoBaAAlseEdzy2RObJAeDwt+9qYHqaSHtXO9RJtPbrzZUYJKEZm
 lB++a3KzDugspIU2Z4+JmJhXsztNZHgNYNkoL1hxx80axNQxS81z9MzRqQvX62OuvGKqjhHMtpMNP
 4CyrwaYY968tmg46DKWFQ7PfV+7YqiiziwTzkojKPfI0+ZtV1RA1d2nICgDfKZXo4sjp2kTZn8/wq
 jDvo1uL4w==;
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp45-0006lf-7l
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:10:25 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB5252551;
 Thu,  7 Feb 2019 19:10:23 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9488961146;
 Thu,  7 Feb 2019 19:10:21 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 21/22] locking/rwsem: Wake up all readers in wait queue
Date: Thu,  7 Feb 2019 14:07:25 -0500
Message-Id: <1549566446-27967-22-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 07 Feb 2019 19:10:24 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_141025_430702_2AD4566C 
X-CRM114-Status: GOOD (  19.54  )
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the front of the wait queue is a reader, other readers
immediately following the first reader will also be woken up at the
same time. However, if there is a writer in between. Those readers
behind the writer will not be woken up.

Because of optimistic spinning, the lock acquisition order is not FIFO
anyway. The lock handoff mechanism will ensure that lock starvation
will not happen.

Assuming that the lock hold times of the other readers still in the
queue will be about the same as the readers that are being woken up,
there is really not much additional cost other than the additional
latency due to the wakeup of additional tasks by the waker. Therefore
all the readers in the queue are woken up when the first waiter is a
reader to improve reader throughput.

With a locking microbenchmark running on 5.0 based kernel, the total
locking rates (in kops/s) of the benchmark on a 4-socket 56-core x86-64
system with equal numbers of readers and writers before all the reader
spining patches, before this patch and after this patch were as follows:

   # of Threads  Pre-rspin    Pre-Patch   Post-patch
   ------------  ---------    ---------   ----------
        2          1,926        8,057       7,397
        4          1,391        7,680       6,161
        8            716        7,284       6,405
       16            618        6,542       6,768
       32            501        1,449       6,550
       64             61          480       5,548
      112             75          769       5,216

At low contention level, there is a slight drop in performance. At high
contention level, however, this patch gives a big performance boost.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3beb942..3cf2e84 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -180,16 +180,16 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Grant an infinite number of read locks to the readers at the front
-	 * of the queue. We know that woken will be at least 1 as we accounted
-	 * for above. Note we increment the 'active part' of the count by the
+	 * Grant an infinite number of read locks to all the readers in the
+	 * queue. We know that woken will be at least 1 as we accounted for
+	 * above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
 	 */
 	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		struct task_struct *tsk;
 
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
-			break;
+			continue;
 
 		woken++;
 		tsk = waiter->task;
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
