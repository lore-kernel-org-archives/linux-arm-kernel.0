Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F402147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BF9QPGfA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1ntPd+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F402147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5T8tnNeYM41LmW5fP6da8l/mnBaIwrlza52T1nAW4Zo=; b=BF9QPGfA21Uu6+znvgBOy273XQ
	HmPfADB2gOzKwcz1IptKgnjMNWyyKu1UzCnHxicLr4nE9PfVXMkrFYLCt8XGOABcdls+Yu/PbGGRp
	s7HRTTYwXDqkPN6/yhQKX+SvH98eVymSxXDjZIEt7FgI1bVkFAKYcbpdUNy5CwNFRYpMEbjtfiZSH
	K/S/l7r/enOHneiNeaTeZ/pyO0UN2HSv6WdUaZEcJHL0wqUXgPTTJ4Mg5CRL19MNybac6NsmwdT9Z
	Mhh8iXSThjdMGeTNiW3ys+XSgKKFKJHWlEzS5o5PNFnGuRgpXlpEmods+KBTZXV2MRMqvJ6mRJE1b
	PC8cNHgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpJ3-00033Q-F9; Thu, 07 Feb 2019 19:25:53 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpIp-0001Lj-E7
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 19:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2BzJfQ28eX30mILbGmAhOP5mrHwrSIS9JcAba+Xq5mI=; b=m1ntPd+J0k9HC378sxROJirbO
 JtOWK3g1YSvmhSjibnM7orcNJG5chMBZlDfBeO6qP/cBnUiTQY8GwcpVkXpwKokFADLs24UoJ4iSO
 OVnoXOL1NX4YfSXyNAIAcMiNBcsrUU7jJYoNH888Pza34BookZv6V6LDPPoPLQhQrxEnFdu3GkO4p
 jbNTSSFAkXIUK/6Re2Bsrzlp7tYI1Cqyqk/N7rNpZPNPPYs5Va80mA0xjPfAjiMhkpcdInUZgpNpe
 r//DKTJ3wbpsOEzVngvaFLPGNrjdBRNkLJ+dXDDcIRDNHdgVLrLzYKdJQWL+GWVqgVBLETPLrBmme
 6NIsKubXQ==;
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp40-0004kP-Pa
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:10:26 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F35788E4F;
 Thu,  7 Feb 2019 19:10:18 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2C1861146;
 Thu,  7 Feb 2019 19:10:13 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 19/22] locking/rwsem: Enable readers spinning on writer
Date: Thu,  7 Feb 2019 14:07:23 -0500
Message-Id: <1549566446-27967-20-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 19:10:19 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_191021_299558_62D293DC 
X-CRM114-Status: GOOD (  27.43  )
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

This patch enables readers to optimistically spin on a
rwsem when it is owned by a writer instead of going to sleep
directly.  The rwsem_can_spin_on_owner() function is extracted
out of rwsem_optimistic_spin() and is called directly by
__rwsem_down_read_failed_common() and __rwsem_down_write_failed_common().

This patch may actually reduce performance under certain circumstances
for reader-mostly workload as the readers may not be grouped together
in the wait queue anymore.  So we may have a number of small reader
groups among writers instead of a large reader group. However, this
change is needed for some of the subsequent patches.

With a locking microbenchmark running on 5.0 based kernel, the total
locking rates (in kops/s) of the benchmark on a 4-socket 56-core x86-64
system with equal numbers of readers and writers before and after the
patch were as follows:

   # of Threads  Pre-patch    Post-patch
   ------------  ---------    ----------
        2          1,926        2,120
        4          1,391        1,320
        8            716          694
       16            618          606
       32            501          487
       64             61           57

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem-xadd.c       | 80 ++++++++++++++++++++++++++++++++++-----
 kernel/locking/rwsem-xadd.h       |  3 ++
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 4cde507..54b6650 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -57,6 +57,7 @@
 LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
 LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
 LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
+LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0a29aac..015edd6 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -240,6 +240,30 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
+ * Try to acquire read lock before the reader is put on wait queue.
+ * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
+ * is ongoing.
+ */
+static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+
+	if (RWSEM_COUNT_WLOCKED_OR_HANDOFF(count))
+		return false;
+
+	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
+	if (!RWSEM_COUNT_WLOCKED_OR_HANDOFF(count)) {
+		rwsem_set_reader_owned(sem);
+		lockevent_inc(rwsem_opt_rlock);
+		return true;
+	}
+
+	/* Back out the change */
+	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+	return false;
+}
+
+/*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
@@ -291,8 +315,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
 
-	if (need_resched())
+	if (need_resched()) {
+		lockevent_inc(rwsem_opt_fail);
 		return false;
+	}
 
 	rcu_read_lock();
 	owner = rwsem_get_owner(sem);
@@ -301,6 +327,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		      owner_on_cpu(owner, sem);
 	}
 	rcu_read_unlock();
+	lockevent_cond_inc(rwsem_opt_fail, !ret);
 	return ret;
 }
 
@@ -371,9 +398,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	preempt_disable();
 
 	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!rwsem_can_spin_on_owner(sem))
-		goto done;
-
 	if (!osq_lock(&sem->osq))
 		goto done;
 
@@ -388,10 +412,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		/*
 		 * Try to acquire the lock
 		 */
-		if (rwsem_try_write_lock_unqueued(sem, wlock)) {
-			taken = true;
+		taken = wlock ? rwsem_try_write_lock_unqueued(sem, wlock)
+			      : rwsem_try_read_lock_unqueued(sem);
+
+		if (taken)
 			break;
-		}
 
 		/*
 		 * When there's no owner, we might have preempted between the
@@ -418,7 +443,13 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	return taken;
 }
 #else
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
+{
+	return false;
+}
+
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
+					 const long wlock)
 {
 	return false;
 }
@@ -444,6 +475,33 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	if (!rwsem_can_spin_on_owner(sem))
+		goto queue;
+
+	/*
+	 * Undo read bias from down_read() and do optimistic spinning.
+	 */
+	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
+	adjustment = 0;
+	if (rwsem_optimistic_spin(sem, 0)) {
+		unsigned long flags;
+
+		/*
+		 * Opportunistically wake up other readers in the wait queue.
+		 * It has another chance of wakeup at unlock time.
+		 */
+		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS) &&
+		    raw_spin_trylock_irqsave(&sem->wait_lock, flags)) {
+			if (!list_empty(&sem->wait_list))
+				__rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
+						  &wake_q);
+			raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
+			wake_up_q(&wake_q);
+		}
+		return sem;
+	}
+
+queue:
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
@@ -456,7 +514,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 		 * immediately as its RWSEM_READER_BIAS has already been
 		 * set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
+		if (adjustment &&
+		   !(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
@@ -543,7 +602,8 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_optimistic_spin(sem, wlock))
+	if (rwsem_can_spin_on_owner(sem) &&
+	    rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
 	/*
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index 1de6f1e..eb4ef36 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -109,9 +109,12 @@
 				 RWSEM_FLAG_HANDOFF)
 
 #define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
+#define RWSEM_COUNT_WLOCKED(c)	((c) & RWSEM_WRITER_MASK)
 #define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
 #define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
 	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
+#define RWSEM_COUNT_WLOCKED_OR_HANDOFF(c)	\
+	((c) & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
 
 /*
  * Task structure pointer compression (64-bit only):
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
