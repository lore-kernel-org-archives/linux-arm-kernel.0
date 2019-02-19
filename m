Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AAFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3932177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lGOBshtL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="na5jOMAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3932177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zIZ7cNffl6at2SRdU2HI8GEsFRF3IhHxHfOQCGDjmPM=; b=lGOBshtLYuAnJi
	v0aeBIcfdgF+V65StB5/oe7ZPblXG6c0WkEsrKSrPYWaLCxbyrALRl6lWjjOY+6uC95IANuSAv2Qp
	j45zzQdc7NQC//Ui1jwhz3iyRa4Hb9Ev14bCUfTB8EtLPL9QGozgrH3Lr/I5xOiusgoCvqhKjI8XM
	1zZpCJ6GrYQ/KMy2w93zYcckWaoR9R+S7FGwgv0eKe11JkZYtZxo8m7RNRb4oRbALVpdR6CcxIflh
	/VNuQUl9lLDbhlqY8YGBqS7xfOU+By/TJMVDF5/iDZ/+nEfPYOQ+Q5I/IVGDFZLIcorNN9mdLrxGA
	KClrGtDZRI9U0v6M8zsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6DJ-00044A-1P; Tue, 19 Feb 2019 14:17:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6DE-00043i-24
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:17:34 +0000
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A06F521902
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550585851;
 bh=kgVVAdu9HfOcqLEZpYWWTN2e+/KsdaDxYdC/hQZo+tg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=na5jOMAI7TISHYDd0h1IhE1F4mK2ZGB6u6xAt7UZPZz2Emd26nZZxWGcyRwsZIEQl
 ucnziU0XvtAypDniaxTyIeQtva0fr/lbdqTOXa5RlBfJCd7cXw7aPkNLyGllRNK0Aa
 1QDbWIBxgjduyFyOsdLp49fhtNkSYKtiTbTBvbIY=
Received: by mail-qk1-f173.google.com with SMTP id x6so12096121qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 06:17:31 -0800 (PST)
X-Gm-Message-State: AHQUAuby5BE+p/eqh/A16jzb1sFwQHFrsRZk0TE1+qwWxvkfOlIozIFO
 648qj6Ab9MLRaOZ90o9b1RXjf2gx8xFQLFzTxw==
X-Google-Smtp-Source: AHgI3IYNtXTmYF83zRojl7RhSrGNKW0hKjNlqWsD7leb9M4NOft1QXZP/xfSeH44xsCIqjET5xSXGEWQ43NrGEXKmvk=
X-Received: by 2002:a37:674c:: with SMTP id b73mr19964353qkc.184.1550585850781; 
 Tue, 19 Feb 2019 06:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
 <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
In-Reply-To: <CA+E=qVdMNmVkytCzXqYgJtV196-G=c_bWx+aLvs=Y0iuRpjdRg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Feb 2019 08:17:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
Message-ID: <CAL_JsqLROpJMoEPLXaAL_JG1SNufstMDmB4xy_V_p4=duHKPSA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_061732_130120_0C3FDE64 
X-CRM114-Status: GOOD (  23.94  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Mark Rutland <mark.rutland@arm.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 David Summers <beagleboard@davidjohnsummers.uk>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 4:28 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 2:08 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > Hi Vasily,
>
> Hi Stefan,
>
> > > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> > >
> > >
> > > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > > >
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > > >  1 file changed, 35 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > > new file mode 100644
> > > > > index 000000000000..8357f242ae4c
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > > @@ -0,0 +1,35 @@
> > > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > > +---------------------
> > > > > +
> > > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > > +to upload firmware and change module speed.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible: should be one of the following:
> > > > > +   * "realtek,rtl8723bs-bt"
> > > > > +   * "realtek,rtl8723cs-bt"
> > > > > +Optional properties:
> > > > > +
> > > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > > >
> >
> > sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> >
> > I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
>
> Looks good to me, but you may need to add firmware-postfix.
>
> > Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
>
> Yes, we can use enable-gpio instead of reset-gpio on pine64 and pinebook.

Then why do we have both? Reset and enable are distinct. The inverse
of enable-gpios is typically powerdown-gpios, not reset-gpios.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
