Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE170C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:08:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5472190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="siJu+3J7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cf+TYhiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5472190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=67dHQhs4KCGtXEccJTjlo3mQIBqVjqOezRoS9dNUAvY=; b=siJu+3J7vvBBnU
	3lfMgJGPgJ0wmhb3oPC1hseFNXkqq1gM3MpSRUlWUR85iMnLCKO0fdEmFI8W3XFvhsiK9BucagCpK
	6dxCmqtQhEcdCkcR4Z+FNlgQNNigk7ggqCtK62wzAUmw7pTfp80epVPkSCYh6sLgpWONTJAYGGp/D
	Bh9j3E8+0eNu91l3ERONPrpondZVOMGQU7nZgE33b+3vncE2L4BCpljwWoq2f5arNrnR+Up9+ygyl
	XgCYNmJLiJ/Nq7hg/KH2ugvONumSoHBcC86tnTWC0ISpzqK2vl0NX/ZdiYQj45C3hRpnXfkMGj/hd
	kWgAbsHsYMZPDXnI16Mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtw9B-0005FV-03; Wed, 13 Feb 2019 15:08:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtw99-0005Ey-Sq
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 15:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6Hjpqy7xmesO0Qjschsa/xWQvFbbpkd+0q/JbfvpyM=; b=Cf+TYhiF/Eohq3X9KPtkgIaIM
 15uhPMT0CtY+DXgu9tJnhvaqN07D7HiZZkICnydqBMpn5Q7SGBNh+sGKrk8y2jzT/c3QhzLgd3ctQ
 UPN4DBS0FAoG/qzy12UpoY9nTCnd8cTZaGl/4NXS5W+pOQqL/uIWXnCUbWWH+NVNn3V478RTibx8u
 gWtDzuuWQSt7uzEXaOYd1D05AlF3KYVqWhvqYXfQDYcNMw9vMip2Ny/PEb345zlRzWMWEWCLSKqSM
 Ou02S3BDAOaC54tAKIPKbRsDHImaxX3RmNvLgyq3RQwpXxcLFN/+TPPhN0Y5m7qE+ZPCFm7gOJawK
 EnENDn9Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtw97-0001mY-7j; Wed, 13 Feb 2019 15:08:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AD4EA202CEF73; Wed, 13 Feb 2019 16:08:19 +0100 (CET)
Date: Wed, 13 Feb 2019 16:08:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213150819.GP32534@hirez.programming.kicks-ass.net>
References: <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
 <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
 <20190213144000.GX32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213144000.GX32494@hirez.programming.kicks-ass.net>
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

On Wed, Feb 13, 2019 at 03:40:00PM +0100, Peter Zijlstra wrote:

> So far, all 6 in-tree users are indeed free of dodgy code, but *groan*.

because of this, there must also not be tracepoints (even implicit ones
like function-trace) between user_access_{begin,end}().

And while that is unlikely with the current code; it is not guaranteed
afaict.

What a ff'ing mess.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
