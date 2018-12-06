Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866EB2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzuhSuLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866EB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+x9eAHgMUOmW9Mbf+KSNgDlBpoAEmfpkcZaphrYsA4c=; b=tzuhSuLB24PAaK
	5BC7ohpVz3a21sy9rn5UJMEDB1L5Q06fQXxMrGg4vY+fg8gvkSQf8ar6Maj83JWf1EfK7gGqLkhFw
	nPRhdAO0JJd6bo7FlESHDCJXegoWz8P7nDWfB8Cb1aC0Z155yE2IBS0eVAYR+NLOp90c81kQ+/pvm
	53JDSMYdQNjZzmJUsTDaWbh+oNyhlrLk3cTWEYm5gKkYotBCvOPFWC2YRzIS5Ip39R0DZS434kT6q
	T4PY3V5cdWQYaz0aHRmOYIoZY7cPR7eCleCGlNolT9CAO8kDmh9lLC0CCxhubdaLbQqpRah9F9oUQ
	NGnQXc3a9GWhPMW7zREw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1wN-0004CS-Pw; Thu, 06 Dec 2018 22:16:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1vD-0001O8-MF
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:15:26 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id AA3CA80F6;
 Thu,  6 Dec 2018 22:14:53 +0000 (UTC)
Date: Thu, 6 Dec 2018 14:14:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Message-ID: <20181206221447.GM6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206180806.GV6920@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141504_865545_49CC48DC 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [181206 18:08]:
> reverted, the problem is still there.  Revert:
> 
> ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4 based SoCs")
> 
> on top, and networking returns to normal.  So it appears to be this
> last commit causing the issue.
> 
> With that and b764a5863fd8 applied, it still misbehaves.  Then, poking
> at the OMAP4_GPIO_IRQWAKEN0 register, changing it from 0 to 4 with
> devmem2 restores normal behaviour - ping times are normal and NFS is
> happy.
> 
> # devmem2 0x48055044 w 4

OK thanks.

> Given that this GPIO device is not runtime suspended, and is
> permanently active (which is what I think we expect, given that it
> has an IRQ claimed against it) does the hardware still attempt to
> idle the GPIO block - if so, could that be why we need to program
> the wakeup register, so the GPIO block signals that it's active?

Yes we now idle non-irq GPIOs only from CPU_CLUSTER_PM_ENTER
as the selected cpuidle state triggers the domain transitions
with WFI. And that's why runtime_suspended_time does not increase
for a GPIO instance with IRQs.

I can reproduce the long ping latencies on duovero smsc connected
to gpio_44, I'll try to debug it more.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
