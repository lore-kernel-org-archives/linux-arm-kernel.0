Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD619C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:58:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F12F217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U21OOrof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F12F217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VR8nYUwA0pbwvaqYH2o2TQjJ7/1wS0QxRaOXYlI5iCY=; b=U21OOrofK6oyjB
	fU2KIUGdNXCDYhjg5Ud+fNGASV+qHPnS/eWUxe/2YVKfTC/pL6CRBNxxYEaxaiTFzDbd+mIHE1Wuj
	tf7irMdZVXgwwpwmtRJM+nXDFGFbxbh+tHpUmLnyBj9FEiV+LTvtbhEXt6/eYIXZzTA5IXmqcUh9p
	nb2+FP7bdsAeNOwAokoKJ5LfxTyYw46aw2lKrLti7w/Se788THoC0nC4a6zb93oWBiN/WkgLJeybF
	G7VJq+U/gomB2KZaG5Cny/hoCwYqw6GAmsCZMVpjgXsQHVvZvjuj0rfklHzyAqwcwKj1aI0rm2DEG
	XtjEeZJ13FGHFA0qFGXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeFJ-00076L-8P; Wed, 19 Dec 2018 15:58:53 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeEy-0006ny-6E
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:58:47 +0000
Received: by mail-oi1-f195.google.com with SMTP id m6so1971298oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 07:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CZ6helZFIbNZWd2xpX2RWEIGe/GgpkbWYhxxRVvlPGY=;
 b=YWakSPXtW3Qhc2R96MgPDvoZzRiNI2grveQTWtM1BaXkEiAyH8ZjcwxqXoutvDzpO9
 u3knTuaUoYJkKN/80jlZj+yAMQYhl3ZIsl7Fj6mvwthFq9Oh8zJ3xSY/riuPMV5L5eIf
 qQvhuKbwx8Jz878pblhStor1KrCAz7fGcXpYJ6AO2UVL4r187PuH75CM7yVq42qzm3Jl
 H+sF4n3TDlVh8ITXuvfVhApSXT7rfcHjBRDU53vGZ69O26roWaaE4UUU6pj4diZsxrEj
 ApRh2h3By3R34y9BZk4hH1yoCbuVw3X8iw4gcihSewfPOGXEM8KINe3uLzsk6odzUmpI
 eAog==
X-Gm-Message-State: AA+aEWaez/jsfvAPeSdzmMI6fgbB1C2NJ97Ny1rTRbR7rfaUnXx1vPp0
 N/r0Yge3EpgspGQj8UY09g==
X-Google-Smtp-Source: AFSGD/W9GXq5kAsnWs/Xnz7z663VsKaUGUVw1RXyP8zm6/ltLOF3fLAu87v6trOzW/o02sT4ob4rFQ==
X-Received: by 2002:aca:f244:: with SMTP id q65mr1333524oih.50.1545235100970; 
 Wed, 19 Dec 2018 07:58:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 75sm8770634otc.67.2018.12.19.07.58.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 07:58:20 -0800 (PST)
Date: Wed, 19 Dec 2018 09:58:19 -0600
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: a64-amarula-relic: Add OV5640
 camera node
Message-ID: <20181219155819.GA22708@bogus>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
 <20181203100747.16442-6-jagan@amarulasolutions.com>
 <CAGb2v6441wV7PM6q=vF2cpJtP9BGdYjQQqNU54rqELNJ5YcmdQ@mail.gmail.com>
 <CAMty3ZBBcum5CF1xQ_ePNUkcMoBPXngbiwf2V7hWHrH7-k3xuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZBBcum5CF1xQ_ePNUkcMoBPXngbiwf2V7hWHrH7-k3xuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_075832_378727_A532DCDE 
X-CRM114-Status: GOOD (  20.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 04:43:33PM +0530, Jagan Teki wrote:
> On Mon, Dec 3, 2018 at 3:55 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Amarula A64-Relic board by default bound with OV5640 camera,
> > > so add support for it with below pin information.
> > >
> > > - PE13, PE12 via i2c-gpio bitbanging
> > > - CLK_CSI_MCLK as external clock
> > > - PE1 as external clock pin muxing
> > > - DLDO3 as vcc-csi supply
> > > - DLDO3 as AVDD supply
> > > - ALDO1 as DOVDD supply
> > > - ELDO3 as DVDD supply
> > > - PE14 gpio for reset pin
> > > - PE15 gpio for powerdown pin
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  5 ++
> > >  2 files changed, 59 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > index 6cb2b7f0c817..9ac6d773188b 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > @@ -22,6 +22,41 @@
> > >                 stdout-path = "serial0:115200n8";
> > >         };
> > >
> > > +       i2c-csi {
> > > +               compatible = "i2c-gpio";
> > > +               sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> > > +               scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> >
> > FYI our hardware doesn't do open drain.
> 
> True, but the kernel is enforcing it seems, from the change from [1].
> does that mean Linux use open drain even though hardware doens't have?
> or did I miss anything?

It's forced because you can't do I2C without open drain. Things like the 
slave doing clock stretching won't work.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
