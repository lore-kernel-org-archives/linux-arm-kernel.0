Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98360C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:15:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CD52173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IriRe0ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD52173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GAokUaG8flmhDgjD89asQ9aWKAuayJQsF4AAYpLsC8s=; b=IriRe0aitv4w6U
	0b3TmjI87NG1TQGFAcGa4g8FmuSmmsxNG7wGmGUkvxOWXENZGZFVhEnE7YZA0AoqnihOyx94z0MPy
	HJc9G+x4fyTcNYX32Zed2ZfAEPZqmOu/a6Qu+sl3QHoLHqTc1uosJC7OuOkZjbwnQuzVb4hOypFZr
	BOq1uKpfwuP2S4k/1k2dj+x9118MuILObFARB97FuZ2qNAxCP4d32nNCipWmN7APVWuST3f+0hOaI
	s5LlwArrQISkn+81CXjMswIbe2iS0FKWh5mRxCbthrf38Lm5qkes+n5aaBhu5jZKyiH1KDU/VYr0T
	KvSoUiL3G0j1RrD6LOWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaBF-0007B3-M2; Thu, 10 Jan 2019 13:15:29 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaBB-0006vp-Dx
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:15:28 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43b61H3QY0z9sLt;
 Fri, 11 Jan 2019 00:15:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>,
 Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
In-Reply-To: <20190108104841.GD6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
 <20190108104841.GD6808@hirez.programming.kicks-ass.net>
Date: Fri, 11 Jan 2019 00:15:13 +1100
Message-ID: <87ef9kslge.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_051525_738495_55FF41CB 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, boris.ostrovsky@oracle.com,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 jgross@suse.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jan 07, 2019 at 04:27:27PM +0000, Andrew Murray wrote:
>> For drivers that do not support context exclusion let's advertise the
>> PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
>> prevent us from handling events where any exclusion flags are set.
>> Let's also remove the now unnecessary check for exclusion flags.
>> 
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> ---
>>  arch/x86/events/amd/ibs.c          | 13 +------------
>>  arch/x86/events/amd/power.c        | 10 ++--------
>>  arch/x86/events/intel/cstate.c     | 12 +++---------
>>  arch/x86/events/intel/rapl.c       |  9 ++-------
>>  arch/x86/events/intel/uncore_snb.c |  9 ++-------
>>  arch/x86/events/msr.c              | 10 ++--------
>>  6 files changed, 12 insertions(+), 51 deletions(-)
>
> You (correctly) don't add CAP_NO_EXCLUDE to the main x86 pmu code, but
> then you also don't check if it handles all the various exclude options
> correctly/consistently.
>
> Now; I must admit that that is a bit of a maze, but I think we can at
> least add exclude_idle and exclude_hv fails in there, nothing uses those
> afaict.
>
> On the various exclude options; they are as follows (IIUC):
>
>   - exclude_guest: we're a HV/host-kernel and we don't want the counter
>                    to run when we run a guest context.
>
>   - exclude_host: we're a HV/host-kernel and we don't want the counter
>                   to run when we run in host context.
>
>   - exclude_hv: we're a guest and don't want the counter to run in HV
>                 context.
>
> Now, KVM always implies exclude_hv afaict (for guests)

On Power it mostly does.

There's some host code that can run in real mode (MMU off) and therefore
doesn't do a full context switch out of the guest (including the PMU),
so that's host code that is running while the guest PMCs are still
counting.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
