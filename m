Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1465C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84942192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZOWtKJ/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84942192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pfbzuX5gcR/etfsOPwXyIfA6uZXCZIyPClFzkTL4ym8=; b=ZOWtKJ/2kZAnBE
	OifRxbvWURuraC0GRlgJYN6bNiMV7381KUnm6fDSdgD8y1yN8ELa0LWrLq+s80zKvtqnRLlWTgn6A
	UgBMcWgnsROy3V74oEF88Dy+8K0hLOMfE1DxxbjekdofCSFHJdwy7iguddYGF8zMm4Q4n8emje29s
	y1M82f3cfPIehG4T9IkrHicTiOJdOvD7QPpWkK3onWUhpcVsElWEjkwRlU73ySWfq7j/HLtv0l/LK
	WIGbV3XP6rdG1F7mTizO/Q07sdvFOPlxcu0DTb8plqGyY4bsZqZMfbjDqANl9lRyCVKskbVsuRpa1
	2yielLNFkD7jh+luMqZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueM1-0001ga-Rk; Fri, 15 Feb 2019 14:20:37 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueLy-0001fn-KR
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:20:36 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id B5A7C68D93; Fri, 15 Feb 2019 15:20:29 +0100 (CET)
Date: Fri, 15 Feb 2019 15:20:29 +0100
From: Torsten Duwe <duwe@lst.de>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190215142029.GB32618@lst.de>
References: <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
 <20190212100929.iqsxu443qrkl6myf@flea>
 <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
 <20190213094442.da2dy6d5bb527nft@flea>
 <E1gtsx9-0000RP-08@stardust.g4.wien.funkfeuer.at>
 <20190213155311.ovkpim3lxwyvuhhj@flea>
 <E1gu4dx-0000Sy-2B@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gu4dx-0000Sy-2B@stardust.g4.wien.funkfeuer.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_062034_821340_40992DA3 
X-CRM114-Status: GOOD (  19.20  )
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

This is becoming big; can we please split this thread into 3 separate issues?
AFAICS there's the original request to have DT audio nodes for Teres-I,
then a discussion about gpio/pinctrl properties, and one about formal 
device tree verification.

Nonetheless I'll add to points 1 and 3 here :)

On Thu, Feb 14, 2019 at 01:12:44AM +0100, Harald Geyer wrote:
> Hi Maxime!
> 
> Maxime Ripard writes:
> > On Wed, Feb 13, 2019 at 12:43:46PM +0100, Harald Geyer wrote:
> > > Maxime Ripard writes:
> > > > On Tue, Feb 12, 2019 at 08:37:36PM +0100, Harald Geyer wrote:

[ GPIO discussion ]

> I believe it should be possible to tell if a DT is valid, just be looking
> at the binding documentation. Without looking on the linux source code
> or other side channel information.
> 
> As you write below, people are putting DTs into ROM. Which means that
> IMO the DTs should actually be OS independent, so that people can use
> different OSes on their equipment. This in turn requires the binding
> documentation to be comprehensive.

From my view device trees are maintained in the linux kernel source just
because it's the most active, vivid community, with established procedures
on how to review and make changes. So yes, DTs should be OS agnostic, and
ideally comply with a binding spec (sic!). It's simply pragmatic to do this
on kernel.org.

And yes, some DT formal verification spinning off of this would be a really
good idea, to take ARM (et al.), Linux, and U-Boot further.

[...]

> > > > > But we need a way to control the mux from userspace and aside from
> > > > > unbinding the ideas proposed thus far are:
> > > > >
> > > > > a) control the gpio directly
> > > > > b) control the gpio via leds-gpio
> > > > > 
> > > > > (a) was dismissed because we can't set a default from DT
> > > > > (b) was dismissed because some rogue app might try to blink it

Hey, this is a debugging hack. If some rogue app tries to blink it, so be it.

> I suspect some distributions will pick up the patch I posted anyway, if
> it doesn't get merged mainline. (This is how I forgot missing backlight
> support - it just worked for too many people ...) If we ship
> sun50i-a64-teres-i.dts with the proper nodes (but disabled), their
> patches will be much easier to maintain as the official DT evolves.

As I wrote (held by the list admin), I consider the whole console mux
GPIO an U-Boot hack, and would put it into sun50i-a64-teres-i-u-boot.dtsi.
(As a LED, see above :-)

Would you care to submit a patch version without that GPIO handled?
I think it's very useful and has the pontential to be agreed upon.

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
