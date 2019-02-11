Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84DE20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9LzzubZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kKbBAkdlgGTCNN7nahoipRT1L//R1N6ERbgipVs9r/w=; b=M9LzzubZCjIgE5
	c5tCrzo762zv/a95IBeL+0W4L24Ydyj3tj08tZcVblYwqtiopz887ltAjGrxB30+D7d8h3X8Gq9kl
	VD2M9m0ajA7hL6d1d88Nt4TyBF7bLpy1HpYheP0DY2uDSZb5P7s0EfBpjdg19sgvp/qkO0ENJhhHv
	Qu6+5Mz9rkhswPSjpiinAYj3osk2vATYdF+NFmfxcScDNWP7Laq5L2g7m4yRINVrNQvt+jBJAl5OK
	Ud6ZXl+NkRGdm5z7+aFI4Z5nYzNXupBoBe7lGCTZoc1Hw34As2vVaG1+QStCKRVDtCJOg5x1fkp65
	72bUVeR3o9qxln2s9mcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7pV-0001Tf-LG; Mon, 11 Feb 2019 09:24:45 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7no-00007g-Pn; Mon, 11 Feb 2019 09:23:08 +0000
Received: by mail-lj1-f195.google.com with SMTP id a16so4001844ljb.11;
 Mon, 11 Feb 2019 01:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=57cf3Lc6S+hV34hW4qWkEqcWBtCzdKYSCNE88tgbwFY=;
 b=r1qU9DBjxeXAa1TV6CTXu9bVhb//BYHTT9RsnlauYk88B93i0uJnxxfru7DzFBU7K+
 rHnZkSUY1qCoJ/x4tdTtX5ug45YxuXW6aef890Rm7iv+pmq+CRj4O8AM8G5d3YoMqbCS
 pvT4WCXWlAdgB1sfaDAs7HeZQbnprZ7oMX4MPoiBIChWc0ZdJOe1aZL+vh0o1QLm6Feq
 5rovvdmnxSD3HWed1vAMLMvezWBIZ7U/7mrGYA6ZK+bjAXh5LwHu83xXTjrJsmC9EcPc
 s+F0ZU30wX9bEutDTP4A+X8EgACALztGiZVwIoqg3rAv35FxxgyxP+wFsHL69bibjFFo
 PFQg==
X-Gm-Message-State: AHQUAubWMZJ4LAw634ZwGK0CnmZ89DDsv3Jsjr7mz8NVKk0T6Dc3dG7T
 xK/VURvHm7UDYGPvvhFAu+U=
X-Google-Smtp-Source: AHgI3IZD1jEIfdMVWIhhGklrrMIe+2SC7DYFGzpUnfPu5MYxGNfkzXRHYwnnblKbLxcOwTdZ1dZ3RA==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr2988166ljr.45.1549876978579; 
 Mon, 11 Feb 2019 01:22:58 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id a21sm1034696lfk.61.2019.02.11.01.22.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 01:22:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gt7nf-00058B-Ak; Mon, 11 Feb 2019 10:22:51 +0100
Date: Mon, 11 Feb 2019 10:22:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190211092251.GV4686@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130155016.GA26536@bogus>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012306_764509_43150BEC 
X-CRM114-Status: GOOD (  20.32  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > Add binding for Mediatek-based GNSS receivers.
> > 
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> > ---
> > 
> > v3:
> > Removed the I2C and SPI interfaces references.
> > Removed the "mediatek,mt3339" compatible line.
> > Added the optional propertied (reset, fix)
> > Added the pin names for the optional properties.
> > 
> > v2:
> > Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> > Moved current-speed as an optional propertie.
> > Removed the status line in the example.
> > Added "mediatek,mt3339" compatible.
> > 
> >  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > new file mode 100644
> > index 000000000000..00650d81c5c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > @@ -0,0 +1,37 @@
> > +Mediatek-based GNSS Receiver DT binding
> > +
> > +Mediatek chipsets are used in GNSS-receiver modules produced by several
> > +vendors and can use an UART interface.

s/an/a/

> > +
> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > +properties.
> > +
> > +Required properties:
> > +
> > +- compatible	: Must be
> > +
> > +			"globaltop,pa6h"
> > +
> > +- vcc-supply	: Main voltage regulator (pin name: VCC)
> > +
> > +Optional properties:
> > +
> > +- gtop,reset-gpios	: GPIO used to reset the device
> > +  			  (pin name: RESET, NRESET)
> 
> reset-gpios is the standard name.
> 
> > +- gtop,fix-gpios	: GPIO used to determine device position fix state
> > +			  (pin name: FIX, 3D_FIX)

I'm thinking we might need a standard name for fix-gpios as well. This
isn't a feature that is globaltop (or mediatek) specific, and other
manufacturers provide similar functionality through pins named UI_FIX,
or even LCKIND (lock indicator).

The pin is typically used to drive an indicator LED AFAIU, but the
characteristics of the signal varies from device to device (fw to fw),
for example, pulse when no lock and low otherwise, or pulse when a 2d or
3d-fix is acquired, etc.

I'm not sure how useful the pulsing would be for software, but someone
might find a use for it in some form.

Rob, is this something we want to keep in the binding, and if so, how
about using a generic name such as "gnss-fix-gpios"?

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
