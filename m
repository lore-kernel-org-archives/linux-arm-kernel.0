Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6919121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIMgyVN8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0w7whLyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6919121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qF0FdnLU8G+ms5Jg/SIkItIKFvRwkc9lSwyw+D5pgnc=; b=NIMgyVN8DK6cMU
	/m2SYlj5T5EGaku3Ui9Pbf6MGC/iudj1lvv6wIwStDAAcyXJVxlHqkqAN8TXKkxkyuvDkpAVAmkjC
	12Vt0syxHupDbD+HNH8CjvuDl3cZXuur8M7ReyBfo3EFYuNSCSSzHNlII0rE+7wvpkLF35hM6QOUp
	CoYlKrrSy75jUupNW0yAbOrSYPuuzk6WiB1DMd6YxBUd34jMauZBobgPAqO4RhffXRm2Vh2xHi8yK
	1pIc9UV0dZwogzfuKbK8pwtAubRVh25MRuPkUMEFknanuCSx1KBGtAqcvIukeYS+sHM9ow09z7du3
	Dqv1YIPoTmZj9AlgLkfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1iW-0004gI-4h; Mon, 17 Dec 2018 22:50:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1iU-0004g1-7x
 for linux-arm-kernel@bombadil.infradead.org; Mon, 17 Dec 2018 22:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ewyNVfIQur5dYaPnBPCaCuzQ2dHgrMZzNkkb6MCSIxQ=; b=0w7whLyppnyCzu1paF1B2/tuq
 sA9+Sqikd5vWwFnDWR6iTSlLQwO3xClbfLeViWsViFel2HtWeFUbdkX+OdTSFBheWaGf6Wcg55qEI
 sq0Zr/ofhEJFTzkK+YpAv+fBZeYpXomyffG+Q6exz9k4Ywysh7gCYvzt5og9mtSjaULwsWmO7BOFZ
 ZIKvC7KwbHy8SmI2maS7J3M/YopkkNB5wbJ00NUzc64FV3FMTb6yB8DKCsfx74T9cRxKvXy8AvzEB
 0LF/RBXArU814VKuP6Vdy07oQkmeQccHkrTRBKoh18/2DEJQ0BDsQgTgjOIJUiNZr1e0KTFbfCYLZ
 CTCKHm87Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1iP-0004LK-8x; Mon, 17 Dec 2018 22:50:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 16A9F20276AAC; Mon, 17 Dec 2018 23:50:20 +0100 (CET)
Date: Mon, 17 Dec 2018 23:50:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181217225020.GA16520@hirez.programming.kicks-ass.net>
References: <20180220215954.4092811-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
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
Cc: Andi Kleen <ak@linux.intel.com>, Nicolas Pitre <nico@linaro.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 20, 2018 at 10:59:47PM +0100, Arnd Bergmann wrote:
> Hi Nico, all,
> 
> I was playing with ARM link-time optimization handling earlier this
> month, and eventually got it to build cleanly with randconfig kernels,
> but ended up with a lot of ugly hacks to actually pull it off.

How are we dealing with the fact that LTO can break RCU in very subtle
and scary ways?

Do we have a compiler guy on board that has given us a compiler switch
that kills that optimization (and thereby guarantees that behaviour for
future compilers etc..) ?

Also see the thread here:

  https://lkml.kernel.org/r/20171116115810.GH9361@arm.com

(and yes, this is a fine example of how lore sucks for reading email)



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
