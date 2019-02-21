Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D21C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B021920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aXCcJ6dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B021920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IGDdfUE0Wf0mgmj7Gys8iCAmIDWo7DkIKzAxJmF6K9E=; b=aXCcJ6dMYGl+To
	NteMJG3k6DwtPaIeCSXdC3TQpqjgWR10NriQ03rBY5WVB2r3XplqIiya1k8H+HwbbQIJpmFdFBKFn
	CSmplWs+t36smMYfa3PB+18xW7fGSpwJWaBYTFg04qtw6/vknZ5x4fzAXb87eVv1MHLUaq4TL021S
	s0jjhn/Mx3z0heX0yujDUg+WTLBTuHm6rFUV4FQOhc9Y7roOvuoytVNBiFriHycdmzYMtDp/rH0E5
	48q6xQ4swM03FaTP8YoFJ7uS2oSLcmHHG3MpNuZIY2IzQ/kxU3mi0l26Ieem58PNSzZkSjTanipUk
	V/SyEINTGbVw95Mbqmuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwc4Z-0004Kz-FF; Thu, 21 Feb 2019 00:18:43 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwc4W-0004KM-Eh
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 00:18:41 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id B9E6A126736E9;
 Wed, 20 Feb 2019 16:18:34 -0800 (PST)
Date: Wed, 20 Feb 2019 16:18:31 -0800 (PST)
Message-Id: <20190220.161831.2067856031892978.davem@davemloft.net>
To: tony@atomide.com
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190220210127.GU15711@atomide.com>
References: <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
 <20190220210127.GU15711@atomide.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 20 Feb 2019 16:18:35 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_161840_495767_E1083371 
X-CRM114-Status: UNSURE (   6.95  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 kishon@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Feb 2019 13:01:27 -0800

> What I can do is set up a separate branch with just this
> patch on top of the dts changes that the arm-soc guys can
> then merge towards the end of the merge cycle. If that
> works for you, let me know and I'll do it.

Yes, it does work for me.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
