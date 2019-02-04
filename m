Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA50C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:12:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB752082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CNbvxvtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O6xTBadxTd5+pmzaFStjdm5sXhcv7zxx1aCXpSicA4c=; b=CNbvxvtnmSfYmA
	cJO6mPeJ3YA7InE12r6RH9j8ApX0o/l13MPucwqNP0/vnG+JVWjc0tVJsyXO1tiJS1MdMJudEkQAy
	/wd8sCduZJaxyoxsAy/7pqELPw3AM61ByHMAER7Xyg711AH7oTmhzXoxwq7tAw0NhJaxlxctklgBi
	ev5bQlsZfKiulSYTYC5VWwafdVvkZzjPUVzZlq6CVNXyMHVZoIkaw/FzwvgRJdSDOY/2GMbOYn55N
	jZTHqQgELeMX3LNaX87WW6EVuYStvK1yloY9sW9STA3Z6tSckPuLxC7n2W6JB+8j83fIkq/TaDAV7
	aCiBmLUHjl+bkWXT/6ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqe3Q-00065b-4x; Mon, 04 Feb 2019 13:12:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqe3L-00065I-MU
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:12:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F7515AB;
 Mon,  4 Feb 2019 05:12:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D87853F557;
 Mon,  4 Feb 2019 05:12:43 -0800 (PST)
Date: Mon, 4 Feb 2019 13:12:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
Message-ID: <20190204131241.GB46085@lakrids.cambridge.arm.com>
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_051247_906412_CC0E24C0 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> Hi,

Hi Doug,

> I was wondering if anyone out there has given any thought to
> annotating the ARM64 IRQ handling in such a way that we could stack
> crawl past el1_irq() when in gdb.
> 
> I spent a bit of time on this a few months ago and documented all my
> findings in:
> 
> https://bugs.chromium.org/p/chromium/issues/detail?id=908721

There, the error from GDB is:

    Backtrace stopped: previous frame identical to this frame (corrupt
    stack?)

... is that misleading?

... or do we have some duplicate stack frame that we somewhow skip in
the kernel unwinder?

> I can copy and paste all the discussion from that bug here, but since
> it's public hopefully folks can read the discussion / investigation
> there.  To put it briefly, though: I can stack crawl past "el1_irq"
> with the normal linux stack crawl (which is what kdb uses) but I can't
> crawl past "el1_irq" in gdb().  After talking to some of our tools
> guys here I'm fairly certain that we could solve this with the right
> CFI directives, but when I poked at it I wasn't able to figure out the
> magic.

AFAICT, we don't know why GDB is terminating early. Could we please
figure that out first? e.g. by looking for the above message in the GDB
sources.

If we do need CFI annotations, I'd rather move that entry code to C
first, to minimize how painful that is. I have an ongoing project [1] to
do just that...

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
