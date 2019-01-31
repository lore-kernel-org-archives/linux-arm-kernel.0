Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432FEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1849A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PT8zYPOw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PiwQJUBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1849A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dbK9DmCUQZQORGPI0guAZuTGy9UC1BtPiPjzpQm6Ng=; b=PT8zYPOwbQa+um
	is4G9bY3VjWPW4qi1e/prQrP6AKGzC+3+uSxv10yKdc9Bxu6/9HvEzr4tCMXZgBCLr8mbhV3Swbpc
	YbRdjFXeL9yvp6CDa2iv3Bdi3v7p2MPggO7y4/Jvt6NDH7DdNYEdG+KBcEk4n3bmv2pDe785M3ajE
	i5jfKAgaG08yMksXMOWFzBVxPHbAi9pm0E79hMingK/xUr6SCLu19sxI6MpFZTxKVnYB/FiRBkRHS
	IuHD2OVyZbjHP0z4cfY1tInMznHWFaTHNnzdjjgHAkrPYChtj5t5ZJzzEwZVShyKXxu9xmpdGxKDJ
	v6QoonYwFn9wn+LpA3Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCrC-0002Nx-Qo; Thu, 31 Jan 2019 13:58:18 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqo-0002L9-3b
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TgAh6DNIJOhw+KV6qjOVyyZ8L7qw7KCQ05UFHX+6M78=; b=PiwQJUBLq1yo5fgBnUtCczTRO
 eKTziu4U4Qli9wQ1CJ+2ZDZwQWJxbo5pENHvRclUxU+bL4ettGxI8Ouoy8ZhL59kQAiIFsLSEb7Xr
 NMZ4/y6WRBtBFyh+VzovmdrhoiU/l1fHscBs6oIUm7gYTNqWVG8o6mLrFuRdur66+PhamMCyM0sN6
 C5LfgpnFnw8t0WJ1RsXTu9pOVriQT9LU8Jpih96Ew1Q01mFhTcnwWoI02z3KsDpCaR4Sip3dGP14P
 N2IkhDtGKCkI6fzg92LouiZ7nUg4X7VMhjnpAd4pC6YkEFRGOCRxlT2Z2fZODVmml4Qy8CLaDf8wT
 QgbTmA2ww==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCql-0006ZH-B4
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:57:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B1BA78;
 Thu, 31 Jan 2019 05:57:47 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EAAA3F589;
 Thu, 31 Jan 2019 05:57:46 -0800 (PST)
Date: Thu, 31 Jan 2019 13:57:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] arm64: dump: no need to check return value of
 debugfs_create functions
Message-ID: <20190131135744.GB21965@fuggles.cambridge.arm.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-2-gregkh@linuxfoundation.org>
 <20190130182102.GK18558@fuggles.cambridge.arm.com>
 <20190130193348.GC20667@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130193348.GC20667@kroah.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_085751_466887_CC283F8C 
X-CRM114-Status: GOOD (  19.43  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, Peng Donglin <dolinux.peng@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 08:33:48PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 30, 2019 at 06:21:02PM +0000, Will Deacon wrote:
> > Hi Greg,
> > 
> > On Tue, Jan 22, 2019 at 03:41:11PM +0100, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Peng Donglin <dolinux.peng@gmail.com>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  arch/arm64/include/asm/ptdump.h | 9 +++------
> > >  arch/arm64/mm/dump.c            | 4 ++--
> > >  arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
> > >  3 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > Are you taking this via your tree, or would you like us to queue it in
> > arm64?
> 
> What ever is easiest for you is fine with me, I can handle it either
> way, just let me know.

It's easy enough for us to merge the arm64 bits, so we'll pick that up for
5.1.

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
