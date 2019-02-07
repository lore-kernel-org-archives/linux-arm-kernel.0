Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C522C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC76218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8EXdL6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC76218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WdhH+sOKqqAa0bK1oPkEN+TTeBMZh+/wOrR0PdwYmiU=; b=I8EXdL6hJgZ0FZ
	aEeeBFw4BVtJg1uDwbQ4f4IdOxH7hDkOconPW+apNYp3jkrtUqD+68BJ3Q8V7TbhpHe0cet8qNXI1
	JfquwSOLa7lrTcHL8a0BOeJVPjFR2dnQFKzS0FRmTSylhmbIIkGytHLgFKoOXognAY6NbxNOO60I4
	9CswLvpz3nBUx3yAioBCgW4ArD8z6WU5p4G2FIkjeTyCB57VJXgIXTCgeCIMO88qJA97zX6h0t9gi
	jRufPIjdkhJfI42alzqnAB8hpFuFOKN7U/xGeC0TPZxjpaWv1mFkgKI4RVVsiHYPS1KwBQHmIgvIq
	8NLPASSG6so7GNSd1itQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlxr-0005UT-Ta; Thu, 07 Feb 2019 15:51:47 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlxp-0005U6-9O
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:51:46 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id E8D298126;
 Thu,  7 Feb 2019 15:51:51 +0000 (UTC)
Date: Thu, 7 Feb 2019 07:51:39 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Message-ID: <20190207155139.GC5720@atomide.com>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
 <20181212175332.GI6707@atomide.com>
 <20181212185741.GJ6707@atomide.com>
 <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207134548.43yyk3wsadwvcmd6@shell.armlinux.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_075145_364718_9054A0F3 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King - ARM Linux admin <linux@armlinux.org.uk> [190207 13:46]:
> On Wed, Dec 12, 2018 at 10:57:41AM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [181212 17:53]:
> > > * Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> > > > We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> > > > would expect would take care of the issue, but internally this only
> > > > deals with one-shot local timers - tick_broadcast_enable() on the other
> > > > hand only deals with periodic local timers.  So, we need to call both.
> > > 
> > > This works just fine for me for NO_HZ and cpuidle:
> > >
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > And also works for me without NO_HZ too FYI.
> 
> Hi Tony,
> 
> Could you pick this patch up and submit for 5.0-rc please?

Oh sorry. I thought you had already merged it since I added
my Tested-by. Hmm I guess I need to start adding also an
Acked-by to signal it's OK to pick some misc patches.

Anyways, applying into omap-for-v5.0/fixes-v2.

Thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
