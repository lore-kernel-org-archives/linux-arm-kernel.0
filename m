Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:34:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5393E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnRrfH8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5393E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:MIME-Version:References:
	In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A/+BiAP8q4Xut2U32bfOTyR/CiT/PU3ZC+QndwPYhr8=; b=tnRrfH8NEoyvcS
	Sz7yzs3pmt5TT9PLZwg5mkfRFmMAsstE+TZ0GKhQ9yNdpzCCU/W1g3rfrD3mFNKTW8ZWEc5z/lXK6
	TuWWyUjGmg0/j+r8o0w9hmgRC2wzUls+1EB6FRUqbUfxsrvJslrJ23WrSk56wgZtiYXOH1LBYqD8f
	c3nFPJkHPnCQJeTyefX6O5di41QKxU7HO4SXtUYWXdNsm61Qk7IoB7b0TpeFl4KrAhYyM8hwP//BL
	vtlrht785aCeZQwfr2okf7sQnGnkgvk/NLRH1rTV4Xo4GK+5nblc/QoIku3xeanvMCVi+DhkC+jQR
	iN0pcNzfr0OY9ofUTdTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNxK-0000xJ-Jh; Wed, 05 Dec 2018 03:34:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNxH-0000wO-45
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:34:33 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB53XpxW052113
 for <linux-arm-kernel@lists.infradead.org>; Tue, 4 Dec 2018 22:34:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p667pse60-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Tue, 04 Dec 2018 22:34:15 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <ravi.bangoria@linux.ibm.com>; 
 Wed, 5 Dec 2018 03:34:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 03:34:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB53Y6Pp50790448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 03:34:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 964CBA405D;
 Wed,  5 Dec 2018 03:34:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27F1EA4040;
 Wed,  5 Dec 2018 03:34:03 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.98])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  5 Dec 2018 03:34:02 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, liu.song.a23@gmail.com
Subject: [PATCH v2] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Date: Wed,  5 Dec 2018 09:04:23 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204005803.787578e7@vmware.local.home>
References: <20181204005803.787578e7@vmware.local.home>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18120503-4275-0000-0000-000002EC263F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120503-4276-0000-0000-000037F93049
Message-Id: <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-04_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_193431_274924_0243DCCD 
X-CRM114-Status: GOOD (  19.41  )
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
Cc: linux-mips@linux-mips.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 linux@armlinux.org.uk, alexander.shishkin@linux.intel.com,
 paul.burton@mips.com, mingo@redhat.com, ralf@linux-mips.org,
 ananth@linux.vnet.ibm.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, alexis.berlemont@gmail.com, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There could be a race between task exit and probe unregister:

  exit_mm()
  mmput()
  __mmput()                     uprobe_unregister()
  uprobe_clear_state()          put_uprobe()
  delayed_uprobe_remove()       delayed_uprobe_remove()

put_uprobe() is calling delayed_uprobe_remove() without taking
delayed_uprobe_lock and thus the race sometimes results in a
kernel crash. Fix this by taking delayed_uprobe_lock before
calling delayed_uprobe_remove() from put_uprobe().

Detailed crash log can be found at:
  https://lkml.org/lkml/2018/11/1/1244

Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 322e97bbb437..abbd8da9ac21 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
 		 * gets called, we don't get a chance to remove uprobe from
 		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
 		 */
+		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
+		mutex_unlock(&delayed_uprobe_lock);
 		kfree(uprobe);
 	}
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
