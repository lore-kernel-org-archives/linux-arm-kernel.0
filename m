Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522F920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gbVbAfBt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BR8PF6xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522F920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16mBfEqHAtKexrcYaDRgAbLASnVoNaFyBQgq5EaasUU=; b=gbVbAfBtzk3diB
	cCWKEuvCWhAERUOmbXxL/rhr9n6ARnMZ74z4ii73Aoq0wI3/egi1/jVvYT7zkwMRHZOSvmzRdT9Ex
	8LubxuQlD++nEwhXbNVCzEsiYMXHUVI8DjHTRTDdCIDyYYbMexYi25SdlIR4Xr2kAopUeviZQtgx7
	vbTG9ePvt9ugHogSrd3NRp9s205xCf9z1ot2TP0dIWjHTmKERReyYcyE1SDqjIIWve821IlWFXKUR
	XRDsLGeJoSFjeM2YjUt0yhT3n0iV+WLiCvLKOjsPo1kZxPn5hdzAq/5eSRf6egVzFCEQ6pLOhDqyW
	CjsSnkbom6BuqfEpzyMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdID-0004Tb-AO; Wed, 05 Dec 2018 19:57:09 +0000
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdIA-0004Ss-1S
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:57:08 +0000
Received: by mail-it1-x130.google.com with SMTP id g85so23339079ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R5bxCp8tdl9AgBDIOZU6e2WTW7sx6vs4eL/f98FBrkc=;
 b=BR8PF6xaH55Tqs6pS6GvxerX3iq8R03J0y21Y/Yzc1yAwzuacu7KB+VfkjT4/A3opt
 aSOuG7uKZq0iezQNXEKlNXHEA/Dk8KJcTrnOVaOOLp+7Ue0gIvp92YtQNG6MHyTnRCex
 FTSlOESL7bp0BRsIPoRQmxZRTI0ARccmRP06U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R5bxCp8tdl9AgBDIOZU6e2WTW7sx6vs4eL/f98FBrkc=;
 b=jqkqV3tps+jIhd8zYt7/w/bpcgiMRYrnkMps0D068BLR6b/4nMtMpzHF1VXgYuwBEU
 4R6b6crY3j3sfiJqWwSm2VmmoVSf8FI0BR94yFizKB2rzcRvWOFCaD/xV9pHCYbgfCA7
 cGzseuEJ+BJMATiyjlcetTh/QYvzNKvNNfz6Zwe761ddNwNxn3ff079CNt1lsWsLSVtC
 RzuRCQ/ChBkUOo678lg4MOqQJfAts91IiJR1Yt18/dmIkv5peMRGXpZSMpxWPqACJEQW
 8rq7W8bvyiH2+wiX5QJrYxY0ZGV0XMJyKegaW787rswQtLXR7fTjKS21cE92y+azVyHU
 Al9g==
X-Gm-Message-State: AA+aEWa0ywBbMl5PCfLIPJUstGfcLnSTC28I/gwDESxuHIAxANxb6jMY
 XZCqmH3nECn+ICah7hnk8tA4sLijyuaJOPDdBJEKTA==
X-Google-Smtp-Source: AFSGD/Uw+vjyoG6CiT9HPywwihAVkmivGRLd9ZsQSEi06juBx+m7YOssqMl69H9Ayf3ftBUdSAXqRBl1xa+Hyr1Cezk=
X-Received: by 2002:a02:634b:: with SMTP id j72mr20146739jac.103.1544039814435; 
 Wed, 05 Dec 2018 11:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com>
 <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
In-Reply-To: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 6 Dec 2018 01:26:42 +0530
Message-ID: <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115706_562389_2B17A72C 
X-CRM114-Status: UNSURE (   9.44  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 3, 2018 at 4:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > vcc-supply property is need for some Goodix CTP controller like GT5663
> > where 3.3V external pull-up regulator connected via controller VCC pin.
>
> "External pull-up regulator" sounds fishy. Chips have power supply
> pins, either combined, or separate rails for analog, digital, and I/O.
> For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
> and description you provide match none of these.

We have vcc pin in the connector to supply vcc-ctp, but indeed it is
AVDD28 supply as per the reference schematic design[1] Page 23.  Host
interface has AVDD pin which is connected to ADVDD28 on goodix chip,
so I can name this as avdd28-supply. is that OK?

[1] https://www.crystalfontz.com/controllers/GOODIX/GT5663/459/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
