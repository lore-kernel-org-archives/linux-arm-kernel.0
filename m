Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A1C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4F2218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASjVlWsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4F2218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J5x6SyzEe+bNB+jFLx+k6eppNLbl4jfw/whEfcuIfD8=; b=ASjVlWsOTIQtUW
	Vx//imlz9mxTlbhZqRm3WU8os0eSJgnqb5UDzzJUTexo2QzCOljIovajc3ELCTYsU6u3l09Dn87V1
	h01tmJrtHm6zO2tNIYZe/P+hDcOkQaPwMxIfV5Hkg7ztUw7Ds0JE1Vza1f0ew8qTR9blKvzKQKeON
	p+zkM58rIYjIsIYZp8i959H5pBdSwrcP5DKI0qBRdbUYf9lW2iofxc5oPBblGglW3j5shmcExsHFd
	qnPXjl0iIKvOFQmNuDiRM3FYVISoBFZdGSNYDfVbjlEVwlZ4Zv1tnqSPCprVSjn+oaQhQxrwMx3Vo
	SNTsT/cpeQGHnUZYvjoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp95P-0005dU-Es; Thu, 31 Jan 2019 09:56:43 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp95M-0005cu-J7; Thu, 31 Jan 2019 09:56:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3164A20423039; Thu, 31 Jan 2019 10:56:38 +0100 (CET)
Date: Thu, 31 Jan 2019 10:56:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
Message-ID: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com,
 will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com,
 longman@redhat.com, daniel.m.jordan@oracle.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:01:32PM -0500, Alex Kogan wrote:
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA socket as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA sockets. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock.

Since you use NUMA, use the term node, not socket. The two are not
strictly related.

> CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> socket as the current lock holder, and a secondary queue for threads
> running on other sockets. Threads record the ID of the socket on which
> they are running in their queue nodes. At the unlock time, the lock
> holder scans the main queue looking for a thread running on the same
> socket. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue.
> 
> Full details are available at https://arxiv.org/abs/1810.05600.

Full details really should also be in the Changelog. You can skip much
of the academic bla-bla, but the Changelog should be self contained.

> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 5 runs) of the
> total number of ops (x10^7) reported at the end of each run. The stock
> kernel is v4.20.0-rc4+ compiled in the default configuration.
> 
> #thr  stock  patched speedup (patched/stock)
>   1   2.710   2.715  1.002
>   2   3.108   3.001  0.966
>   4   4.194   3.919  0.934

So low contention is actually worse. Funnily low contention is the
majority of our locks and is _really_ important.

>   8   5.309   6.894  1.299
>  16   6.722   9.094  1.353
>  32   7.314   9.885  1.352
>  36   7.562   9.855  1.303
>  72   6.696  10.358  1.547
> 108   6.364  10.181  1.600
> 142   6.179  10.178  1.647
> 
> When the kernel is compiled with lockstat enabled, CNA 

I'll ignore that, lockstat/lockdep enabled runs are not what one would
call performance relevant.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
