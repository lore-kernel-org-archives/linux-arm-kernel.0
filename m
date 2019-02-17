Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20471C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:27:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD30D2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERh7fLVL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zFJFil3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30D2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/5jyTI0Q29Zk460Su8WDWH2INjwGgCg7w3xjLZK/yJs=; b=ERh7fLVLK/aDh/
	rtp/SRYOT/PLKwQhB0GF+KPd82IlqmxuyqZydJL9gyKy4mAOAEleRHNkMNX2PYRfg2fDFueUA5oB8
	ud5D/Zehpg2XfC+ZCUoAX1BG6+2pzU+SYAUD9isASosmVS6CY/zINErl6LK3bCS/SypxGpkOexZGV
	h29VqK+jjY+HOFAmLWV3PFm2R9QiOu3IdacUaEefl6BeczjdjecGAdiN2s+MaTpAXom75vwOOg4Wy
	/4kH8XeZqZIIBA2Q8/grqqPJtE/kx2u9Wn09AHMmQcZZOvClsb2JWrexvi24mkxZInDlMa0vnjceM
	GVdrrGeFGlYWVAS0rVUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvR9i-00023y-JY; Sun, 17 Feb 2019 18:27:10 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvR9e-000212-Hp
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 18:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rXkk1WFidrTDdDgeq4K8Ncy10NY1XQPSSEL887PiS0s=; b=zFJFil3SiKWqHRl/JUGDPHL069
 ony+PENBZc1eNXN9HW2xkBdrUFh9aoj5a6cRho0MyrZ6pAlEvLK9/5clPTWWR2CUMdUBEO6N0vPS8
 MuXZ/5iS1EnY5rOtU1pAvxbQOJ4QNfZeHeCW0Qga1VOfBMbdBuAAkgjyR93cGQf9JrLQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gvR9W-0003zD-W8; Sun, 17 Feb 2019 19:26:58 +0100
Date: Sun, 17 Feb 2019 19:26:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal
Message-ID: <20190217182658.GA14879@lunn.ch>
References: <611c942e1da6404d47cf3ff4a6bd33d7bdab4e13.1550427700.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <611c942e1da6404d47cf3ff4a6bd33d7bdab4e13.1550427700.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_102706_744608_0279C5E8 
X-CRM114-Status: UNSURE (   6.88  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Denis Odintsov <oversun@me.com>, Jason Cooper <jason@lakedaemon.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 08:21:40PM +0200, Baruch Siach wrote:
> The PHY reset signal goes to mpp43 on CP0.
> 
> Reported-by: Denis Odintsov <oversun@me.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Fixes: babc5544c293 ("arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal")

       Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
