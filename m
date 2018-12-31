Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53121783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S2+i0HcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53121783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AJHvnH7g8iIg442E8QBQJYwmcJM5rnWzJhMYrEj91BI=; b=S2+i0HcAMDMec7
	paXQjZCFYmXIYOFdKHmNEzht3nKW7yVK8Ei0oDpxPyvYBaDGoDgpZ7lAlLisRj285FqIFdPvGo7BG
	UAQbsksAMWJb/B2qSlqapZXocFBiHPbENReeLm44uT498lsdUs3488dhbvR17mxwersz4T1VNs1Id
	S9Pz46fYcXD7UdmaSbHT2fQqKZ9KWZaj6Mq3q79DNRBQMzTBbOsGqAz/L8aQDvNeQAYNpaWm3c6nD
	VpvLJ9HwH8IE38CQdM9VTgrl08zdi71wpBFMzZ6iot2pV8+tXYNlUng7JCeKUmiT8Ov3kumqFy4Q6
	Gszy+fFxUYlEtO9xtYZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5v9-0006Iw-1k; Mon, 31 Dec 2018 22:20:27 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5v5-0006IA-L6
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 22:20:25 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4825B806C;
 Mon, 31 Dec 2018 22:20:22 +0000 (UTC)
Date: Mon, 31 Dec 2018 14:20:13 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181231222013.GH6707@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228222805.GC6707@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_142023_731426_577CCFD0 
X-CRM114-Status: UNSURE (   7.94  )
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
Cc: Rob Herring <robh@kernel.org>, Marcel Partap <mpartap@gmx.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, omerlle@gmail.com,
 Merlijn Wajer <merlijn@wizzup.org>, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 NeKit <nekit1000@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Michael Scott <hashcode0f@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Tony Lindgren <tony@atomide.com> [181228 22:28]:
> With droid4-pending-mdm-v4.20 branch in the following state:
> 
> - UARTs idled
> - LCD blanked (well no drivers yet droid4-sms-read.rb)
> - MUSB and EHCI USB modules unloaded
> - OHCI loaded with all the children in autosuspend via sysfs
> - WLAN connected
> - busybox acpid stopped (yup, it keeps polling something???)
> - MDM6600 online with AT+CFUN=1 on /dev/motmdm1
> - MDM6600 notifications disabled with AT+SCRN=0 on /motmdm1
> - droid4-sms-read.rb running

So I tracked down what I thought is a busybox acpid issue, I was
wrong. There's nothing wrong with busybox acpid, sorry for
blaming a wrong culprit.

We have acpid keep the device open for
/dev/input/by-path/platform-48072000.i2c-event open, which
seems to keep atmel_mxt_ts and i2c busy.

Things idle fine after I rmmod atmel_mxt_ts after blanking
the screen.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
