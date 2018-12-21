Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EDEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:17:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2E721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f78mnSZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2E721903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4a8sgeK59/UdWwWiCi+jeKdlwuHOEwqGhRxfnHitNKM=; b=f78mnSZB0WVld8
	GRXxGz5wPg+GuclnerO86XGC1apwpWMIS+8xsbk2CCsa5xDHnhel/naHtC5Y35Pz5XA3/7JSTGVUa
	9KQsDbZsxpj1Ge7NZt+Fthu+uXELmYvQjH33x9kkxijS2/Dzkagdb1j+7MnB7lqaZiRXde2jE+NA6
	0gX2tw3HuugAcwyA1kSZPe2qa1JBH3LT2MHXpnfmPGMKhPa0x39ZMJwUlArUBPxfkevW7j8kZ5qsm
	WvocsOZZMLM0sLG4IUpDY9w/CM2pOxXMyI65M8d2naE4BCvfAo27toAyi5NU9hCxsQ4+IlO3kHGdU
	SJF7VT9yvivVJgqbYFSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaNUA-0006HR-2f; Fri, 21 Dec 2018 16:17:14 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaNU5-0006Ge-4W
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 16:17:12 +0000
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; d="scan'208";a="24678281"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Dec 2018 09:16:51 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Fri, 21 Dec 2018
 09:17:08 -0700
Date: Fri, 21 Dec 2018 17:16:51 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Message-ID: <20181221161651.5n4zzapliyxzb76l@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 me@jue.yt, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
 <20181211192805.qsxptzkmczmm5vlz@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211192805.qsxptzkmczmm5vlz@ninjato>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_081709_284472_0E240259 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, me@jue.yt,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On Tue, Dec 11, 2018 at 08:28:05PM +0100, Wolfram Sang wrote:
> Hi Ludovic,
> 
> > > >  - fix checkpatch errors
> > > >  - tests:
> > > >    - hangs with a SAMA5D4 (master and slave on different busses) after about
> > > >    100 transfers. It's the firs time I do this test.
> > > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > > >    I don't know if it's a regression. I don't remember having seen this
> > > >    behavior previously.
> > > >    I think it's worth taking those patches even if there are some possible
> > > >    bugs. It'll allow to get more people using it and so to consolidate the
> > > >    slave mode support.
> > > 
> > > I really want to see those patches go upstream, too. But I am also not a
> > > big fan of delivering the user something with known issues. Especially
> > > not when they affect the main feature to be added. My rationale here is
> > > that someone who is able to fix the issues remaining will also be able
> > > to pick up and apply patches.
> > > 
> > > Maybe, maybe if it was to be enabled by a special
> > > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > > think twice about that, though.
> > > 
> > 
> > I understand your point. The experimental mentionning could be a good
> > trade-off. Let me know once you make up your mind.
> > 
> > > Speaking of Kconfig, I think this series needs to place a
> > > 
> > > 	select I2C_SLAVE
> > > 
> > > somewhere.
> > > 
> > 
> > Ok I'll update it if we go further with this set of patches.
> 
> Ok, I give in. If you:
> 
> * add 'select I2C_SLAVE'
> * make slave support selectable by I2C_AT91_SLAVE_STAGING or
>   _EXPERIMENTAL or something alike (default n)
> * and add to the help text of that symbol the above known issues
>   and 'not for production' and 'help wanted' and where to get more
>   info and all that
> 
> then I'll apply this series soonish. Promised!

Ok I will handle these requests and resend it.

Thanks

Ludovic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
