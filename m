Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524CEC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:12:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23187218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dum/4bh1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9BgMiMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23187218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PdT9lQSkPcB1VgZRL+D10y5DuO2SrmlsJ/ZVUbrTNzo=; b=Dum/4bh1rpaTcWu8Y6cl2pQDpF
	LOnbPVhwxGKdrPMBpaIOX+ibLYfelMHX1ih1PiTvgTuobcwsIVL8puDJ70Histxd9Kbazx3wQuh6N
	/UoG+sVKNjseWezvaQc24e1YyWWYSTVcf4ocjfqsLx9ZacfQx8UEV9Bo3FlawGkK/n234r15u/TZ0
	LS4EDPeJBy8xBQmbdIJ+miw82hYg6RrXLYT8QkJHr8B/ahrf1yhtE/FanigRnHVlERRGAM0leK2B4
	sB2bgbEcrUr3VVid/Weo3fmlpop2J5bP6Ai80qO8puoSHyEsBuXGvcy3XtIjgKQBK36kyKVJ6lrdp
	5MLt5jIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2mZ-0005Sd-WE; Thu, 31 Jan 2019 03:12:52 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2mW-0005RH-BX
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:12:49 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V346KH038858;
 Thu, 31 Jan 2019 03:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZplTQZzydafeBnPD4u24Dgisox98ztxk94cpluzKZc8=;
 b=h9BgMiMj62/58rCk8HoDR4fSLSmqUCgwgBpYJPMT1U0Luqc0fB1krarFGfn4c/R6XeyH
 zwMkhd5kPg5qfJfHoFpr4AWLHzlhbVRuq877nGipTFMKKJpWL/pqAHKbG3UxVikCk2Em
 UBSs1blCyN1wwR0jPUnpCQTVgZARJ+ZHkq9ec+3yyPr8q5Wn2isRb+ilwDE5vMLU/wS8
 DPaSapjLYYziRncp/GfOs3vqFGdMpyHguWgMvTwLxuOqbKEGGVeqPxjuVEx30TME8n2q
 08Klpo7eK/chdjoFovj4XRT+MVcOp4Fbhb1GkvG36H2wQCQ3wASC0zSF90Mq3rsK3rrV /A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2q8d2eebcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3CIDd031689
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:18 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0V3CHiG017729;
 Thu, 31 Jan 2019 03:12:17 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Jan 2019 19:12:17 -0800
From: Alex Kogan <alex.kogan@oracle.com>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
 will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] locking/qspinlock: Make arch_mcs_spin_unlock_contended
 more generic
Date: Wed, 30 Jan 2019 22:01:33 -0500
Message-Id: <20190131030136.56999-2-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191248_487249_97523B8C 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The arch_mcs_spin_unlock_contended macro should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored is different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/arm/include/asm/mcs_spinlock.h | 4 ++--
 kernel/locking/mcs_spinlock.h       | 6 +++---
 kernel/locking/qspinlock.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..ae6d763477f4 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_spin_unlock_contended(lock, val)			\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release(lock, (val));					\
 	dsb_sev();							\
 } while (0)
 
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..bc6d3244e1af 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -41,8 +41,8 @@ do {									\
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_spin_unlock_contended(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c208c5e..fc88e9685bdf 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -545,7 +545,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
-- 
2.11.0 (Apple Git-81)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
