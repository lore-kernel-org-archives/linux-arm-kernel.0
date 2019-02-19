Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21653C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:44:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D930D2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hsC+8Lmz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ky8ytGJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D930D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zLD59Q8UMdiuMGyGexTPExKf6wlFhYJoQpatITAFJ0k=; b=hsC+8LmzuhCuSk
	IOdcyWe6zi7gRZBjgkbjc1nUhqqha3IWHAv7rW1GQmq5khiyPPXUnIrlCnUOtQlFALH2gf4WAtvPB
	bdCntCxl8PMLKYxSrBPPUVog9wLzdq6koUscAGQyyEOPw44hn/hRO6eCmDAm2+XCwJ87i7hx7ZLIw
	BXe/pv6ro9dSV5QN9VryppNrhm9fQskBAt7/1nT6e84nQM8L1Ov8SqTKWvuNppcB5IVHztyluJny0
	SlnNMPbRExIgIMj1uRd2u3zbNTRWr/dog61MXeU+gAPvwEjfLPqSa9J6jixn3ukNr/OvMSo11bfxT
	42ng4ouXi0ranmVo7hzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1xI-0003uo-IW; Tue, 19 Feb 2019 09:44:48 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1xG-0003uW-Np
 for linux-arm-kernel@bombadil.infradead.org; Tue, 19 Feb 2019 09:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BSKboyCAOkwlTQlKVtpuNo+zZmTvDQywmdcs6fHkXqM=; b=ky8ytGJOQ04HHG8DhPq+zcPu4
 sa6f0/O8OTIaEJ0B5ryEF+9jsjEetVerBJeHnW+nL+jC1g5ZGd6lA+xmXVwPFQPrmM/dtGtJi17iY
 RqyTToWoJNxrssViqpibcJLFJbohBjqeCOxOpzKooJlr6Wfp1RjrOk4dLxV3zw+ew3FsHpit1dv5h
 WYxd/P1VpAuVIvSNzp2Bw2XM7i57Y1CYbTumuQ4Ad2oj1+Pwndw2lq6jllr9IoQH44GW3eXETsgLb
 pjguJ02CbPrSN9yEeq6/AaRWShX9fG/WG+lPzuo8Ye0/PMDstZBT3lUs8zNEiDKbMY9tR1+rOL+qm
 orgUlOptA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1xB-0008TD-VJ; Tue, 19 Feb 2019 09:44:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 03AD4285202CC; Tue, 19 Feb 2019 10:44:39 +0100 (CET)
Date: Tue, 19 Feb 2019 10:44:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219094438.GV32534@hirez.programming.kicks-ass.net>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190219090409.GW32494@hirez.programming.kicks-ass.net>
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
Cc: dvlasenk@redhat.com, jpoimboe@redhat.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org, brgerst@gmail.com,
 bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 10:04:09AM +0100, Peter Zijlstra wrote:
> > Does that make more sense?
> 
> It appears to me you're going about it backwards.

So how about you do a GCC plugin that verifies limits on code-gen
between user_access_begin/user_access_end() ?

 - No CALL/RET
   - implies user_access_end() happens
   - implies no fentry hooks
 - No __preempt_count frobbing
 - No tracepoints
 - ...

That way you put the burden on the special code, not on the rest of the
kernel.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
