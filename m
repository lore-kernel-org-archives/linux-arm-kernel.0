Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F8A2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTCU+AMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F8A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SH0WIpqsQ2D5m5DrP1bqy3xy2irW2dJ24p1uEIjC/ds=; b=HTCU+AMDj+dr0j
	bgtkdpn1VQV6E5emvlJOIMFC3t0l47x7fQc2lFO5N6uPyrwajT3m8Jtw8S/h56LiQfRmYFr54FfQB
	ySzdvZmoPa/qTcb+CxxVEzm0ZdyO0qmy3RVOjiX4fo/7V+iveWLFuanFR+zSvBG+igDkJZAgZZ2dm
	8E56MKfhGjlKtJ8yKDH3NPDgsbF7eotE9ZaHy2K9xJU+uMsOK5trzHxan8DTUpgxH3tMir4qlBSKn
	yETOdJnyBJuvPba0rh9+FLdpqWd7XND5rpMXGcwphgS2iqgq8VEgP2EQfk7Hxu7J/+D0m3H+TDDKX
	J/WBgk/+TsVnTMqHaU9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwP7n-0003xG-AK; Wed, 20 Feb 2019 10:29:11 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwP7j-0003wK-Ja
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 10:29:09 +0000
X-Originating-IP: 109.212.12.126
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr
 [109.212.12.126])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 31740C0016;
 Wed, 20 Feb 2019 10:29:01 +0000 (UTC)
Date: Wed, 20 Feb 2019 11:29:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas.Ferre@microchip.com
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <20190220102901.GH11432@piout.net>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
 <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_022907_788681_040A4607 
X-CRM114-Status: GOOD (  20.19  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20/02/2019 10:20:28+0000, Nicolas Ferre wrote:
> On 19/02/2019 at 17:51, Alexandre Belloni wrote:
> > nck() looks at the last id in an array and unfortunately,
> > at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> 
> Well, the logic for all other SoC clk files is to not have such a 
> sentinel and deal differently with this type of array: why not modify 
> this file to match with others?
> 
> 
> > number of peripheral clocks is 1 instead of a maximum of 31.
> > 
> > Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >   drivers/clk/at91/at91sam9x5.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> > index 2fe225a697df..d37e7ed9eb90 100644
> > --- a/drivers/clk/at91/at91sam9x5.c
> > +++ b/drivers/clk/at91/at91sam9x5.c
> > @@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
> >   		return;
> >   
> >   	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
> > -					   nck(at91sam9x5_systemck),
> > -					   nck(at91sam9x35_periphck), 0);
> > +					   nck(at91sam9x5_systemck), 31, 0);
> 
> I would prefer like it's done on other SoC clk files.
> 

Well, that is not possible, what do you suggest?

> >   	if (!at91sam9x5_pmc)
> >   		return;
> >   
> > 
> 
> 
> -- 
> Nicolas Ferre

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
