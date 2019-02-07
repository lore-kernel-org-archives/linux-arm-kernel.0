Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C33C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A4D206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+TcEukB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tx7iuAwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A4D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PK+b12hfTl5IIWgVQKIL5P6hN+Gbu9oE+7yETtJT+ak=; b=l+TcEukBNkskuXmPGuTi6V1xk3
	Ex6rFEgg9PW6pPYYL1E/n86HUEa7xAy8EkxKforjTgZq3QO+TkWruqCFXR/hKvOvYoO7roiB0xydc
	kN2UAgP2qRst4VYMoo91tkDsQJP+OZLhiIe/OegGQ11phzOOR/WeNrJtqh0KYBrwJEvfYpx84N57i
	6aqvRz9ILVOE6kX1AoF7pa5Cu6jtKDocw2xDE71zHRloniGDT4vMNhC+9Hnc0ulszF8IzgVDBWIQL
	68TmIjAgabqyIcDCiUXM/FUCq6F1rwNq66y6WRQydUfof68L3sTWMUHS5D9eNkJcLB9VRe26k6elL
	77PvwcFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpJL-0003Hc-5N; Thu, 07 Feb 2019 19:26:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpIq-0001Lj-J1
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 19:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JC3fRuvNlOVrYA3yYzDRdusfxebHbz1dNMfQt9EmNN4=; b=tx7iuAwUvpRFhBV5DnpxPOFc3
 REngkmBlVLOoiwCFZQYlY5v2iz7spNEGn7eEfATuwA05m985gcFGoqN2KA/cefaYJtR4kFhQI6J0t
 R3r7HKLoXbhK4jrWp50UmFtVkNLLBgdDP3usUpKyFGA3lphkHgVzAOlIq1EBJdEhveDD/Dd96epTT
 UQ10Mt1MI2Smme7zE+hPym96wReLW1kpe1Js9d2CN4XmB1jr60s/0W4bPd1YJyIZ1dn6Ny60SyvJp
 vAdvSRq5VxBwh72KsVRZKPXVyYsQVUtP6X/A+NejMIa/WGDeXYnPift6yLRFx4r+bEzp0vMXqoPRG
 BD7dz9/DA==;
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grp3w-0004jW-HY
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:10:18 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3FF8C0669A8;
 Thu,  7 Feb 2019 19:10:13 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1846D17A75;
 Thu,  7 Feb 2019 19:10:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-tip 18/22] locking/rwsem: Make rwsem_spin_on_owner() return a
 tri-state value
Date: Thu,  7 Feb 2019 14:07:22 -0500
Message-Id: <1549566446-27967-19-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 07 Feb 2019 19:10:15 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_191016_908484_B2FC98A6 
X-CRM114-Status: GOOD (  21.92  )
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

This patch modifies rwsem_spin_on_owner() to return a tri-state value
to better reflect the state of lock holder which enables us to make a
better decision of what to do next.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 25 +++++++++++++++++++------
 kernel/locking/rwsem-xadd.h |  5 +++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 21d462f..0a29aac 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -305,14 +305,24 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * Return true only if we can still spin on the owner field of the rwsem.
+ * Return the folowing three values depending on the lock owner state.
+ *   1	when owner changes and no reader is detected yet.
+ *   0	when owner changes and the new owner may be a reader.
+ *  -1	when optimistic spinning has to stop because either the owner stops
+ *	running, is unknown, or its timeslice has been used up.
  */
-static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
+enum owner_state {
+	OWNER_SPINNABLE = 1,
+	OWNER_READER = 0,
+	OWNER_NONSPINNABLE = -1,
+};
+
+static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = rwsem_get_owner(sem);
 
 	if (!is_rwsem_owner_spinnable(owner))
-		return false;
+		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
 	/*
@@ -337,7 +347,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		if (need_resched() || !owner_on_cpu(owner, sem)) {
 			rcu_read_unlock();
-			return false;
+			return OWNER_NONSPINNABLE;
 		}
 
 		cpu_relax();
@@ -348,7 +358,10 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return is_rwsem_owner_spinnable(rwsem_get_owner(sem));
+	owner = rwsem_get_owner(sem);
+	if (!is_rwsem_owner_spinnable(owner))
+		return OWNER_NONSPINNABLE;
+	return is_rwsem_owner_reader(owner) ? OWNER_READER : OWNER_SPINNABLE;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
@@ -371,7 +384,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem)) {
+	while (rwsem_spin_on_owner(sem) == OWNER_SPINNABLE) {
 		/*
 		 * Try to acquire the lock
 		 */
diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index d54b5db..1de6f1e 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -200,6 +200,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
+static inline bool is_rwsem_owner_reader(struct task_struct *owner)
+{
+	return (unsigned long)owner & RWSEM_READER_OWNED;
+}
+
 /*
  * Return true if the rwsem is owned by a reader.
  */
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
