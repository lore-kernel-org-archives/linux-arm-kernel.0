Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE3420835
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhDym52Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xdhUPs7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE3420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uq9MQv7ORV0v3f5p2+nM67iBX12RqMZiD+jDqng8xGU=; b=LhDym52YqDBZlp
	0dPOtol/oymVrLvO6UKF30RD8mkzzHbuJD4kdRVjyDh2v+B56+m8D92Ao0/fQnvYEKh9BIGKZLDN/
	oed4+aC+EOcKkHDZu3dGT2CCeJ62meJTXbTdCdVyJAp1YXOqbbWkoHl7tt0yHijbxzim62R1TKWnE
	jwJFcVinrS/slstkeqYitsoDVNwWIL8R3mSL0DhxQtCMD9xjld7a11hUYM047y0IogA7hIehE1AMj
	26WLcSkyHEzD4Cz75i9IbN8GzfhkuL46PwtaPGlO8UYk9uEmnUAUMg0j7aGaHBKW1MTgMN4/1NVwg
	FdDLN/3qk3sxNuzrOptw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvjT-00037d-1t; Wed, 13 Feb 2019 14:41:51 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvjR-00037S-Vf
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 14:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3JP2GdTiAJ526PELugmb3v1C6bIiy8gmFfL58iiErCU=; b=xdhUPs7Iyr/vSY7m+db8oxPzX
 +yipFrB5C+VhgBqUOjq9R/LQMRnWuJF6gBG8coXNnqDeTY5f9J9HeHnVzkbOLdwalBEL9T7BpSKN5
 IbXmceHC44m06bFpI36Tnib1pXBn1aoE6mzPelIgQtr2DcHs7zu4V6Ps6hOvEZXJgf1ru+3hcMNra
 HEK6QeaRWZMqprcWAQgI2W7KU99BIfQqcbaWQ4UB6dtx/S6nOESoES5wCy4g2EWlJKE7gMhx+2CWa
 qkcBGOC4swKvqTh4JiNoWFgq3zL4HtpbJREsq9ZLN3wjw4Zo15s5iQ1hRrrpaBqQOSeB+fb6mmM+A
 SXtTm44Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvjO-0001MW-Bw; Wed, 13 Feb 2019 14:41:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2307C20D0C1E6; Wed, 13 Feb 2019 15:41:45 +0100 (CET)
Date: Wed, 13 Feb 2019 15:41:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
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
Cc: catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 02:39:22PM +0000, Julien Thierry wrote:
> Hi Peter,
> 
> On 13/02/2019 14:25, Peter Zijlstra wrote:
> > On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> >> The difference is because getting preempted in the sequence above is
> >> triggered off the back of an interrupt. On arm64, and I think also on x86,
> >> the user access state (SMAP or PAN) is saved and restored across exceptions
> >> but not across context switch.
> > 
> > A quick reading of the SDM seems to suggest the SMAP state is part of
> > EFLAGS, which is context switched just fine AFAIK.
> > 
> I fail to see where this is happening when looking at the switch_to()
> logic in x86_64.

Yeah, me too.. we obviously preserve EFLAGS for user context, but for
kernel-kernel switches we do not seem to preserve it :-(


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
