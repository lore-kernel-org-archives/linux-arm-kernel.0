Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEA5218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+WEThFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEA5218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r4nGAQ1kxcnOFmK00nzlJdlolOwsBKknkarbFcpNCU8=; b=e+WEThFJgGvah2
	f4l5v9GbsIl7O+cHgUDRDdDq8kkuFwavtle8e7xDskcNikVd1VMEMAzfEdQB3Nc1yT5HVaPmuPX1A
	UeA467rvnzGyPJJwB8lubAru6wfkbe70B1sCAsGxbPf/hG6ouKgDYirXXUPHdsgjA1Vvo5ERX9IEd
	EDPERnB0l1LVT435DcZxLRZJZRCOFHySx/O5PqVKKaxYKq5D7X1x5UXLQekeLnK4ALEucX8T5KydS
	Ty0EvUlirp9Vx5vNu+L/bK/ZzGNvIbFXOU33HfwUPKs569r1bKE8/fX5LLV46AoRDPoaLO/zJLbVJ
	7Zbqyi27jPcUisNbQetw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBUj-0006tx-NL; Mon, 11 Feb 2019 13:19:33 +0000
Received: from smtp-out.xnet.cz ([178.217.244.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBUf-0006tR-Mr
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:19:31 +0000
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
 (Authenticated sender: petr@true.cz)
 by smtp-out.xnet.cz (Postfix) with ESMTPSA id 3102538C1;
 Mon, 11 Feb 2019 14:19:24 +0100 (CET)
Received: from localhost (meh.true.cz [local])
 by meh.true.cz (OpenSMTPD) with ESMTPA id 26ae5f3a;
 Mon, 11 Feb 2019 10:28:21 +0100 (CET)
Date: Mon, 11 Feb 2019 10:28:20 +0100
From: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: imx-uart DMA transaction error leading to OOPS on 4.14.95
Message-ID: <20190211092820.GS26426@meh.true.cz>
References: <20190206081310.GP26426@meh.true.cz>
 <20190211120616.GT4296@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211120616.GT4296@vkoul-mobl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_051929_894328_56020256 
X-CRM114-Status: GOOD (  14.82  )
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
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: dmaengine@vger.kernel.org, Robin Gong <yibin.gong@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Vinod Koul <vkoul@kernel.org> [2019-02-11 17:36:16]:

Hi,

> > I've just encountered following OOPS on 4.14.95:
> > 
> >   imx-uart 21f0000.serial: DMA transaction error.
> 
> Do you see this on mainline as well, bit of fixes went into this driver
> recently...

I've hit it only once on 4.14 so far, it's quite hard to reproduce it, so no
big deal, but I've just thought, that someone might be interested. Once I find
some way to reproduce it, I'll try to test it on some recent kernel.

BTW, any idea which of those fixes might be related to this Oops and might be
worth backporting to 4.14?

> >   Unable to handle kernel paging request at virtual address a0ee501a
> >   pgd = 9d7d4000
> >   [a0ee501a] *pgd=2d8d1811, *pte=00000000, *ppte=00000000
> >   Internal error: Oops: 7 [#1] SMP ARM
...
> >   CPU: 0 PID: 2536 Comm: sh Not tainted 4.14.95 #0
> >   Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> >   task: 9f67ca00 task.stack: 9b642000
> >   PC is at sdma_int_handler+0x7c/0x17c
> 
> So we get an interrupt while doing shutdown.. That is interesting..

I'm using serial console on ttymxc0 (115200,8n1) and UHF RFID reader on
ttymxc3(921600,8n1) which is sending reports asynchronously and it was active
during the shutdown as I was testing new hardware revision during that time.

> >   PC is at sdma_int_handler+0x7c/0x17c
> >   LR is at console_unlock+0x480/0x4ec

I'm not sure how to interpret this, but is it possible, that there might be
some race while sdma_int_handler could be processing interrupt on ttymxc3
while the system is doing some console output on ttymxc0? I just use the
console for observation, so I wasn't typing or otherwise utilizing it, so
probably no reason for interrupt from ttymxc0.

-- ynezz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
