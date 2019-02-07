Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:47:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476CC2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NX4jRFOr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUw20R2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476CC2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Z5EY3BKQUi4s3+1Es4WKo4xtzRd6ZcH9CzMMhWjaVPc=; b=NX4jRFOr4PM6jelZjVzlrJ2roO
	ev19W6TFfiMqz+qbl8zipllDambussfkfbcLZqoir2wHrOKCckIX9rMuHqzZh7PZkaF5XjMCUOS8F
	M0rfyFROS2GWYAz73m6W3TmoWBbQxqQ30+RaISpsm7hacc4Si0Ldq/KpaINvWtiABC9CVsiSkQLgd
	pioVmKR767h0FTfLCbxhgBJHb/Gdr28/zuHElHO3bWmKYZODqw0zw4jNf7CLikT/6twetnzb+syv7
	TEr5C6u6E3g/RNVWC0+KQ/4gd7QrcOIC7JV0mhOXu9OINZfBTcwUEW/OPnrL4Pe58qPcGFYOQd7g0
	piZsIxGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpdT-00048u-FK; Thu, 07 Feb 2019 19:46:59 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpcX-00039e-Ir
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 19:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usH3oRbkHLhZa5ayUo2LkVxAFDyRxZeMHVQI7eIep88=; b=YUw20R2H+QSScAunIfzx35d3B
 k+jGkjhIz6wgfSHe6xFvQWJjOWQf1wKhUfF8NJX8pbVNWR8/hssWTCanBlzkurtWmQZMV/FslnUIE
 rsICu4DFTo7hmcezVXqgqO0JU77wVCXVPv+u2lz9GuQtp+lYoroxJvz0L+J0ElINTmiH3cUc0szHZ
 sM5sHFe3JHaeb5HLX15qi5zhXQ68U9ncYD1UxN4NzKs7SqbmZUiOBLpEg6eMv4ZYGsiJcTevZHajt
 Tt2Yvpog36TJHBki/PwYWhipZ0ceKdXEvA9gB2QcvG4Zs+jTYYu+y8w3CMLnlYLC2uddVW19cIZHP
 H402Obl0A==;
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp3W-0006iX-E2
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:09:51 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3875A10FA1;
 Thu,  7 Feb 2019 19:09:49 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0629D60FDF;
 Thu,  7 Feb 2019 19:09:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 13/22] locking/rwsem: Remove rwsem_wake() wakeup
 optimization
Date: Thu,  7 Feb 2019 14:07:17 -0500
Message-Id: <1549566446-27967-14-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 07 Feb 2019 19:09:49 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_140950_662482_55EADAE0 
X-CRM114-Status: GOOD (  19.85  )
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

With the commit 59aabfc7e959 ("locking/rwsem: Reduce spinlock contention
in wakeup after up_read()/up_write()"), the rwsem_wake() forgoes doing
a wakeup if the wait_lock cannot be directly acquired and an optimistic
spinning locker is present.  This can help performance by avoiding
spinning on the wait_lock when it is contended.

With the later commit 133e89ef5ef3 ("locking/rwsem: Enable lockless
waiter wakeup(s)"), the performance advantage of the above optimization
diminishes as the average wait_lock hold time become much shorter.

By supporting rwsem lock handoff, we can no longer relies on the fact
that the presence of an optimistic spinning locker will ensure that the
lock will be acquired by a task soon. This can lead to missed wakeup
and application hang. So the commit 59aabfc7e959 ("locking/rwsem:
Reduce spinlock contention in wakeup after up_read()/up_write()")
will have to be reverted.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 74 ---------------------------------------------
 1 file changed, 74 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 12b1d61..5f74bae 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -378,25 +378,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
-
-/*
- * Return true if the rwsem has active spinner
- */
-static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
-{
-	return osq_is_locked(&sem->osq);
-}
-
 #else
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	return false;
 }
-
-static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
-{
-	return false;
-}
 #endif
 
 /*
@@ -662,67 +648,7 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
 
-	/*
-	* __rwsem_down_write_failed_common(sem)
-	*   rwsem_optimistic_spin(sem)
-	*     osq_unlock(sem->osq)
-	*   ...
-	*   atomic_long_add_return(&sem->count)
-	*
-	*      - VS -
-	*
-	*              __up_write()
-	*                if (atomic_long_sub_return_release(&sem->count) < 0)
-	*                  rwsem_wake(sem)
-	*                    osq_is_locked(&sem->osq)
-	*
-	* And __up_write() must observe !osq_is_locked() when it observes the
-	* atomic_long_add_return() in order to not miss a wakeup.
-	*
-	* This boils down to:
-	*
-	* [S.rel] X = 1                [RmW] r0 = (Y += 0)
-	*         MB                         RMB
-	* [RmW]   Y += 1               [L]   r1 = X
-	*
-	* exists (r0=1 /\ r1=0)
-	*/
-	smp_rmb();
-
-	/*
-	 * If a spinner is present and the handoff flag isn't set, it is
-	 * not necessary to do the wakeup.
-	 *
-	 * Try to do wakeup only if the trylock succeeds to minimize
-	 * spinlock contention which may introduce too much delay in the
-	 * unlock operation.
-	 *
-	 *    spinning writer		up_write/up_read caller
-	 *    ---------------		-----------------------
-	 * [S]   osq_unlock()		[L]   osq
-	 *	 MB			      RMB
-	 * [RmW] rwsem_try_write_lock() [RmW] spin_trylock(wait_lock)
-	 *
-	 * Here, it is important to make sure that there won't be a missed
-	 * wakeup while the rwsem is free and the only spinning writer goes
-	 * to sleep without taking the rwsem. Even when the spinning writer
-	 * is just going to break out of the waiting loop, it will still do
-	 * a trylock in rwsem_down_write_failed() before sleeping. IOW, if
-	 * rwsem_has_spinner() is true, it will guarantee at least one
-	 * trylock attempt on the rwsem later on.
-	 */
-	if (rwsem_has_spinner(sem) && !RWSEM_COUNT_HANDOFF(count)) {
-		/*
-		 * The smp_rmb() here is to make sure that the spinner
-		 * state is consulted before reading the wait_lock.
-		 */
-		smp_rmb();
-		if (!raw_spin_trylock_irqsave(&sem->wait_lock, flags))
-			return sem;
-		goto locked;
-	}
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
-locked:
 
 	if (!list_empty(&sem->wait_list))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
