Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A665B21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7qVkciK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPRfY8EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665B21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aaOzOD22NIXYHwfg8OgT/eg2FuF3U1099FAk6GxwYRY=; b=K7qVkciK4V5rbK
	5OZHz5O31yadOwTKfWnFb0k2uSD16W7oJDkmaDGyrkV4Kb40nhukea5eJozMd9YZ5Ak1C4ggxmZSx
	qlQ9/nxgSiO4AHh7zqjSEx5lGsRQH2kU0/Qte9i/W5FTjILexdrk/I0NFGuifN8Sg4uN5rq4f0PPK
	LAgJuTlOLZKBr+A080cptcMUofn38y1beS5+CvFJESnAPavNERtTq2cB3PlMxi/vChVcRC9M70m8a
	LbXI5xkM9jUNhJhUYtdnSecPl1d1btXaETnSTUEOkC+cWl2dpniQTgUOREdYPqppGFLR0jq+NaUy1
	7PT4JzROCY/AwmaccsSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6AB-0001wE-Ut; Tue, 19 Feb 2019 14:14:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6A3-0001nX-O6
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:14:22 +0000
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14EC621903
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550585655;
 bh=k/rZw+tctmTg7PN7nlanI4BJpNoPAyeRjRuqJeqf0WU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CPRfY8EQFdseX3F6qJjxkBmeSTe2yI5Tch5++jCnFXoq5ah1TWLDtuhLzMhxPGsCn
 R85yDutANUG0iOoBd+pSwcS4vBLJgydIdquSx/N8cUvSeahBT7dbGAaoajGshvqiPy
 7pbXLe+rvWRiKw1kSj0XihztwQE1mnnZ32AV0Z4k=
Received: by mail-qk1-f178.google.com with SMTP id f196so12054525qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 06:14:15 -0800 (PST)
X-Gm-Message-State: AHQUAuaTWViA9tdZjZka2hxsktUZz2ddRTQXPx3lJf0QbsyrmMW4GyN7
 R90ZP3bqXJre1kdji3bo47kANiD9sZ4VQIameA==
X-Google-Smtp-Source: AHgI3IYc5KwnKwWTPjuSEh0Jb6BJKJjJqoLCQHyqVWbwXcDTKJW6hDOXo7TxrUH90dYOTrOhG/NulED6sADu7X1ZNFY=
X-Received: by 2002:a37:4a84:: with SMTP id
 x126mr20785022qka.326.1550585654176; 
 Tue, 19 Feb 2019 06:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
In-Reply-To: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Feb 2019 08:14:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
Message-ID: <CAL_Jsq+kqFrY3DoHG_TJCCSxVHRkin4OwM+F9qm6W0w5YfjPQQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_061420_582361_C088AD7D 
X-CRM114-Status: GOOD (  20.78  )
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
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 3:24 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > new file mode 100644
> > > index 000000000000..8357f242ae4c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > @@ -0,0 +1,35 @@
> > > +RTL8723BS/RTL8723CS Bluetooth
> > > +---------------------
> > > +
> > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > +to upload firmware and change module speed.
> > > +
> > > +Required properties:
> > > +
> > > + - compatible: should be one of the following:
> > > +   * "realtek,rtl8723bs-bt"
> > > +   * "realtek,rtl8723cs-bt"
> > > +Optional properties:
> > > +
> > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > + - firmware-postfix: firmware postfix to be used for firmware config
> >
> > How is this used?
>
> rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
> another is firmware config which is specific to the board. If
> firmware-postfix is specified, driver appends it to the name of config
> and requests board-specific config while loading firmware. I.e. if
> 'pine64' is specified as firmware-postfix driver will load
> rtl8723bs_config-pine64.bin.

We already have 'firmware-name' defined and I'd prefer not to have
another way to do things. The difference is just you have to give the
full filename.

Also, on other chips with board specific config blobs, there's been
some discussion of converting those to DT properties. That depends on
you knowing what's in the blob and having a reasonable number of
parameter to make properties.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
