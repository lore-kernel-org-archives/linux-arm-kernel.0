Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D206206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ggR4XLuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D206206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sxw5D6DlRRDMj/DTJXpgtoedfQxJJYsUStWNnJlrGAw=; b=ggR4XLuzmLrwMr
	uVzJXr07ef6q7pynSOuQ4IEnAvjh0Dqwbg9qxIz1TRpbhzPE48vzBduZuzdBZyOdg85GwxlFCET/E
	UZ8uIG9GbJKN5AAW9qY9YOJHFnitIkqD+uWzp3D6zrqwj/Z8XsPwP1vvkaF9huZOHca7m1teAYXx+
	T9HS0t5ZlWExNd2f/y7XiuVvGbhIbMp2djfZPzvymItI2LGPrqRmrtfaFAewwlzjkt7qK2VK9PKPO
	mv10d8jCPRYWyGjAMvKouFu8Dhs2r6HR+mboJ1XC/MCKF195RPY/IbsdG2+oQBP67k1Jv74P3V/bN
	VC7pTrWzjJOIe/SvFrdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0cC-0006tk-Ec; Fri, 28 Dec 2018 22:28:24 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0c9-0006sn-B2
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 22:28:22 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id EC79380BF;
 Fri, 28 Dec 2018 22:28:13 +0000 (UTC)
Date: Fri, 28 Dec 2018 14:28:05 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228222805.GC6707@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20181228204614.GA9431@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228204614.GA9431@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_142821_416145_629E1357 
X-CRM114-Status: UNSURE (   7.91  )
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

* Pavel Machek <pavel@ucw.cz> [181228 20:46]:
> I have ofone with direct AT access --
> https://github.com/pavelmachek/unicsy_demo/blob/master/ofone/at.py .

OK thanks, that shows some of the commands I was wondering about.

> Now, ttyUSB4 provides quite a rich interface, and you can actually
> select what if you want messages in text and PDU format, and if you
> want modem to auto-acknowledge messages for you.

So which AT command configures auto-ack of SMS? I don't need it,
just wondering what all these commands do.

> What kind of battery life do you get with all the optimalizations?
> IIRC I was getting 7h with ttyUSB4 in use...

With droid4-pending-mdm-v4.20 branch in the following state:

- UARTs idled
- LCD blanked (well no drivers yet droid4-sms-read.rb)
- MUSB and EHCI USB modules unloaded
- OHCI loaded with all the children in autosuspend via sysfs
- WLAN connected
- busybox acpid stopped (yup, it keeps polling something???)
- MDM6600 online with AT+CFUN=1 on /dev/motmdm1
- MDM6600 notifications disabled with AT+SCRN=0 on /motmdm1
- droid4-sms-read.rb running

I'm seeing droid 4 idle at 119mW according to my power supply.
So I guess theoretical battery life would currently be
(1785mWh * 3.8V) / 119mW = 57h. But in practise things are not
completely idle and monitoring sysfs POWER_SUPPLY_POWER_AVG
every 10 seconds I'm seeing something along these 10 samples:

POWER_SUPPLY_POWER_AVG=138938
POWER_SUPPLY_POWER_AVG=134571
POWER_SUPPLY_POWER_AVG=505802
POWER_SUPPLY_POWER_AVG=240412
POWER_SUPPLY_POWER_AVG=134252
POWER_SUPPLY_POWER_AVG=132694
POWER_SUPPLY_POWER_AVG=571569
POWER_SUPPLY_POWER_AVG=132694
POWER_SUPPLY_POWER_AVG=190456
POWER_SUPPLY_POWER_AVG=518288

So the average based on that sampling is about 270mW and the idle
time should be about 1785 * 3.8 / 270 = 25h, which is quite usable
already :)

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
