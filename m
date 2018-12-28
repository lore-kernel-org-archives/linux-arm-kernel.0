Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCED217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0g1I1zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCED217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/c0q/VNKmM8ds7lPJWsDxG4WGGdqy+nYonvdFvrxbKI=; b=V0g1I1zytoZyOv
	nxw6IzlKodwF4YbWnl3xLaH4n5kJOtawGCJ1CBf1Z/k1lDJFyR2YfTJ3kRhZMLL7X0WQhK3GiNTC/
	z+txHOw1eEhS4f1sI/DUwViql0Cy73TWciDU99GHgFjrYewkv/gnRf6jonO0qVhKPj2pnlFxOJuRm
	xTTZ+zaRiVnqp9hZ2arS3AKfn8LTxf4QrdegjBHlRNXS156zGO4+4Lygkn4UHBn2BwVCzLe6j8+tR
	AHhz705I/0rnBVdWEbB0CaTdo1K/TYlp6TDKf1Nb1KE3e3PlN2mLU9gHgzRS053ebcbcIOnGatm9U
	jiXjLd7pc5wthftCAtfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd1eH-0001ep-4J; Fri, 28 Dec 2018 23:34:37 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd1eD-0001eB-MC
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 23:34:35 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 237E280BF;
 Fri, 28 Dec 2018 23:34:25 +0000 (UTC)
Date: Fri, 28 Dec 2018 15:34:17 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228233417.GD6707@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com> <20181228232536.GA7355@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228232536.GA7355@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_153433_765798_773E1350 
X-CRM114-Status: GOOD (  10.50  )
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

* Pavel Machek <pavel@ucw.cz> [181228 23:25]:
> So this would be "text mode": AT+CMGF=1. And I'd actually expect
> auto-ack to be the default on ttyUSB4, but in any case this is the
> command that controls it is: AT+CNMI=1,2,2,1,0.

OK thanks. These are not available for /dev/motmdm* files AFAIK.

> So... 57h would be very nice, and even 25h is cool. IIRC original
> motorola firmware does something like 100hours, and cyanogenmod is
> closer to 24h...

Well I got things down to about 55mW during idle but that still needs
more work. So that would be in theory idle battery life of:

(1735mWh * 3.8V) / 55mW = 119.87h (4.99d)

> Note that there's something in the sysfs that allows "precise"
> measurements. Aha, it is "charge_counter" on droid4.
> 
> (I even have some software to do the monitoring and display the
> graphs. unicsy_demo/monitor/batmond).

Oh nice, I'll give that a try.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
