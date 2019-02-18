Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B60206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z46si9Ge";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUmN5Ppr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B60206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MzHvInfm8FTtnPMCSGUEAlLNZQVT4944q1vyzeebX5k=; b=Z46si9GerdUSp4
	ih1bZNon6PfMfvhXXnqV86XeJpNcWfci2bc2XNN/JlmJaj8HnCzc7j3dwwqBTqydp/P1rtotX23Lf
	jMoNHNNvZ6nSrkVNyN1niXLBCTK0OfB544zwkrLLQUDlRV88n6849u2sn9EJR4I8umK1FR5T69RnQ
	EBXNUgEG1PkF7mf38WAIoxU/7eJ0v+AOcnGCb2ss6XxU1gzaaCds2h3A2aQR/NJCDREWmozzPbhrt
	INjjJY+3MfYMJp1ZtI3mcKOBHd7XzBMG3qZ8asY+oV2OADYvqbMXJhARjGqQ8y/8HE5uZTM+5mnBi
	wYGiQVBMOB29WGukVmkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviQU-0000Qp-0s; Mon, 18 Feb 2019 12:53:38 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviQS-0000Qf-5D
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 12:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o9duW35qkVBByBckeYSVEKqqj00p/T7Hi5MwdEAEhQc=; b=UUmN5PprHGZoQhOVHvZZxxJb6
 hHw50LSLCBROSQL9dckvU4QK0G/XtpZkGlOE+IrG+Y3MjB8IcVVJNHqDu2HdKKRDJA+2dmdwNvo15
 QwQpbpiQ16sHm+WUw5EUSP0G9AE4KToH8ivrK8ZBdcvtxBcc+HLCzZHeDamtsfBX8gS0Em6FACMYx
 68vR6PCWS0O5qe7x/LTU2hEqxCztkwJImv7YffHR/lCLtRvtVOd2imCaEFcFFI+1zU3HPd7ZVlQsK
 POL7d7amdHmnvg8t+qHVMR96ym+N+D/NMxmBIr0C85eSdoo2UoOIgwOv7pgu8BDdKkFfUU4Ns+nfL
 vsFqBi97Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviQL-0006Mc-Hs; Mon, 18 Feb 2019 12:53:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0F9C9286A33C8; Mon, 18 Feb 2019 13:53:27 +0100 (CET)
Date: Mon, 18 Feb 2019 13:53:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190218125327.GT32494@hirez.programming.kicks-ass.net>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218111421.GC8036@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218111421.GC8036@lakrids.cambridge.arm.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Price <Steven.Price@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <James.Morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 11:14:23AM +0000, Mark Rutland wrote:
> > +#ifndef pgd_large
> > +#define pgd_large(x)0
> > +#endif
> > +#ifndef pud_large
> > +#define pud_large(x)0
> > +#endif
> > +#ifndef pmd_large
> > +#define pmd_large(x)0
> > +#endif
> 
> It might be worth a comment defining the semantics of these, e.g. how
> they differ from p?d_huge() and p?d_trans_huge().

Yes; I took it to mean any large page mapping, so it would explicitly
include huge and thp.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
