Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3995C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B299B20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCT96BLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B299B20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2gySGFeulX+vIbH8Sh/EYsjFgDJWSon24vspaQb8Z0k=; b=hCT96BLqHZqQdq
	6bSlhoUUPb3QWPUd7fWWlqxSVrmLnrSTp9SBzgM6+HT+oPGk+1wW7XL8q/btIrgByb5VzVZU6/15q
	h1VNp1CfgkP2uQiQBCXROjF7BouPkNCTMGD77A/0RQAypEUOjJFwD7no5snvwa67FzH7Jt7bfHuCt
	ZZ51wAHQKGQWjEqUstXikHhl4K2lYTyAPqRfFltKk5UlT01VoGGvZc7a4PhjiSUVsRM9PAzM1tQW2
	07pVbNqt6jlRZt/8kHJ77YD0YPMkvdh5ZNE/Vnm1a4sKx41dDsl+K0Zc8IgJE7XP4o1WElGJqn+XI
	1yNzktmmg60zwfBTT4Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmpV-0008U7-Kq; Wed, 16 Jan 2019 15:10:09 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmpN-0007aB-Ae
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:10:07 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 04F7B8030;
 Wed, 16 Jan 2019 15:10:05 +0000 (UTC)
Date: Wed, 16 Jan 2019 07:09:56 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116150956.GN5544@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20190116135829.GA10426@amd>
 <20190116145904.GM5544@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116145904.GM5544@atomide.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_071001_418300_CC7222F8 
X-CRM114-Status: GOOD (  11.20  )
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

* Tony Lindgren <tony@atomide.com> [190116 14:59]:
> * Pavel Machek <pavel@ucw.cz> [190116 13:58]:
> > And I wanted to ask -- did you figure out how to acknowledge the
> > SMSs? +CGNNA does not seem to do the job:
> > 
> > 07912470338016...
> > AT+CGNMA=1
> > +CGNMA:ERROR=9
> 
> Yeah the scripts in droid4-sms-tools git repo work for me for sending
> and receiving. They do not work with cdma currently as the format is
> different.
> 
> Maybe you've managed to change the mode of the modem to queue the
> messages with the at commands to the usb port?
> 
> You are reading and writing to /dev/motmdm9 for incoming sms right?

To debug, you can modprobe n_gsm debug=0xff and you'll see all the
packet data in dmesg, maybe email me the dmesg output of your ack
command packet data?

Or compare against what Android is doing, you can echo 0x7fffffff to
the ts27010 sysfs debug file somewhere to see similar packet data
with logcat -b radio.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
