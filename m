Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254EC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A88F21B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AyXfXJrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A88F21B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Content-ID:MIME-Version
	:References:In-reply-to:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exuOy1NpbDY13sO4RvD1RARs/ReBij2jRfyJohaZ8Uo=; b=AyXfXJrViJebqY
	URY0xa+Twa03p9o6uLP3DJ2mGut/sefEwrVqDrCDa4iLLAJvQYuXXa2VuyusSb3b8HxKyyzF1faZr
	ZtDUe3ht/KxRsRMZh3S4SKy6VHxbegSzaFewPS6FxGASr0+ww9l7RL5v7N/Rx46hUdD4ooXJ3dp9K
	fpUwVbryWDKYITo7kThAVBtlj9Hfcgo3DtpD4OYhKiZ7RSLssjbpnXOwVmvPfuTriomqgRUiMzuoM
	qlpRoDO/M/dz1Af8PegsO2cI6STTbp/CopBPP+xGTRNze40uvi2zhAjDp6bmBvf6ZcpEAEZq3uG9e
	CcKtGMWXyaNBye0zgW5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBp5-0005K3-8m; Mon, 11 Feb 2019 13:40:35 +0000
Received: from h1.radempa.de ([176.9.142.194] helo=mail.cosmopool.net)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBlj-000128-Gf
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:37:40 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id 2FC1C9004B2;
 Mon, 11 Feb 2019 14:37:02 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYtuJQdEzu1o; Mon, 11 Feb 2019 14:36:58 +0100 (CET)
Received: from stardust.g4.wien.funkfeuer.at
 (178.113.214.5.wireless.dyn.drei.com [178.113.214.5])
 by mail.cosmopool.net (Postfix) with ESMTPSA id 51503900316;
 Mon, 11 Feb 2019 14:36:57 +0100 (CET)
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
 (envelope-from <harald@ccbib.org>)
 id 1gtBlV-0000Wl-Cv; Mon, 11 Feb 2019 14:36:53 +0100
From: Harald Geyer <harald@ccbib.org>
To: 20190201113743.10058-1-harald@ccbib.org
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
In-reply-to: <20190211111245.GA18147@lst.de>
References: <20190211111245.GA18147@lst.de>
Comments: In-reply-to Torsten Duwe <duwe@lst.de>
 message dated "Mon, 11 Feb 2019 12:12:45 +0100."
MIME-Version: 1.0
Content-ID: <2029.1549892212.1@stardust.g4.wien.funkfeuer.at>
Date: Mon, 11 Feb 2019 14:36:53 +0100
Message-Id: <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_053708_345897_118D89C0 
X-CRM114-Status: GOOD (  29.04  )
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
 info@olimex.com, Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Torsten!

Torsten Duwe writes:
> > hpvcc-supply vs. cpvdd-supply:
> > On the A64 manual the pin is called CPVDD and the binding documents
> > requires a cpvdd-supply property. However in the actual driver and
> > devicetrees so far hpvcc-supply is used. This is a very new binding,
> > so we have the luxury to decide either way, I think. Any input from
> > the devicetree maintainers would be appreciated.
> 
> I don't really have a strong opinion here, besides settling this ASAP,
> to minimise confusion.

Yeah, given that this issue was introduced only in 5.0 and 5.0 is
almost out of the door, I'd have believed people to be more eager to
get this fixed soon.

Well, if nobody speaks up, I'll just include a patch to change the
binding to match the source in the next version of my submission.

> > debug console multiplexing:
> > Olimex have a userspace script that controls gpio PL9 during boot,
> > to select between HP and serial console. I guess this is not acceptable
> > for mainline.
> 
> > The best solution I can see is to switch the HP jack from serial console
> > to audio once the audio drivers load. With this people can still capture
> > the bootlogs but everybody gets audio once the system is up and
> > switching back to console output is as simple as unloading the audio
> > drivers.
> 
> IMO it is really not the audio driver's business to mess with this switch.
> You could argue as well that the serial driver should get a flag to claim
> the HP jack, which would be similarily unjustified.

Not the audio driver's business, but perheps the audio card's DT node.
Which is why I came up with the pinctrl idea.

> My solution is to confine this choice inside U-Boot:
> in sun50i-a64-teres-i-u-boot.dtsi I put
> 
> / {
>         leds {
>                 compatible = "gpio-leds";
>                 /* Not really a LED, but the least intrusive workaround */
>                 audioconsole {
>                         label = "teres-i:audio:console";
>                         gpio = <&r_pio 0 9 GPIO_ACTIVE_LOW>; /* PL9 */
>                         default-state = "on";
>                 };
>         };
> [...]
> 
> and place a "gpio set PL9;" somewhere in the bootcmd_* logic. Otherwise there's
> a *lot* of chirping on the right ear during boot ;-)
> The switch is for early boot debugging, so it's best to have U-Boot enable it
> when required, and keep it off by default.

I agree that some quirk in u-boot will be required for those who want
to boot with headphones plugged in.

But I still think we need a proper description of the HW in the linux DT:
* When linux doesn't know about the pin at all, there are no guarantees
  that it won't accidentally touch the pin during some operations like
  suspend/resume, etc.
* There is the usecase where somebody puts the system console on ttyS1
  and uses ttyS0 to connect to some other board. (Actually I believe this
  is a quite likely usecase given Olimex' usual target market.) I'd like
  to support this.

Using something like your leds hack in the linux DT would be fine for
me, if the maintainers are willing to accept it.

As it is, I'm currently working on supporting "output-high" property
in pinctrl-sunxi.
 
> > Testing:
> > I don't have a headset with combo connector, so I could only test the
> > headphones output, but not the headset mic. If somebody happens to
> > have a TERES-I and a suitable headset, testing this would be nice.
> 
> The pinout required is the "CTIA" one, *not* OMTP (standards are great...) see
> https://source.android.com/devices/accessories/headset/plug-headset-spec#mechanical
> 
> I do have a compatible headset, but was neither able to record from the HS mic
> nor from the internal mic, so I have to try harder, I guess ;-) I could hear
> both mics when choosing the mixer as output source though. Mute and boost
> worked for both mics, in alsamixer.

Probably you need to enable more controls in alsamixer.
"AIF1 Data Digital ADC" comes to mind as a plausible candidate.

> Kernel is 4.20.6, so ca0412a05756cd0b
> is missing; which shouldn't make a difference in this respect, right?

I suppose not, but I didn't actually test audio on 4.20.

Thanks,
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
