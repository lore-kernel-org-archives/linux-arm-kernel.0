Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F261E213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oulbeZrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F261E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O9XtdnIDghv3JknfMnoDG4nA4eM8gQOElLfSLK3Oicc=; b=oulbeZrDvrT8i0
	0YeTTGTT0ld+ucHyPWCnurrbrj7IgLoGBMg21pn6eytVHD5J7GqaaqNLaKTSmv4jfTPBOHyvn0m41
	V6TDM9Tc8FoWXnDfMmUjaJMyb2rT6wCfLihayOMkAt5Gs91cuhmIPGISDwtIKI8O6ZRaHXk2GL0Dr
	bs42JLGyS9cwlLr8K5h1cHdXaD3jD6ayqfEdse6vCToVxVk9YYjm3TcAHvyo5smRs15chIIaxDZFR
	KT38ob587rlvHdt+c83tZQqHRYNUQ7OYBjc/jzxBJ0DJFD2EGsGuEwp+yRR1p3jG0gJ+BdmjuNn+x
	SredRrSiendtBQXP5h2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUjve-0008Gb-Ti; Thu, 06 Dec 2018 03:02:18 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUjvY-0008Fp-8M
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:02:16 +0000
Received: by mail-ed1-f65.google.com with SMTP id y56so18773120edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8vChUQErCySB5pPQauDNCeDK4RanyGb3OBR/VfuVN84=;
 b=LFgxbWlaM1vqVlQL4zXgs0fcn+ta4nk0gwhznuvCiakp4VgcaM60PPfOMMSVetrM2z
 j+iNP1vs5d9Vr6V6ereG8o2UPtnC4gPC3TOgXh8GwIcrhvFvl3VkTFpP5NNgXUHRs5aL
 JdZvQfNd8IlVWoRjn/7RQ9GXGyUBmk2fbrazHSqbTivoavYBRYbcKW0PbHWCb+4lS1hC
 icG9BC/7imZNrfK2f4tBavClQsmxMRDrv8H/EjNyBF8j91RwQA/JQ4a5q72GVVPcoZXq
 qA1YnkJzu/mVOr5etwZGoqcyeLGKOCEwfJxm1RpAn7XuBsf4jCm3snGv130ghnn75zid
 M1Rg==
X-Gm-Message-State: AA+aEWYvt7TyNBcx5bQ5gvQHlXb1OcKhn3LeXqPVwNe0DfTYq0RN9h0P
 4IXtYLxYG3gmCWFxbHtM2PMUjsXl6dk=
X-Google-Smtp-Source: AFSGD/U2HVX0iDNo6hy0DAPDRn09NcT/FS4Wywo3Qj1G2Z4r6zY50rZJ/vnR9OusKz5LLTI1PvVbHg==
X-Received: by 2002:a50:c20a:: with SMTP id n10mr24022569edf.60.1544065319581; 
 Wed, 05 Dec 2018 19:01:59 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id p1-v6sm3327107ejo.49.2018.12.05.19.01.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 19:01:59 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id y1so15202558wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:01:59 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id
 t200mr17777709wmd.111.1544065318756; 
 Wed, 05 Dec 2018 19:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com>
 <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
 <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Dec 2018 11:01:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kEStHyg1apCsDcAEVk6Gr5xiJ4tV50+0TL2k+CZwtjQ@mail.gmail.com>
Message-ID: <CAGb2v66kEStHyg1apCsDcAEVk6Gr5xiJ4tV50+0TL2k+CZwtjQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_190212_298687_1EC27340 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 3:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Dec 3, 2018 at 4:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > vcc-supply property is need for some Goodix CTP controller like GT5663
> > > where 3.3V external pull-up regulator connected via controller VCC pin.
> >
> > "External pull-up regulator" sounds fishy. Chips have power supply
> > pins, either combined, or separate rails for analog, digital, and I/O.
> > For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
> > and description you provide match none of these.
>
> We have vcc pin in the connector to supply vcc-ctp, but indeed it is
> AVDD28 supply as per the reference schematic design[1] Page 23.  Host
> interface has AVDD pin which is connected to ADVDD28 on goodix chip,
> so I can name this as avdd28-supply. is that OK?

Yeah. That's better. It's always best to be precise with hardware
descriptions. If you simplify it, the reason should be given in
detail. And it should be a good one.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
