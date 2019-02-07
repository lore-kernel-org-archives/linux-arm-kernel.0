Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D345FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6A52175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="efDoWZUs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqpxVOE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6A52175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PSOa5LOMcNek2G4o/QKAtg0SNHOJ8iMEj6L/+SaGv8Q=; b=efDoWZUsewaK8vdcxLK8j8UmYf
	nu90Rdw55LkN//fUQdYx6hW9tB4iLqT1Cl7TabzPjvHdVXxuWZZnJXd36RP8RbLA1PJqzaw/5aA1J
	cy7kCIkigG+c2O8TVLHmr5utq5nW9bCLzavjtLn1lj0rPCQhjP5c2/lrSq5P8HoS+gfQQpiWDKtIv
	AXoqXuzU3j5Ks//xPLYpena0U/e1n1wQY80SY9KLyIaJmIeyTU2xK494JsHNPhGP7zcEK9peU+O6Z
	ufYW9qcSLcsd06ztwXPzQ0ONAC65l+pr5AH3YhofB/r1r0xjrmqKYvjySFuC4FPYOZPMwW/FtRTsD
	c1ROGPTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpJW-0003Vh-Nk; Thu, 07 Feb 2019 19:26:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpIt-0001Lj-SP
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 19:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vt/XCGbmQuL8jgZVUNIZIsufZRIa7td9DQItWnkrN6Y=; b=HqpxVOE7EoC7Ki2W+W+bCTwa8
 pfsq+knHqYAsH0xHoeEGTGbtsWUFHGG06C8NwWCij7O3xHYmumHG+QQRzSElwP03CU7cvx4VursEV
 NIcCh2S33MorHvjy/256On6gU6yl7H4NKPuPK3CwEIi0dnKISYj+mATP0e6eK+4jpvtWtbeMVALYZ
 GQCOX2sLZ4q5Gc24JB6aFzp6XUg6vaDs9aRa3dt/ZGIuLYgYPYgv+1IxfdI0naKEz7egAgEEIVBMF
 KpSWJflaDeM2buATuz7Dy1nkihARnijx1kMPNhhk+PQ5jMmqNUB1Z6YvGrRl6BV1t1fOM1PvWbSC3
 /D7VMpbsg==;
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp3n-0004iA-T0
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:10:11 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00B3AC06A802;
 Thu,  7 Feb 2019 19:10:06 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18D6161146;
 Thu,  7 Feb 2019 19:09:56 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 17/22] locking/rwsem: Recheck owner if it is not on cpu
Date: Thu,  7 Feb 2019 14:07:21 -0500
Message-Id: <1549566446-27967-18-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 19:10:06 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_191008_257982_8FF027CB 
X-CRM114-Status: GOOD (  23.09  )
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

After merging the owner value directly into the count field, it was
found that the number of failed optimistic spinning operations increased
significantly during the boot up process.

The cause of this increased failures was tracked down to the condition
that a lock holder might have just released the lock and gone to sleep
right after its owner value was fetched by a spinner. So the task might
have slept, but it was no longer the lock holder. The merging of owner
into count increases the chance this condition can happen.

To close this failure mode, we are now rechecking the owner value again
to see if it has been changed in case it is not on cpu.

On a 1-socket x86-64 system, the lock event counts before the patch
were:

  rwsem_opt_fail=5847
  rwsem_opt_wlock=7880
  rwsem_wlock=5847

After the patch, the counts were:

  rwsem_opt_fail=225
  rwsem_opt_wlock=8541
  rwsem_wlock=225

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 16dc7a1..21d462f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -263,13 +263,25 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
 	}
 }
 
-static inline bool owner_on_cpu(struct task_struct *owner)
+static inline bool owner_on_cpu(struct task_struct *owner,
+				struct rw_semaphore *sem)
 {
 	/*
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
 	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+	bool oncpu = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+
+	/*
+	 * There is a slight chance that the lock holder might have
+	 * just release the rwsem and gone to sleep right after we
+	 * fetched the owner value. So we double-check the sem->owner
+	 * field again to see if it has been changed. The sem->owner
+	 * would have been cleared right before the lock was released.
+	 */
+	if (!oncpu && (READ_ONCE(sem->owner) != owner))
+		return true;	/* Assume the new owner is on cpu */
+	return oncpu;
 }
 
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
@@ -286,7 +298,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
-		      owner_on_cpu(owner);
+		      owner_on_cpu(owner, sem);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -323,7 +335,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * abort spinning when need_resched or owner is not running or
 		 * owner's cpu is preempted.
 		 */
-		if (need_resched() || !owner_on_cpu(owner)) {
+		if (need_resched() || !owner_on_cpu(owner, sem)) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
