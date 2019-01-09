Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B762AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6162D20685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bKsFPBlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6162D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jgwg9wlo4cX7di8uJr+2Le7bqXantQ7c1fzb6F69oKc=; b=bKsFPBlWB5FfMN
	Y7GW65Nu7JwZVfQNEJZQfuN26RGhl84jbEEyBGZ8DrP7ttCkfv9ZbilsI4wdqepZ/qOU0pgiV1E0r
	pnQXS7g7Ngqv4IoJbNFj9otjyTq/jofaiXJ2f1ladOOynU2ukgyqOixv/ngU0ZhXaUuQc4TutTQju
	feX04y8VnvL5cc2KhvHD9YB5sJzXZY36pRTy6WL9Xp6Mw2ooloy2GNflKaX3TiMnNV9qQOjh7O5j8
	7Q5wOld1nOerj73v9uXPUb9Onu5h3VAYpSxorNonWoyFBiDXbzQcaNZupoI+XHIT7im5sxmQXbWjR
	1bZvgaXSYKpUPNUf1tMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLWO-0005ba-O7; Wed, 09 Jan 2019 21:36:20 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLWL-0005bE-TV
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 21:36:19 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 1CB7180C5;
 Wed,  9 Jan 2019 21:36:21 +0000 (UTC)
Date: Wed, 9 Jan 2019 13:36:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: Regression in v4.20 with net phy soft reset changes
Message-ID: <20190109213611.GU5544@atomide.com>
References: <20190109190650.GT5544@atomide.com>
 <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_133617_985654_C4D57340 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 Clemens Gruber <clemens.gruber@pqgruber.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Rex Chang <rchang@ti.com>,
 netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Heiner Kallweit <hkallweit1@gmail.com> [190109 19:28]:
> On 09.01.2019 20:06, Tony Lindgren wrote:
> > Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
> > a regression where suspend resume cycle fails to bring up Ethernet on at
> > least cpsw on am437x-sk-evm.
> > 
> What kind of PHY and which PHY driver is used with this board?
> I found one schematics of am437x where a KSZ9031RN PHY is used.
> Is it the same on your board?

Yes that's the phy.

> As described in the commit message of this commit you would have
> the option to implement the soft_reset callback in the PHY driver.
> Can you try to add .soft_reset = genphy_soft_reset to the
> KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
> it fixes the issue?

Yes that seems to work based on a quick test of five suspend
resume cycles.

I wonder what all hardware this issue affects though?

It's probably best that the network folks check what all
hardare needs patching.

For TI hardware, Sekhar and TI network folks, can you guys
please check the various TI SoCs for multiple suspend resume
cycles with v5.0-rc1 and patch accordingly? See also below
for something else to check, 10 seconds to resume a phy
seems very long to me :)

> > Keerthy noticed this may not happen on the first resume, but usually
> > happens after few suspend resume cycles. The most working suspend resume
> > cycles I've seen with the commit above is three.
...
> > Note that unrelated to the commit above, there may be other issues too
> > as the cpsw phy LED seems to come on only after about five seconds with
> > about total of 10 seconds before the Ethernet is up again.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
