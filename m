Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A302184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zm/xgdeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A302184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CgQ9dMInvDlwAoZ0dV/ZjoP4zAZcIAqWZ19FRAPVW0g=; b=Zm/xgdehjRylMG
	Lhc16YpL8+9ZzzA7d2sUTj0ciHubRVyeIaZQIQs3IosEoJwRVp6frYzF5MpFfvZWljVOPKd1EEOWr
	Yp08SEKrN6EbOiSoBQK4jwVvlFaHJS5MjCa9MHCWP6DXyHQvuKXuJfXNAgz7SLeI0AedR5Sp9JLRj
	sc3FhUh9Dy9jlGp6pPEOvKFJGPXB/wNdUZNr2Fx/Ze23//+9A5oOppo4VZZhjFMHZpOskm+GxWgyM
	HmT7NLwp2si0CcCq69gdyaxfjpLX7UImPwpJS7ZZCUDvJxUQIOmV5ruJ8AYxuTcQwCq/WuNx/K55t
	aV8HGwP6eWj2HgHbmyxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNIv-0003dr-Sh; Tue, 18 Dec 2018 21:53:29 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNIs-0003cG-Fz
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:53:27 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 1FA81810D;
 Tue, 18 Dec 2018 21:53:18 +0000 (UTC)
Date: Tue, 18 Dec 2018 13:53:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181218215311.GD6707@atomide.com>
References: <20181217004450.GW6707@atomide.com> <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com> <20181218202242.GA30831@amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218202242.GA30831@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_135326_575956_160A4FA9 
X-CRM114-Status: GOOD (  18.60  )
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

* Pavel Machek <pavel@ucw.cz> [181218 20:22]:
> Hi!
> 
> > > # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> > > # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like droid4
> > > 
> > > Oh, that is a lot of fun. Especially state machine for parsing modem
> > > responses. I wonder how well it is going to work when modem is
> > > accessed over USB... 
> > > 
> > > motmdm_read_state(... size_t len)
> > 
> > That's a bit of a layering violation yeah :) But we still need to
> > do that somewhere for notifiers. And the notifications are separate
> > from the commands and start with a ~ character so from that point of
> > view it should not be too bad.
> 
> Plus, you seem to assume that data will always come in suitably sized
> chunks. Aha, and as it is not plain serial but packet protocol over
> serial... I guess that is going to work?

Yeah it's just packet data out of the n_gsm.

> > > I did a quick test in my config... and it did not break my old setup
> > > -- voice calls still work when set up over USB and with manual mixer
> > > setup. That was good surprise.
> > 
> > OK good to hear. Using the n_gsm port instead of USB during idle
> > has a major PM advantage as the SoC can hit retention during idle
> > while still connected to the modem and getting notifications.
> > 
> > So looks like during idle we can keep USB in autosuspend mode with
> > something like the below shell script function.
> 
> Yes, I should really start using serials instead of USB. But... I have
> working ofono there, and was using that phone and am little short on
> time at the moment.

Hopefully adding support to ofono and modemmanager to use use
/dev/motmdm1 for calls should be quite trivial now.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
