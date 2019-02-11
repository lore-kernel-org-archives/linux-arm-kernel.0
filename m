Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5DD20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDXCmMxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5DD20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qFWM6sT42hawjIRKmeM4mOcAyVtzlNhOPHn/0HqwfNQ=; b=BDXCmMxXyEW4xr
	fWmrRYwTQQ9+hIa9FP4KjmoyK5U68X1s/+4Nz9g5KIDGiO+V7Mc1IDqxw5eKIHFwgzqhqOECwXEIA
	ec7RP/k/F0Y0wE4op0BrjA9yF8Ydckxz0K6cJx3lH0RSPGcQlY9IkzMGfmzgc4jzBdmj88mULbswh
	62/kpGzSQQhuWPRUWgzglfAepYU18/ql9hTgn6jLvyAyl2Dz1K9MLfKVme60yztzQrR8FSs2FWFg0
	1rI6ywEosUcb5gv+Ib0dthlQxX1obPIvFFq1GB/A/toEfm57s2Kd8OOKOqHLVlmILinKJfOGDG97s
	LgNrOzH4l3V5ANQIviUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt72T-0006R0-QG; Mon, 11 Feb 2019 08:34:05 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt72N-0006OH-2T; Mon, 11 Feb 2019 08:34:00 +0000
Received: by mail-lf1-f66.google.com with SMTP id b20so7026755lfa.12;
 Mon, 11 Feb 2019 00:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DXRBrZfleR9tkrKooKw/mjJvBRgchmBHV3mJTc0H0Cg=;
 b=jdMPyr1g75xe5oiftcIFejea8oCa2I8YnNfAXm6wxxehpw0m8+DBgq5sF7pWqQWDW6
 3e3USB85Rl2cforwX87MFoO2m0weAy0kUzokrJa8BMDFKAzpo0zNrlcIRh9P+kUdXJuO
 /Pw6yR+geIMPu3UvqOVv+Hx7DWEBLrguRoZ+H5OrNuCkURLQQ2B1RmbbWiEGCWq916xG
 e7ZrY5Fo7dxHs7OIIY3DjisVhfndf2aBYCWbpH2sho2IbY3jZW5owaFHiQ6vS0FHvglh
 gAOmcRtWGRspyeBkrdWsjffgba9MdDmXYmpSrBB9S8z2786MIDI9ItFhWYmp/RMn9/Vm
 UD8w==
X-Gm-Message-State: AHQUAuY6FigrHeQoQGAslGWglACblcC4YjmWneG35meQFsGe294TsB6e
 ypVvNq1r05hTRWUmZG8k5P0=
X-Google-Smtp-Source: AHgI3IaNzz58l1AYM1ozG1ZRxrZUYIsaYnBjmzsNy8Hca5hFmaq3Y8kJKEr03zDF3SLJc4PJJE5ejQ==
X-Received: by 2002:a19:ee13:: with SMTP id g19mr10611671lfb.72.1549874036291; 
 Mon, 11 Feb 2019 00:33:56 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id z6sm2138830lfa.87.2019.02.11.00.33.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 00:33:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gt72D-0004pO-Rw; Mon, 11 Feb 2019 09:33:49 +0100
Date: Mon, 11 Feb 2019 09:33:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190211083349.GU4686@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <867eeo7pjm.fsf@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_003359_157144_8F43A5E4 
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
> 
> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
> 
> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
> >> Add binding for Mediatek-based GNSS receivers.
> >> 
> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> ---
> >> 
> >> v2:
> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> Moved current-speed as an optional propertie.
> >> Removed the status line in the example.
> >> Added "mediatek,mt3339" compatible.

> >> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> >> @@ -0,0 +1,39 @@
> >> +Mediatek-based GNSS Receiver DT binding
> >> +
> >> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> >> +vendors and can use UART, SPI or I2C interfaces.
> >> +
> >> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> >> +properties.
> >> +
> >> +Required properties:
> >> +
> >> +- compatible	: Must be one of
> >> +
> >> +			"globaltop,pa6h"
> >> +			"mediatek,mt3339"
> >
> > I'm not sure it makes sense to add the GPS chip itself as it cannot be
> > used stand-alone AFAIU, and either not way would require a lot more
> > resources to be defined than what you add to this binding.
> 
> OK, I find it a bit confusing to have Mediatek bindings but no
> compatible Mediatek SoCs.
> But it is true that it can't be used stand-alone. I will remove this
> reference and also remove it from the mtk.c driver code from this patch
> serie.

> >> +Required properties (I2C):
> >> +- reg		: I2C slave address
> >> +
> >> +Required properties (SPI):
> >> +- reg		: SPI chip select address
> >
> > While the mt3339 appears to support these interfaces, the globaltop one
> > does not.
> >
> > Have you looked around for a small sample of mt3339-based receivers, to
> > see whether anyone actually provides these?
> 
> Again I'm confused by the fact that it is the Mediatek bindings.
> Hence why I have added it and why it was not present in the v1 that was
> only for Globaltop.

This is no different from the sirfstar driver for receivers based on
those chipsets but manufactured by various other vendors.

> I find it odd mentionning the chipset but not all its interfaces.
> I will remove these sections and only list supported interfaces (i.e.
> UART). Other interfaces can be added afterward if one finds a board that
> provides them.

Right, but please do look around for other receivers using this chipset
so that we can make the binding generic enough to cover those as well
(e.g. by choosing representative resource names).

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
