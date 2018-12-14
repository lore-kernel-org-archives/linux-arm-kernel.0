Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E55C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83805206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y0hf2yeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83805206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fT3GoBomeR4yrKVrfw2PrhgHyihy+KgiRL/MuiQuyho=; b=Y0hf2yeZt7K1v5
	+2MIACTOO6QpZ9AStxEZLet0fCJihqQivqDCTHNxomCd0QIcgdzSi+xQvZBrivRmxzNSvfkn8U7HI
	qRCdMwlQRUH7vqDRQ00zIb6GAL+55h2J8WSOujeLuOALVBAG31TNDZKgnP2c8bxs1Yexj3hf9I1XO
	qStNnSp8q4GxhmUYF7He6jfP/Tr4s5sBavFpa1MQgxEiyk8sOLPKiV/gsXEpBa/1NC5kAKLnXn8TT
	eS9L4pdLEY1LUnyyTJSrbFmTt3a/iNvnil3I++5bv/QBggK9QSDmIwOARp2Pi1SQZBkfkd1WkvnrG
	au8oZ5yNAfSmIIEZ+VuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXs9b-0004bc-JI; Fri, 14 Dec 2018 18:25:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXs9X-0004af-C2
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 18:25:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50698EBD;
 Fri, 14 Dec 2018 10:25:22 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1483F575;
 Fri, 14 Dec 2018 10:25:20 -0800 (PST)
Date: Fri, 14 Dec 2018 18:25:18 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Message-ID: <20181214182518.GH3505@e103592.cambridge.arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
 <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_102535_413647_D7B4A95E 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: nd <nd@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Alan Hayward <Alan.Hayward@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 06:13:33PM +0000, Szabolcs Nagy wrote:
> On 11/12/2018 19:26, Dave Martin wrote:
> > This patch refactors the UAPI header definitions for the Arm SVE
> > extension to avoid multiple-definition problems when userspace mixes its
> > own sigcontext.h definitions with the kernel's ptrace.h (which is
> > apparently routine).
> > 
> > A common backend header is created to hold common definitions, suitably
> > namespaced, and with an appropriate header guard.
> > 
> > See the commit message in patch 3 for further explanation of why this
> > is needed.
> > 
> > Because of the non-trivial header guard in the new sve_context.h, patch
> > 1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) in
> > a similar way to the current handling of #ifndef _UAPI_FOO.
> > 
> 
> thanks for doing this.
> 
> the patches fix the gdb build issue on musl libc with an
> additional gdb patch:
> https://sourceware.org/ml/gdb-patches/2018-12/msg00152.html
> (in userspace i'd expect users relying on signal.h providing
> whatever is in asm/sigcontext.h.)
> 
> i think sve_context.h could be made to work with direct include,
> even if that's not useful because there is no public api there.
> (and then you dont need the first patch)

My general view is that if you want the sigframe types userspace should
usually include <ucontext.h> and refer to mcontext_t.

Because the prototype for sa_sigaction() specifies a void * for the
ucontext argument, I've generally assumed that <signal.h> is not
sufficient to get ucontext_t (or mcontext_t) (but maybe I'm too paranoid
there).

Non-POSIX-flavoured software might include <asm/sigcontext.h> directly.
In glibc/musl libc will that conflict with <signal.h>, or can the two
coexist?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
