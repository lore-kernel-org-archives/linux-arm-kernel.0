Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E562082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWhix1aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E562082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqQ4xe+vmHvtOKTXMMlbxE43sVAsyhoQRiBMC1yAtPM=; b=pWhix1aT/lAj1v
	D4FWiiCHgA8CQhkXiBKmcBsT3OwmW3T3e6i1ItUV+Y2jXMYVhfZrDth5T732NP82/iN2ur+yi19R1
	2KUytDuPilngCVJVRk/aj2ggCgTtAqNYkoOXPcStzWApUXSbO0p8VIW+9V5DZglicixF/gr2ODknU
	qHYyYkZttHwOyR6lReWY6UPqUvSfqCAvpDSu0FcxZsXJ6pPQ9SzJ+eStEz3SOM3lLltMlviJEHsFI
	k8JyFYlOXrYqC6rkQoRW53pUfJUhXluGKo3U6/Syq3ROwHQPJM4onyATspcHz3U3OFtPyHGVC6alN
	Kfg+Mm79dlzLGlyw0F5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqdPZ-0001MI-MT; Mon, 04 Feb 2019 12:31:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqdPW-0001Lw-Uz
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 12:31:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA9B815AB;
 Mon,  4 Feb 2019 04:31:36 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2733F675;
 Mon,  4 Feb 2019 04:31:35 -0800 (PST)
Date: Mon, 4 Feb 2019 12:31:33 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
Message-ID: <20190204123130.GE3567@e103592.cambridge.arm.com>
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_043138_999708_6E496429 
X-CRM114-Status: GOOD (  18.03  )
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
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> Hi,
> 
> I was wondering if anyone out there has given any thought to
> annotating the ARM64 IRQ handling in such a way that we could stack
> crawl past el1_irq() when in gdb.
> 
> I spent a bit of time on this a few months ago and documented all my
> findings in:
> 
> https://bugs.chromium.org/p/chromium/issues/detail?id=908721
> 
> I can copy and paste all the discussion from that bug here, but since
> it's public hopefully folks can read the discussion / investigation
> there.  To put it briefly, though: I can stack crawl past "el1_irq"
> with the normal linux stack crawl (which is what kdb uses) but I can't
> crawl past "el1_irq" in gdb().  After talking to some of our tools
> guys here I'm fairly certain that we could solve this with the right
> CFI directives, but when I poked at it I wasn't able to figure out the
> magic.
> 
> 
> Anyway, I figured I'd check to see if anyone here happens to know the
> right magic.

The kernel (appears to) generate a valid frame record for el1_irq:

   0xffffff8008082b94 <+84>:    mrs     x22, elr_el1

	[...]

   0xffffff8008082ba0 <+96>:    stp     x29, x22, [sp, #304]
   0xffffff8008082ba4 <+100>:   add     x29, sp, #0x130

(I note that 0x130 == 304.  Yay binutils.)


From the bug report, I don't see any real investigation into what
precisely causes gdb to choke on this frame.

Do you have evidence that CFI annotations help in this case?  And can
you explain _why_ they help (i.e., precisely how is gdb relying on the
annotations)?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
