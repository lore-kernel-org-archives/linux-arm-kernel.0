Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B74DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1FB205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CBsnDUYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1FB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r1SPQk3z+ETxLqkpwNH5ZnV5xuydbYXtCC2EgX7fm8Q=; b=CBsnDUYSgAdSjg
	2jM9YHaiBcIfZ555hIRaW19H7DsRME3ppyiGoa/5pXUbvmyjYt4YBMfDLyy9j4GxOf3ryoQohVui9
	ju7hKGKOag0b4sHiyzCiIxKZUbv2rKdUEdmbyV74aX8UA1iCq49BweZpSfx3OuLcXa22B8tNc6bbl
	qQjqbdOt6r/vcYWrnQHT6OR3UK2DRKU8h4KoxPe6LTlQ3GW13PO6HG5K+3fsgQtcxSJ1MIjvBbOLU
	hNbKWEQo2JjB9hx2KmFOGAxFHj7arCkmySGd9mA8plSgOR08U649IIVfgbbu0c2SUonzGk0biNl9B
	2y8PU7Xl1T7Y9rH9kHQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmev-0003xE-Mc; Wed, 16 Jan 2019 14:59:13 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmes-0003wn-7d
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 14:59:12 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 9938C8030;
 Wed, 16 Jan 2019 14:59:14 +0000 (UTC)
Date: Wed, 16 Jan 2019 06:59:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116145904.GM5544@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com> <20190116135829.GA10426@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116135829.GA10426@amd>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_065910_313369_EE0550F4 
X-CRM114-Status: GOOD (  17.42  )
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

* Pavel Machek <pavel@ucw.cz> [190116 13:58]:
> Hi!
> 
> > * Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> > > Ok, I really need SMS messages, too.
> > > 
> > > Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> > > logical. And you probably need to acknowledge them, using PDU,
> > > too... (because otherwise you'll just get the same SMS over and over
> > > and over). Which is also logical, but hard to do from shell/python.
> > 
> > Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> > properly while I did not have much luck with other tools.
> > 
> > So I wrote a hasty script to read SMS, copy it to a Maildir and
> > then ack it:
> > 
> > https://github.com/tmlind/droid4-sms-tools
> 
> I could not get that one to work.
> 
> /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in
> `class_eval': /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:
> `@@{' is not allowed as a class variable name (SyntaxError)
> /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47: syntax error,
> unexpected end-of-input
>           unless defined? @@{:default=>true}
> 	                              ^
> from /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in `block in cattr_accessor'

Hmm yeah looking at my notes I also had some issues and did something like
this to install git version of phone gem:

$ git clone git://github.com/carr/phone
$ cd phone
$ sed -i 's/beta//' lib/phone/version.rb
$ cd phone
$ sed -i 's/1.3.0.beta1/1.2.9/' lib/phone/version.rb
$ gem build phone.gemspec
$ sudo gem uninstall phone
$ sudo gem uninstall bigdecimal -v 1.4.2        # 1.3.4 works
$ sudo gem install phone-1.2.9.gem

> And I wanted to ask -- did you figure out how to acknowledge the
> SMSs? +CGNNA does not seem to do the job:
> 
> 07912470338016...
> AT+CGNMA=1
> +CGNMA:ERROR=9

Yeah the scripts in droid4-sms-tools git repo work for me for sending
and receiving. They do not work with cdma currently as the format is
different.

Maybe you've managed to change the mode of the modem to queue the
messages with the at commands to the usb port?

You are reading and writing to /dev/motmdm9 for incoming sms right?

> > My logs show that Android uses two different commands for ack.
> > Either AT+GCNMA=1 or AT+CNMA=0,0 gets used depending on something
> > that I have no idea of.. Maybe the network connected?

I think AT+GCNMA=1 works 3g and AT+CNMA=0,0 with cdma. Or it could be
that one of them is just a delayed ack, I don't know.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
