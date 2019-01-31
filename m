Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055DC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:13:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A639D218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9fRqqtG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3zsGBno8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A639D218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RPHi6D/5SocZdzZczUTh7mrI//6hXWIigxZm6uISpso=; b=K9fRqqtGyCvJv4mqCUn5IDjBKv
	3TdHhNzR7+PS1mE1OM+VRia9XbFU09XOb4tPGcvsvOePWrlME7Hldb/S4hMYQIJDN4wTMWAwhkdni
	9CfqB0GYbgiZfD+XU83r0XfwL8k/nFUFzkON5OsOy8rqG6VSVwRS7LPIL7PYxtVEaiJ83oIm4aoWH
	PYbRcToosHZgJdFi/K1s6E4Isy56FY7mjQn9+4TPas3TfFiojNM44Efn75kTSSaiupEWjmPaYTDuO
	RbtaR7psJraegnNnBMpAzhs16BlaeeR9K3/MbUFlCXr4GZhaUjalIAGlB1ZqEsiDydvpXg/7dMoUa
	1+OQrC1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2nY-0006G6-Az; Thu, 31 Jan 2019 03:13:52 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2mX-0005Ro-9M
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:12:52 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V344am092454;
 Thu, 31 Jan 2019 03:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=6Dcg95B5Pbg4xGrdBHcTp6OfPHmUxE9QC4xTyCNuJA4=;
 b=3zsGBno8rirXolakdVkWJazPj/EjH09XGmQa07ChaNXCOPf0bCY2sn4ru5zta/ZJCx7R
 /UsvKW+w8K/CSYGYyD/Y9KOpnjBx3IkG+nDRoDgoIO3W/hNZs3ZPAJe1QB/W2IDwI79K
 6l9LYevsZbcHvtZtf7ib3DbZRfVI1//RleQ+tgwHg454M+iWg5bDNFb6elVNc2ZHRixY
 G6aJFmY20TaQBKzxE8APC7SF35/H8XkzHaSZNZ4nf/UFSOWJTxRITae19l76HYKgXxJW
 n/ijkzEDV/MeuwPxLsaIElCpgfuBks+aU7+gv4x4T276NWdssvUGz2n+Vpkm1EeILeiQ tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2q8eyup3u9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3CJMn002795
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:19 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3CJRZ031538;
 Thu, 31 Jan 2019 03:12:19 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Jan 2019 19:12:19 -0800
From: Alex Kogan <alex.kogan@oracle.com>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
 will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance into CNA
Date: Wed, 30 Jan 2019 22:01:35 -0500
Message-Id: <20190131030136.56999-4-alex.kogan@oracle.com>
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
X-CRM114-CacheID: sfid-20190130_191249_410845_9854E96E 
X-CRM114-Status: GOOD (  20.98  )
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

Choose the next lock holder among spinning threads running on the same
socket with high probability rather than always. With small probability,
hand the lock to the first thread in the secondary queue or, if that
queue is empty, to the immediate successor of the current lock holder
in the main queue.  Thus, assuming no failures while threads hold the
lock, every thread would be able to acquire the lock after a bounded
number of lock transitions, with high probability.

Note that we could make the inter-socket transition deterministic,
by sticking a counter of intra-socket transitions in the head node
of the secondary queue. At the handoff time, we could increment
the counter and check if it is below a threshold. This adds another
field to queue nodes and nearly-certain local cache miss to read and
update this counter during the handoff. While still beating stock,
this variant adds certain overhead over the probabilistic variant.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 6addc24f219d..d3caef4f84e2 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -31,6 +31,7 @@
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
+#include <linux/random.h>
 
 /*
  * Include queued spinlock statistics code
@@ -112,6 +113,18 @@ struct qnode {
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
+/* Per-CPU pseudo-random number seed */
+static DEFINE_PER_CPU(u32, seed);
+
+/*
+ * Controls the probability for intra-socket lock hand-off. It can be
+ * tuned and depend, e.g., on the number of CPUs per socket. For now,
+ * choose a value that provides reasonable long-term fairness without
+ * sacrificing performance compared to a version that does not have any
+ * fairness guarantees.
+ */
+#define INTRA_SOCKET_HANDOFF_PROB_ARG	0x10000
+
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
  * therefore increment the cpu number by one.
@@ -369,6 +382,35 @@ static struct mcs_spinlock *find_successor(struct mcs_spinlock *me,
 	return NULL;
 }
 
+/*
+ * xorshift function for generating pseudo-random numbers:
+ * https://en.wikipedia.org/wiki/Xorshift
+ */
+static inline u32 xor_random(void)
+{
+	u32 v;
+
+	v = this_cpu_read(seed);
+	if (v == 0)
+		get_random_bytes(&v, sizeof(u32));
+
+	v ^= v << 6;
+	v ^= v >> 21;
+	v ^= v << 7;
+	this_cpu_write(seed, v);
+
+	return v;
+}
+
+/*
+ * Return false with probability 1 / @range.
+ * @range must be a power of 2.
+ */
+static bool probably(unsigned int range)
+{
+	return xor_random() & (range - 1);
+}
+
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
 /**
@@ -647,8 +689,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	/* Try to pass the lock to a thread running on the same socket. */
-	succ = find_successor(node, cpuid);
+	/*
+	 * Try to pass the lock to a thread running on the same socket.
+	 * For long-term fairness, search for such a thread with high
+	 * probability rather than always.
+	 */
+	succ = NULL;
+	if (probably(INTRA_SOCKET_HANDOFF_PROB_ARG))
+		succ = find_successor(node, cpuid);
+
 	if (succ) {
 		arch_mcs_spin_unlock_contended(&succ->locked, node->locked);
 	} else if (node->locked > 1) {
-- 
2.11.0 (Apple Git-81)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
