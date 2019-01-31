Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C301C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3582B20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WrSGf8bI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UPQBICY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3582B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+udhvA/n8VVfLnWIPVBESpjkdHGBisiTxa3YOsOdzK0=; b=WrS
	Gf8bICKcyAZYjqtVmOIbWYlA9NhkrsnjQLpFizqhEc+A8GxcZh+/Pkb22Cvzou2y1HqTLaIVXNbYA
	6cGP+EMV2ZRvHhhBGxU0DTprTiS4vIlGAsjSSwpmA1xGwzoaNQBcHbP3wE7YT7wII5J7OTNr2KzX2
	m1w/6cKU3n15igG4JKyouhFgbUXlVJSt2pG3BJHldQAyERyXbaK9TUvoFxp5I8W/v2ptfKR6RY1Vy
	4bbK/6xhsAh0DUg1+1K3w1txgvDFcay17GFiIYfv26VwFvWg/Iai8FRIQdmxJL1IGRC55ubTx/t8+
	ZwvDEi47l2Y5w0XYkbMY0H6E2uZ4b+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2mk-0005c5-0O; Thu, 31 Jan 2019 03:13:02 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2mW-0005RJ-Bv
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:12:50 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V346ND038861;
 Thu, 31 Jan 2019 03:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=xMqDT6dId68xWVt7ZP+vQ/JyOx2ylrZoGIgI/XGDpMY=;
 b=UPQBICY/YT/XvrSvhdu4Pl69aYP3FyfXNjW0j5sphTkLoPESrjuOdYogoZu5XN738XJf
 hWU9W60M3AVZnao3BdiwRuRGIlnaYlLfW+mcLBJBkIq9ip/SpADMokjDKFhAz2AKd5wm
 AAyZuWLRMk5N7V+uw3N4I81kImeiCGKvD9eAfaBIdvutDbLahEbR1tE866rlWxpTHuYc
 g8U/yO0pb3G9xFIOuM4KCq8QsS7s9jOmMumUpFdOA6QsPYKMRySJkskkOCkT4TnHN8So
 W14X1XtVp4UodXixsSInG2hVULfIvq6/gz5Jee4ReN8N0lFpeIKwg6ROpQZQYtDbv6F7 Wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp2130.oracle.com with ESMTP id 2q8d2eebce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3CHdE019387
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Jan 2019 03:12:18 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0V3CGLG031522;
 Thu, 31 Jan 2019 03:12:16 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Jan 2019 19:12:16 -0800
From: Alex Kogan <alex.kogan@oracle.com>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
 will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add NUMA-awareness to qspinlock
Date: Wed, 30 Jan 2019 22:01:32 -0500
Message-Id: <20190131030136.56999-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191248_491825_19B82017 
X-CRM114-Status: GOOD (  17.54  )
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

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA socket as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA sockets. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock.

CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
socket as the current lock holder, and a secondary queue for threads
running on other sockets. Threads record the ID of the socket on which
they are running in their queue nodes. At the unlock time, the lock
holder scans the main queue looking for a thread running on the same
socket. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue.

Full details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 5 runs) of the
total number of ops (x10^7) reported at the end of each run. The stock
kernel is v4.20.0-rc4+ compiled in the default configuration.

#thr  stock  patched speedup (patched/stock)
  1   2.710   2.715  1.002
  2   3.108   3.001  0.966
  4   4.194   3.919  0.934
  8   5.309   6.894  1.299
 16   6.722   9.094  1.353
 32   7.314   9.885  1.352
 36   7.562   9.855  1.303
 72   6.696  10.358  1.547
108   6.364  10.181  1.600
142   6.179  10.178  1.647

When the kernel is compiled with lockstat enabled, CNA 
achieves even larger speedups:

#thr  stock  patched speedup
  1   2.368   2.399  1.013
  2   2.567   2.492  0.970
  4   2.310   2.534  1.097
  8   2.893   4.468  1.544
 16   3.786   5.611  1.482
 32   4.097   5.578  1.362
 36   4.165   5.661  1.359
 72   3.484   5.841  1.677
108   2.890   5.498  1.903
142   2.695   5.356  1.987

This is because lockstat generates writes into shared variables inside the 
critical section to update various stats (e.g., the last CPU on which a
lock was acquired). By keeping the lock local on a socket, CNA reduces the
number of remote cache misses on the access to the lock itself as well as
to the critical section data.

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads (with the kernel compiled in the
default configuration):

#thr  stock patched speedup
  1   0.553   0.579  1.046
  2   0.860   0.907  1.054
  4   1.503   1.533  1.020
  8   1.735   1.704  0.983
 16   1.757   1.744  0.992
 32   0.888   1.705  1.921
 36   0.878   1.746  1.988
 72   0.844   1.766  2.094
108   0.812   1.747  2.150
142   0.804   1.767  2.198

and will-it-scale/lock2_threads:

#thr  stock patched speedup
  1   1.714   1.704  0.994
  2   2.919   2.914  0.998
  4   5.024   5.157  1.027
  8   4.101   3.946  0.962
 16   4.113   3.947  0.959
 32   2.618   4.145  1.583
 36   2.561   3.981  1.554
 72   2.062   4.015  1.947
108   2.157   3.977  1.844
142   1.992   3.916  1.966

As a part of correctness testing, we performed kernel builds on the patched
kernel with X*NCPU parallelism, for X=1,3,5.

Code reviews and performance testing are welcome and appreciated.


Alex Kogan (3):
  locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA

 arch/arm/include/asm/mcs_spinlock.h   |   4 +-
 include/asm-generic/qspinlock_types.h |  10 ++
 kernel/locking/mcs_spinlock.h         |  21 +++-
 kernel/locking/qspinlock.c            | 211 ++++++++++++++++++++++++++++++----
 4 files changed, 218 insertions(+), 28 deletions(-)

-- 
2.11.0 (Apple Git-81)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
