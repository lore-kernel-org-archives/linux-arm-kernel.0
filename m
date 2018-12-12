Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9326C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:57:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39BC20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVU+RQsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39BC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7VW4Sb5codWUgp8dEieELjyh7SC6++NGb40+L/T4M/w=; b=WVU+RQsa/xvdzD
	bbqT0d4+I7iOo36Ut+y62/qQZyNHS273k7zqJoJOM8DbQWkhBtWow85zrVFfmeCKP+71n3kuh+J08
	VZuAKHl485+YGS82ahiioeujcMzIBRtlXnhb5h6Ea61J+rhekK+7H0FlU9Ll66jtQ3vaYRuM1BD1u
	SBrmHREc3a+pPvdJVaSka/+szGkgZpcyPP5M8duVjCkFl5DvO3a9M7jN+IUFzPCF8BRpfC7dGwKt4
	fDgRLY6uo7NB5Vi4Z2X6AZEDM72tT4Z1p+o17s14PxcVo6eP1OcBFC9uz2b7nAQj5rRJY+THih9f2
	J60syqOkTT6TUDcXVBxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9hl-0002Wo-FF; Wed, 12 Dec 2018 18:57:57 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9hi-0002WN-4e
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:57:55 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6596D809F;
 Wed, 12 Dec 2018 18:57:47 +0000 (UTC)
Date: Wed, 12 Dec 2018 10:57:41 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1
 after hotplug
Message-ID: <20181212185741.GJ6707@atomide.com>
References: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
 <20181212175332.GI6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212175332.GI6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_105754_218681_E99DB776 
X-CRM114-Status: UNSURE (   8.25  )
X-CRM114-Notice: Please train this message.
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

* Tony Lindgren <tony@atomide.com> [181212 17:53]:
> * Russell King <rmk+kernel@armlinux.org.uk> [181212 11:49]:
> > We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
> > would expect would take care of the issue, but internally this only
> > deals with one-shot local timers - tick_broadcast_enable() on the other
> > hand only deals with periodic local timers.  So, we need to call both.
> 
> This works just fine for me for NO_HZ and cpuidle:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

And also works for me without NO_HZ too FYI.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
