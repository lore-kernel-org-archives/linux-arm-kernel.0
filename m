Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B90C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE0521479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRY0W1cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE0521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cwn7M+Sqzrr5imO5sAANwdjPW8XY0snOEg7qqKwomZ0=; b=kRY0W1cKB2zLyu
	vnuA8aK/7H9TQPb080CzDqLkkJSMHh/9gHItG+y+0uBdtcU5XpPcGtXSuz62GsMxaBqeb070NTI5C
	oPqYgMYexM6FvHgn+DesMxCcB68E/1CC/oytjd7LQ34GuXV4BpsPYCDe9pllAANJ+0lCQIhz6n+2j
	t8Y1ot83upocq+ZVVKpfgJ496WlozgaYcSZDw0OhkSSKFnAaYBusG14qXrmO+W2/LajZi6me8D5Zk
	Mt2RXeJIXZHjbVbyHFruO4leCkdGPwyVjWGa2SZ5/9wIzMU9rj5gDh7YAUsT0ToQRfwcTndXr5xVe
	OAQJRNsXQxspeJ/SEJVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvr5f-0000it-ED; Mon, 18 Feb 2019 22:08:43 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvr5b-0000hn-OE
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:08:41 +0000
Received: from oxbaltgw06.schlund.de ([172.19.246.12]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjGV-1hJKHD0Mkl-00lCIV; Mon, 18 Feb 2019 23:08:24 +0100
Date: Mon, 18 Feb 2019 23:08:21 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh@kernel.org>
Message-ID: <1245842044.588056.1550527701604@email.ionos.de>
In-Reply-To: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com> <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:hpiBGz7VzNd13L68dk3OIE0bSiUdUGgES2sdD0Ta2wZeLgL5O9P
 zb3uOfjlIVcJm2T021uSg53MjpH3YJg6q7/tlDVBD0ijj8Vdd08mMP+Hs3Qur5oEtESBuLj
 4car7rYsT70uRdSsajUY2MhNLdUSJHMUNl4kGtre1OvF6sB2pg9GIenw8K7ujfSB++VpubN
 lYrKbpP8hBKIf1cd80Qow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EoZFOG9CfBM=:31fPYIbn5PGOn6ENVizar8
 qWenbuUUgl/rJFpH86fYCsbTpEqRXyMTD01AsTVNv0xXGoixRxI9Uh1dDUoxfh9VMc/gGtcSY
 8+8pOSNqVLE042BO7rboeaAv4Ek1BoJokqO3d+E0LTL13JZrJyOmWGoujg6p28HtfCu3GjoNB
 kmyCjcRCbDPkCHyg6kU4tOCuFsTemNwhhQHuYbin21OdTNxgemqhgIvDJ3+QzBW1XllADJ/rS
 Sd8tRiMeqknS8IUBoLrsgYqw4VAo1SDmGWcKPAwdBA74A7qYiY7EK/tnb4ZX/0WB+Fe3F/EKH
 joyjdqAAAjlAzuKEAjFl/1EW9PglO3cHw6w7kWrlVYSffGzohDIBppHT0iyG9QOCpphmOMGac
 FNr7ztrLsJiWyaRT4nSXsXTL75w7BtktaPWCT1y3fxR62yBir7gzW+EsnUGAnC2GCMbpEwRO8
 NUmMBn6RHODL5L4VQ7SsmiXrS8+nMqPOSfVLIZFmlv7O3PyYYz+KKQ9M0fFdJaRKuui+/ynRj
 xGEc+gLsQqqNT35+u3IcA7tshfoEpyNokYQHpBIP1enT2XpID6hkV204YYVQG52HpyrhxjJTK
 19pP+nD3tls7uyHwGnCGeNX8nNF2Nw0Fn/XtbiyPRITJjYJZ1teSVZSOUFowcUJ7SPmDA+Hc1
 ntTpit5YyDaK8UR8eYm/4ejYJUAJ5r6cMmiAMf1Bi+vkDrRKUP1K5MGoYEOXH1akKfOK7yb2i
 PH/MOippCldM4DI/p1Ci5vsvIKI82veH7yzDF6Nw68C22H+i4SmGUnRNkHw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_140840_085058_39832E1E 
X-CRM114-Status: GOOD (  19.40  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, beagleboard@davidjohnsummers.uk,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 "David S. Miller" <davem@davemloft.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vasily,

> Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> 
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

sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.

I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.

Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
