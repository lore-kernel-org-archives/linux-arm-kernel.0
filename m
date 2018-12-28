Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E81C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:31:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C982081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DPs1dwrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C982081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1kUUCdi7AGC0geuiQzbym2jDOf3obMUYXArDZa2HrYA=; b=DPs1dwrFtEhl3f
	I/oCY5iV9xMTS6FDol378GhAQH5iv+N8GpSXrK9fVyo69S01QpK8s3ruo+J5YRCVjn8rSBkr8fX5n
	858THY5r67hw4LaquhhPvpb0u2RuC6wU/qQ7YpOKaXcIUuz7MWRP3zyE6bv86Studn+xkYhzEwSM6
	ZOkqN72begmrl0AE7AYgEYCuPtt2iJXmxi92ay/bpB5rbE8DNMXfFSMJmsaoI0SQYww6nXOxDG2S8
	Cg5VNyczJwnyWILzXbwT5FZlU5kBhD4QAdW07UEuWUhFMAMSfQvg8ivA2wauS6PUrB98o1h+k3V6h
	nonU3uSLZmRwT0VvQVyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcxr1-0006RY-3e; Fri, 28 Dec 2018 19:31:31 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcxqx-0006Qr-A8
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 19:31:29 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id AD68280BF;
 Fri, 28 Dec 2018 19:31:13 +0000 (UTC)
Date: Fri, 28 Dec 2018 11:31:05 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228193105.GW6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181227101647.GA32260@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_113127_398867_FD1CE20C 
X-CRM114-Status: GOOD (  11.80  )
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

* Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> Ok, I really need SMS messages, too.
> 
> Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> logical. And you probably need to acknowledge them, using PDU,
> too... (because otherwise you'll just get the same SMS over and over
> and over). Which is also logical, but hard to do from shell/python.

Yeah so I found that Ruby pdu_tools module allows decoding PDUs
properly while I did not have much luck with other tools.

So I wrote a hasty script to read SMS, copy it to a Maildir and
then ack it:

https://github.com/tmlind/droid4-sms-tools

> Proper solution involves special support for ofonod...

Yeah at least we're dealing with standard PDU format now for
incoming SMS.

Also looks like there is no status on the modem for these incoming
messages as checked with mmcli. I guess the idea with raw PDU
access is that the message is delivered directly to the client
and then acked instead of being queued in the modem?

> Fortunately ttyUSB4 still works, so I can still use my old code... and
> I started logging motmdm1 and 9 to a file as a backup... that should
> be better than my existing solution. (But I don't get power benefits
> etc.)

So what are you using to ack the received SMS over ttyUSB4?

My logs show that Android uses two different commands for ack.
Either AT+GCNMA=1 or AT+CNMA=0,0 gets used depending on something
that I have no idea of.. Maybe the network connected?

Sending SMS via /dev/motmdm3 needs move investigation, but at
least ModemManager mmcli can be used to create and send SMS.

Hmm or what are you using to send SMS over ttyUSB4?
I think you already replied with some of that info earlier
but I can't find it..

Oh one more thing, I noticed that on /dev/motmdm1, typing
AT+SCRN=0 supresses notifications except for WAKEUP, and then
1 is used to enable them again. That allows the UART to idle
instead of getting network status messages every few seconds :)

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
