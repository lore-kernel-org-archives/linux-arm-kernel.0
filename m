Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357BC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504F7222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOisl/qn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZ7BPquZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F7222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dJJbKMnoMaY8o5TR576owpnzckEMlR+mM6XPShPxJSU=; b=UOisl/qn8Ekc+/YwbOG45tNGRb
	biY7YrkelZLpb233ZA2l0eALOsXqJvBb2KecRl50r3UYtv4vJA2g4F3gmBlhwlwjEGdJfy4yDRwKI
	h/2fgWSLJR7uHn/ZP8kNgvqCJWgMnRiqUH6Smwor1t5D1LtOfTXKQRVocKWsoEpfzViL37gA6TH4J
	hofaod6QxzEJKcrFdZ27Jr9Hr8QD85+TMhkUQkkzAESsB1zrZBjdGqN9cHFT3C7yfnpVXkPWDKgdI
	X/JkQrIHSMuz40sGwbOwObYCwtEAoomeriHcW398sy9GB8DoD29bfe2KY0xAXntAqaZh55m3inQps
	d5piu7pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4VL-0008K4-9u; Thu, 14 Feb 2019 00:03:51 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4UQ-00079S-DF
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:02:58 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwlSC100511;
 Thu, 14 Feb 2019 00:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=BVvtye26KZIs7muho5hLhXsAoOpu90yJN7XQD4ZHF6s=;
 b=fZ7BPquZinNkNfviJmu2aj5OWxvfaEW6ze9/DO2c6uAP65Cc4e4Cl3T1X2A+uS3/Cnnj
 FXw2tAJbgFiECJbQ4WvubRBn8pxAj4qhxLwEmJiaDQgis7w2FmPwW2j42M7DueNqyBGy
 EyJX2fW7sQZHaipQdaHrDl4Ch27fK6OjK5xHCrNaGpwnUD2AjFaKdF5KlkO1RjMlgz7E
 wO+hNUWeMh8kKPGfqr2rZVzyWdP8lbCxRvKmyeYtHEahIc8wLWsnl9jqQNQFXSxMWNlu
 3RxQ4F/6tOJWAzRs4vywbeqWiVdLGC3PRvx47Ai+oOoMdEY1LwrLa/ajJI34d9cE7gWR uA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2qhre5n3u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E021Ic025030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:02 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E01w4G032279;
 Thu, 14 Feb 2019 00:02:00 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:01:57 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 02/14] x86: always set IF before oopsing from page fault
Date: Wed, 13 Feb 2019 17:01:25 -0700
Message-Id: <b3c439c8187f843a03a514f7d8005dc15fcc909e.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_160254_987601_CA7CF7EC 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Tycho Andersen <tycho@docker.com>, kernel-hardening@lists.openwall.com,
 peterz@infradead.org, dave.hansen@intel.com, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, hch@lst.de, x86@kernel.org,
 kanth.ghatraju@oracle.com, labbott@redhat.com, pradeep.vincent@oracle.com,
 jcm@redhat.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, linux-mm@kvack.org, andrew.cooper3@citrix.com,
 linux-kernel@vger.kernel.org, tyhicks@canonical.com, john.haxby@oracle.com,
 tglx@linutronix.de, oao.m.martins@oracle.com, dwmw@amazon.co.uk,
 kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tycho Andersen <tycho@docker.com>

Oopsing might kill the task, via rewind_stack_do_exit() at the bottom, and
that might sleep:

Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:33
Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name: lkdtm_xpfo_test
Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D         4.13.0-rc5+ #228
Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.1-1ubuntu1 04/01/2014
Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20

To be safe, let's just always enable irqs.

The particular case I'm hitting is:

Aug 23 19:30:27 xpfo kernel: [   38.278615]  __bad_area_nosemaphore+0x1a9/0x1d0
Aug 23 19:30:27 xpfo kernel: [   38.278617]  bad_area_nosemaphore+0xf/0x20
Aug 23 19:30:27 xpfo kernel: [   38.278618]  __do_page_fault+0xd1/0x540
Aug 23 19:30:27 xpfo kernel: [   38.278620]  ? irq_work_queue+0x9b/0xb0
Aug 23 19:30:27 xpfo kernel: [   38.278623]  ? wake_up_klogd+0x36/0x40
Aug 23 19:30:27 xpfo kernel: [   38.278624]  trace_do_page_fault+0x3c/0xf0
Aug 23 19:30:27 xpfo kernel: [   38.278625]  do_async_page_fault+0x14/0x60
Aug 23 19:30:27 xpfo kernel: [   38.278627]  async_page_fault+0x28/0x30

When a fault is in kernel space which has been triggered by XPFO.

Signed-off-by: Tycho Andersen <tycho@docker.com>
CC: x86@kernel.org
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/x86/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..ba51652fbd33 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -748,6 +748,12 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	/* Executive summary in case the body of the oops scrolled away */
 	printk(KERN_DEFAULT "CR2: %016lx\n", address);
 
+	/*
+	 * We're about to oops, which might kill the task. Make sure we're
+	 * allowed to sleep.
+	 */
+	flags |= X86_EFLAGS_IF;
+
 	oops_end(flags, regs, sig);
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
