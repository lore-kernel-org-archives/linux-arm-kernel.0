Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B36C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF4721104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lSrzgKPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF4721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4+3ep5Ku/RKzIsnjUJcgc/YIt8gjiJYlE4rcXf4wu0s=; b=lSrzgKPIBxY1z0
	89Xknql9MhDcEG8ZBZmIBUPYWgLb/mys/XXgzSB91lmC56YMUFWAO1XWCY99AEYYtLJcAw8HWL1rN
	W11PAQYXdm5tnhWTbzx52iIMLsaCA9X8zC6HhXoPWrmDFqGm/fE12ZbjmP4PgEqYV9ddNAFWugKOC
	F6vi1R+JccBjf02cdwxpUCYnEdOTXVPDkOowxG4T5O4xpVnfhAZKo1F60DBAgEI/hPAFP56CSNQU+
	O9v8UdRvL3JeTBXyNu3cbekNrvuIowBmfMd+Dx08SmgZr88jkwAQLsiOYCqFjkmCGj0QyxAKSSIF6
	CFv4eZgDY0n3fUE+A8aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSVs-0007Lo-TF; Thu, 29 Nov 2018 20:02:16 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSVp-0007Kw-Nz
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:02:15 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 3973480EA;
 Thu, 29 Nov 2018 20:02:05 +0000 (UTC)
Date: Thu, 29 Nov 2018 12:02:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED
 device
Message-ID: <20181129200200.GA53235@atomide.com>
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
 <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_120213_813216_53177F99 
X-CRM114-Status: UNSURE (   8.01  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Linux-OMAP <linux-omap@vger.kernel.org>, linux-leds@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [181114 12:51]:
> On Tue, Nov 6, 2018 at 12:22 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Global GPIO numbers no longer have to be passed to leds-gpio driver,
> > replace their assignment with a lookup table.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Excellent Janusz! :)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applying into omap-for-v4.21/omap1 thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
