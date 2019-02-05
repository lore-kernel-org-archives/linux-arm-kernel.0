Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E0C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:23:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FB520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtDhnBAt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2m/B2UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FB520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dqep0PU1nVT6wgDiJGB87N7i3u9WuclItBoK9SrVjc=; b=WtDhnBAtbFI8/4
	fu/6M9vnl74g517EGTKRAFe3r+rSQu1is5RIOtTEHyiGGZJUAfvN+dCIl6uiA2Tc0SC/KzGwUkXff
	upZ5bRCgPFfDdNoA/viAiRXJwMwgt/YdiRLfcnqZVtDoAQRYxTpCQ6kutnl6u1UOTvUPFZeo9fFlb
	5ZFTaz0S3lEQuf5jejLrm4h8O4BVgY0HfaZoy1Z/848FfVBWH9vKJQwsvcx6nlyrG3rqBuMQX6S0T
	Wf1D9ZNZg6xnJ+cRlgd9ZXguStfDAiXMIoL7NiI1GJLro6GHTiYNm43odMmlj18yLvJq+CoyB2EJS
	0ewwnbi12Gbv+90KFvNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwwc-00072F-T6; Tue, 05 Feb 2019 09:23:06 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwwa-000727-6f
 for linux-arm-kernel@bombadil.infradead.org; Tue, 05 Feb 2019 09:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ibwc9w+bPMoLLGGAf8748K/x4LzwNL3moCb9zIc0th8=; b=Q2m/B2UAuj4t6AcCQHXNX5wHR
 anYsqzl+OJyEO+PvAxNbTyYu7ROVEcW+2bA6WXksmwffZyo/hI9Fn4rkutOzPYrrk3zNo/tI6Lmq6
 HGIeS/Qudr+6ura0se7OTePh6p7Y0cAB5q9MtTSDu6GUkoXHMkhxvRX3ihBKNXOkD/TiG/tplINGn
 oKta3x0SMyt/IXLn/opX3ia/HPvphmR9e+NJbPf3UmuYybTQ7VqIHMloKddKomQcqHoDgzTItsnGT
 QflkjbJtZqZye85BH+qH/8tZHY+zou/K443aY18TmJphTGnfY/4jUEq46jwB1IzJzSiIDTK3wJpZX
 /OwvKSNYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwwT-0002Rr-Ng; Tue, 05 Feb 2019 09:22:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3382E2029FA06; Tue,  5 Feb 2019 10:22:56 +0100 (CET)
Date: Tue, 5 Feb 2019 10:22:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
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
 longman@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
> 
> > On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> >> Choose the next lock holder among spinning threads running on the same
> >> socket with high probability rather than always. With small probability,
> >> hand the lock to the first thread in the secondary queue or, if that
> >> queue is empty, to the immediate successor of the current lock holder
> >> in the main queue.  Thus, assuming no failures while threads hold the
> >> lock, every thread would be able to acquire the lock after a bounded
> >> number of lock transitions, with high probability.
> >> 
> >> Note that we could make the inter-socket transition deterministic,
> >> by sticking a counter of intra-socket transitions in the head node
> >> of the secondary queue. At the handoff time, we could increment
> >> the counter and check if it is below a threshold. This adds another
> >> field to queue nodes and nearly-certain local cache miss to read and
> >> update this counter during the handoff. While still beating stock,
> >> this variant adds certain overhead over the probabilistic variant.
> > 
> > (also heavily suffers from the socket == node confusion)
> > 
> > How would you suggest RT 'tunes' this?
> > 
> > RT relies on FIFO fairness of the basic spinlock primitives; you just
> > completely wrecked that.
> 
> This is true that CNA trades some fairness for shorter lock handover
> latency, much like any other NUMA-aware lock.
> 
> Can you explain, however, what exactly breaks here?

Timeliness guarantees. FIFO-fair has well defined time behaviour; you
know exactly how long you get to wait before you acquire the lock,
namely however many waiters are in front of you multiplied by the worst
case wait time.

Doing time analysis on a randomized algorithm isn't my idea of fun.

> It seems that even today, qspinlock does not support RT_PREEMPT, given
> that it uses per-CPU queue nodes.

It does work with RT, commit:

  7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")

it a direct result of RT observing funnies with it. I've no idea why you
think it would not work.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
