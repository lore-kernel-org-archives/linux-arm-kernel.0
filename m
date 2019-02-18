Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C372064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/xC27Gc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKhfquQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C372064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hw3ny8lEtJrlvlX7AvSH1I6MsgC5yKd8p/kIGQH+sOU=; b=A/xC27GcOkoScW
	VEKlhbXem51Cw6ChXzGyspQUOIpvICjLsKqsOeqhTL4m51qfpYKe7N7/dX9/Tx8iEmDY78kkgvG4T
	qmcQurNEivb9FXcrAqezsMoYx9ObZUBcSZj+CysF4/69xWb5tN/bVIPEC93rxm/sNo4wv4sYfDALD
	dI0zeTC6Fltu/lPCEVso/Y4g+gDUVBlr5uhvWfSAeITvnaBwmPpgVZUchOfMyi658qmfpqyJQbv5y
	ywYyJxiw9q499bw+PCkZ6Ay2mfBuWnkfhUMAsMzMUbHQlS7cQnmN4ryUCnGtPnAujenyZl6kgoHAE
	PqbJUCt39+RQTQ5BOGpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvrOp-0000M8-Ex; Mon, 18 Feb 2019 22:28:31 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvrOm-0000LS-9J
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:28:30 +0000
Received: by mail-ot1-x343.google.com with SMTP id t7so14561560otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EtL0H++FC+hfD2NXTdoT9f5v8nuo8y/Ymvz/KKsVPOY=;
 b=myKhfquQZC8BXC9UXbVOA3qNJir4n64KHhHMJ5cF6ShGo9Cxt/jYHW5mJdpbIQRj+B
 OqZVKIGxy2IRbAudnZpTDQlvVDZ7DT+baBJDytxWAmWnQpWjbqbLNDXY9309TsAqLLn0
 eorMKqtgucbVXyXqaRYwfuMXacO/HxJHCuoDea9Y5gEzjSaFJundWZ3/5ESbeg8ef/Kj
 sEDVFrlZMoRtaVoNAkuMFrLXWsmlD8iGL5fJ7CJUT8EKnBvpjUlhk541jZ89/S6a57Jy
 0cKmVCMLAWhcoMdtiocWSDFEifhYv9s4/ceKw+9eDzSt7yejtViRva6JAbnqf8h2yNQC
 LgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EtL0H++FC+hfD2NXTdoT9f5v8nuo8y/Ymvz/KKsVPOY=;
 b=R04G9trv1ul76A3qAo/8ebyKnAl0qygvkUG1BKucFdX2c1wsM5J85iazzf3gQYNhnZ
 MNIpXkxQefZ/wnC6VV4lq0VAX98l9TYoKLsiM8KtVirpk2DIuEb6qLTkOS7wfPRUCNcq
 ZgKWQw56gGuqXHeKyWy7vpf5zy0WjIxu1DOIxFz9SL7uwMD0w4MZFGgvIB12bjdGAgIe
 Bcfu9xP7VfNpS4kyLIEgpKIDugj05XESj3EPUsY+AIIAKWxyiGihpDDa0rKcMxA1F7NW
 b5PL829lALg9mnzmS3cDf7A6EZGusK1vx33Pmiei5s7o3j+5f2mxelJhFqH8M1LEuksQ
 uq6A==
X-Gm-Message-State: AHQUAubWWMISF+vDPDA6U/GiF+LLPCyoJ4trK+VUt0+DmuUtR5QIh/UK
 j9F2Be/Maoo/0tpcv9cV0cFONignMpwh8nQcZok=
X-Google-Smtp-Source: AHgI3Ia9kPLsHfHWsTs37LX1x7MeU2PA5jNHIytOBI1bGiCGtyv/MwjywGRaVLfH1oyDPx+56hAuzWvTdZ54NV3atk8=
X-Received: by 2002:aca:c142:: with SMTP id r63mr706734oif.98.1550528907259;
 Mon, 18 Feb 2019 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
In-Reply-To: <1245842044.588056.1550527701604@email.ionos.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 18 Feb 2019 14:28:01 -0800
Message-ID: <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_142828_346683_8F7C0E71 
X-CRM114-Status: GOOD (  21.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, beagleboard@davidjohnsummers.uk,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Vasily,

Hi Stefan,

> > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> >
> >
> > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > new file mode 100644
> > > > index 000000000000..8357f242ae4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > @@ -0,0 +1,35 @@
> > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > +---------------------
> > > > +
> > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > +to upload firmware and change module speed.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be one of the following:
> > > > +   * "realtek,rtl8723bs-bt"
> > > > +   * "realtek,rtl8723cs-bt"
> > > > +Optional properties:
> > > > +
> > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > >
>
> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
>
> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.

Looks good to me, but you may need to add firmware-postfix.

> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?

Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.

> Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
