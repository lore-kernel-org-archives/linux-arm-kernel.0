Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE490C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:38:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8EA222C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o47KTVxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8EA222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Content-ID:MIME-Version
	:References:In-reply-to:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mjaHgvT0NfqzaEDfK7aWfsU6dTWt2TdljQFY9/YNlRY=; b=o47KTVxiryfPBR
	YlpmRzQGcRYQ0U6ES4jehMU/GHOuFt7ns4Xqik0LO4QH7/Hf7PGKrL3kHqyN+4gpYSO2Lp57l99Ri
	kZNznvTvHgmmt3hX524lpatRvaB4ATJRrDLu7IQRzM/x7nU3taZMEDFpN42YokFRjp0p5D5uLvWhB
	7qZrUYUMPSQovbAMNHxlLs1KBCNep+Ix5+fKlcj0jOHd5wjffDEAeFSVss87FlOp8HbrDj1BMmYkG
	Qnfx4fvN5mG2bNthH+65wAWDDvwqyfwmDW3cWlcs+v1Pna1cdnfRUUVTqodgqDqRLk109gnUF10bE
	Bzn+J1a+EpakrzQVkRRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdsX-0002K1-7C; Tue, 12 Feb 2019 19:38:01 +0000
Received: from mail.cosmopool.net ([2a01:4f8:160:20c1::10:107])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdsO-0002GN-0g
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:37:59 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id E5E7390266C;
 Tue, 12 Feb 2019 20:37:46 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwt8DU8kiFAx; Tue, 12 Feb 2019 20:37:43 +0100 (CET)
Received: from stardust.g4.wien.funkfeuer.at
 (178.112.157.99.wireless.dyn.drei.com [178.112.157.99])
 by mail.cosmopool.net (Postfix) with ESMTPSA id 473DD902666;
 Tue, 12 Feb 2019 20:37:43 +0100 (CET)
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
 (envelope-from <harald@ccbib.org>)
 id 1gtds8-0000NB-Re; Tue, 12 Feb 2019 20:37:36 +0100
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
In-reply-to: <20190212100929.iqsxu443qrkl6myf@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
 <20190212100929.iqsxu443qrkl6myf@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
 message dated "Tue, 12 Feb 2019 11:09:29 +0100."
MIME-Version: 1.0
Content-ID: <1435.1550000256.1@stardust.g4.wien.funkfeuer.at>
Date: Tue, 12 Feb 2019 20:37:36 +0100
Message-Id: <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_113752_453742_A26113B9 
X-CRM114-Status: GOOD (  27.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 info@olimex.com, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime!

Maxime Ripard writes:
> > > And pinctrl can be used dynamically as well if you need to
> >
> > Can you explain or point me to the relevant explanation in the docs? I
> > don't seem to know about it.
> 
> pinctrl_select_state is what you would want to call,
> you would have a good example of that runtime change in
> drivers/i2c/muxes/i2c-mux-pinctrl.c.

I believe we have misunderstood each other somewhere. The above example
seems to be about one device (mux driver) requesting a set of pins and then
switching between different pinconfig states thereby activating
different subsets of pins. I don't see a way to have two devices
request the same set of pins. I could write gpio-mux-pinctrl, but I
don't see how this helps much either.

> > > > Instead I just got the original patch working, by implementing
> > > > "output-high" DT property in sunxi-pinctrl. I'll send a patch for
> > > > review soon.
> > >
> > > What do you want to do with output-high exactly?
> >
> > Exactly what I do in the patch that started this thread. (I'll resend
> > when wens' cpvdd patch is available for me to rebase onto.)
> 
> There's a few issues with that approach as well:
> 
>   - We're actively trying to remove the pinctrl nodes for the GPIOs

For what reason? Maybe it doesn't apply to this usecase?

>   - It's completely static: if one only wants to use the UART all the
>   time, they would have to change the DTB, which might or might not be
>   possible. Note that this could be trickier: why would you prevent the
>   console from working for example if the audio support isn't built in?
>   or as a module that might or might not be loaded?

No, it's not that static:
* Before the audio device probes, UART is active. (You want UART all the
  time: Just prevent the audio module from loading.)
* When you have used audio and suddenly want to have UART instead: Just
  unbind the audio device and set the gpio to low or input from userspace.
  (I intended unbinding to be sufficient, but it seems pinctrl doesn't
   set the pin back to input when it is freed and I don't see a straight
   forward way to force that. I guess it is okay however: Somebody
   switching between UART and audio regularly has to know about the
   details anyway.)

I also tested suspend/resume/poweroff and it mostly works. The only
glitch is, that during suspend there is a short period of UART noise
on the HP. (But no such problem during resume or poweroff.) I suspect
the regulator supplying the gpio bank is shut down quite early when
suspending. It doesn't matter for this discussion: There likely would
be the same behaviour with any other approach too.

I think the real downside of this approach is, that using the UART
makes the internal speakers/mic unuseable too. But we need a way to
control the mux from userspace and aside from unbinding the ideas
proposed thus far are:
a) control the gpio directly
b) control the gpio via leds-gpio

(a) was dismissed because we can't set a default from DT
(b) was dismissed because some rogue app might try to blink it

The clean solution might be to write mux-gpio, which is actually
identical to leds-gpio but lives in /sys/class/mux_switches/ and
uses different filenames. But that's going down the "invent a new
subsystem road", which I believe is overkill for what is a debugging
facility for a single board.

Harald

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
