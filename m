Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48038C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:33:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E1320880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVzJN9Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E1320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBKsoxD9/FPBAJkW9UozT0RBf9gDTWYRC0y5MXrdyPc=; b=AVzJN9PfSacjXB
	6fCxZoZ+u+H+HlHvGMZ9CJi6AVVWd8vgQElJU/uKdVPme8OjE4ZUkFjmr+pWz2qBad39tgvj+XpV3
	nNIFE2mic2+1j88WcaCGaFdMwzDT8epdu1XQAIK++UM4SZi7AxWMJJVHGwr4D+m8SYLxcd/4rhK5L
	G8G2b2BDMU61+xqYCb1q2sFnLIFekDJANQU7pI1nvAKE9XLXGMFMzVgg9LS4Yp0l0EhE84yoHJ/cv
	BiK7kABCtr/t3mTvJ1pxXQrTi0DOKM82CpCGb0RDNsPxmfvnLfg2QxvjuAO/E2qB+xuoqt0gGry+O
	EeFFX40hkU/xF1EvCUvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYYg-0007Cf-SW; Wed, 20 Feb 2019 20:33:34 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYYd-0007CJ-Fq
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 20:33:32 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4482380E1;
 Wed, 20 Feb 2019 20:33:40 +0000 (UTC)
Date: Wed, 20 Feb 2019 12:33:26 -0800
From: Tony Lindgren <tony@atomide.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Message-ID: <20190220203326.GT15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
 <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220.112244.1206973642383679896.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_123331_566640_736DEF71 
X-CRM114-Status: UNSURE (   6.84  )
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

* David Miller <davem@davemloft.net> [190220 19:23]:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Wed, 20 Feb 2019 17:25:19 +0200
> 
> > Deprecate cpsw-phy-sel driver as it's been replaced with new
> > TI phy-gmii-sel PHY driver.
> > 
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks for the ack, but actually I'd prefer you to pick
this patch at some future date. I suggest Grygorii just
repost this one after v5.1-rc1.

This way I can keep my last pending v5.1 branch limited
to dts changes to make the arm-soc life easier.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
