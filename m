Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59174C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284D1206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u+gjmXF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284D1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZgmbKUqNWa7CSR+P/MlN3MW3vqL2lZ7f2v/MDnPAVVs=; b=u+gjmXF3zIm2bv
	8eoEINClexcbTLO4EHRLRzMTQN4SZWk1rji+lwsV/myYXHCTdGTY7/St34cOkVIUOK05P6zj6/V/6
	HtcglurbRcIjwGy4NF5yceeRqWuoclA0QfQBcM2IVyUazHE2cE/LBTCKxLiMKdSfzytDSO9FZwv4j
	FiGBJWrx3q6fMBFu8WhgJAZ3BzbBJMO8wkz7BcVrRF0pAN+pEkcu3PmKMm1YBteIIgKGlalj5tvYG
	RJ3Lj19OHfR4wR5RaxNqUg2hKsX3m+ByhXXIIcNnFQYQu+0lF+e1atwyn/8S7gqwatxhs5MiExS+Z
	ZROverRlUn1t5dTU0OLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsbk-0002GX-5e; Tue, 08 Jan 2019 14:43:56 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsbg-0002GI-T3; Tue, 08 Jan 2019 14:43:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id F04AB20297BAD; Tue,  8 Jan 2019 15:43:50 +0100 (CET)
Date: Tue, 8 Jan 2019 15:43:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v4 05/13] arm: perf: conditionally use
 PERF_PMU_CAP_NO_EXCLUDE
Message-ID: <20190108144350.GA30894@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
 <20190108102802.GC6808@hirez.programming.kicks-ass.net>
 <20190108130740.GC56789@e119886-lin.cambridge.arm.com>
 <20190108131031.GG6808@hirez.programming.kicks-ass.net>
 <20190108131357.GF56789@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108131357.GF56789@e119886-lin.cambridge.arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Shawn Guo <shawnguo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 01:13:57PM +0000, Andrew Murray wrote:
> On Tue, Jan 08, 2019 at 02:10:31PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 08, 2019 at 01:07:41PM +0000, Andrew Murray wrote:
> > 
> > > Yes I found lots of examples like this across the tree whilst doing this
> > > work. However I decided to initially start with simply removing duplicated
> > > code as a result of adding this flag and attempting to preserve existing
> > > functionality. I thought that if I add missing checks then the patchset
> > > will get much bigger and be harder to merge. I would like to do this though
> > > as another non-cross-arch series.
> > > 
> > > Can we limit this patch series to the minimal changes required to fully
> > > use PERF_PMU_CAP_NO_EXCLUDE and then attempt to fix these existing problems
> > > in subsequent patch sets?
> > 
> > Ok, but it would've been nice to see that mentioned somewhere.
> 
> I'll update the cover leter on any next revision. I'll try to be clearer next
> time with my intentions.

Could you maybe include it in the relevant patches too; like for example
the ARM one where we rely on set_event_filter() to DTRT.

So with the changelogs and subjects fixed I can take these patches and
then you can get on with cleaning up the individual drivers.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
