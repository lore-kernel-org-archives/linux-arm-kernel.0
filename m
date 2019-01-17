Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B269C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0A520859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YxIAZ/me";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u1f7OpyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0A520859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kma+bSSndUm2owDi2lDDdOzHxOLHg5IfNZS5XdEnqhc=; b=YxIAZ/meFDVJEQ
	l0vUm4bl+KhFmYmJgy0t6onnKZ8xCRER14Zo89kdwqq4jvw4hLDmnS59mXl71gvX5cpi3IQQJ3T1I
	Mo9NQHTSn/kMYiuSQpfkXv+beiZWvHQKmRmTLem8utSKoHowLJBlqA4vWJtY6DDX+vatFFCH8IJrB
	rHmQbSUsg+xJwIG66JlWMOzgqyBZ1Rhz4ObRn9pz+m2CBvAeulJGnSE3zsSTCiRM+ZwICv+tGAD3Z
	D3XTxqGs2E306TucEierV1R7OmGaOdxDxuj2xMFpNSSZtDUEZqgRLgyR1omcWgf/6amVEqBaRjDO8
	Qi+D6DaMs0vPa46iZFdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkDO8-0002HB-EI; Thu, 17 Jan 2019 19:31:40 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkDO4-0002Fv-1k
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:31:37 +0000
Received: by mail-oi1-x242.google.com with SMTP id t204so7086024oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WPiKxAsqViOka5al7bPffF5qlXbjgAKnpAeml+B0w3g=;
 b=u1f7OpyJbnr59QVGAIwHouOJwBtVaKjRp+hk+Wv5Ec54epZnUL+R54In3pDJMGaiMn
 QAsiPdxBm8WAoPLkmmqa3UlVLaprI/f0n2tEfUVKiTANV2T7RpLCOeDGDk8eIb9XuUP2
 3HnE2GWPiDfZwNx9JFT9tDd3MBzz/mi6iSLZZOIO+agyl1rtUINw9MClO37OazgD2p9L
 hj7GXE/b52/q5MuOzJpnBK+DCpPIWzapnrFQhRoBo/spTOKCDED/XhaNg721K2DGqJN9
 DSAjGQmaTiGZ/ujaKNs8EghnCzDM0N9P0jM+s55/fgJotCiyG1VnW8nOFdMbOiTuR/Ka
 8JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WPiKxAsqViOka5al7bPffF5qlXbjgAKnpAeml+B0w3g=;
 b=WGKZfd4Q3JckrtruQQxy4fiske/C29aKVMVvHJioiqk2B0jheHnLtIPpj8ciO5Sddx
 8YLOs0oYux9V4dakYPTJwV2EgNICnOAakP680cwQuLnCKRvLmwt7JDb63NFPAl5eeWUx
 A0KVjrGUGZoiBdCfAFl5ONoAnX3jLPLdoXKNUnmLVnN8d9cRG55h6KUZ8T79nCOYZTlv
 tNSX5gzybBou4gpPQu5PfGhk0uUa9lZkQOPSLDxYdYr233gONFTKfLeTtSqb6jHLENJ8
 FVmIBcthPlndmWxi3uIZxSzsPgS1UgZhxicAD+BFlmmExPCdNRPruvSZXsDHpoP6oH4T
 pGSQ==
X-Gm-Message-State: AJcUukc91GMA5CibltmLnGMxvIfpoSXSaY3+CHfFUFvLNaGVhL9iTcCZ
 JhbZegGVSavFAEMOPVdPDUnbpz3x47dUdDUvv+5u7A==
X-Google-Smtp-Source: ALg8bN4WKVDYuQlVLhDdco5RGZUyqNHyxIJjjpcj5lidO0QT8N4meb9MB8KM1KPf365dhI3dGr9sabL+/+yGhj1UZiY=
X-Received: by 2002:aca:720a:: with SMTP id p10mr645392oic.169.1547753494203; 
 Thu, 17 Jan 2019 11:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
 <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901161112090.1655@nanos.tec.linutronix.de>
 <7hbm4fccb1.fsf@baylibre.com>
In-Reply-To: <7hbm4fccb1.fsf@baylibre.com>
From: Kevin Hilman <khilman@baylibre.com>
Date: Thu, 17 Jan 2019 11:31:23 -0800
Message-ID: <CAOi56cV2j-ZKuJHLO3+1MArSJjXKLJm4c4zFE4xLzMq3UR_iYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
To: Jianxin Pan <jianxin.pan@amlogic.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_113136_098652_0539C065 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Carlo Caione <carlo@caione.org>,
 linux-amlogic <linux-amlogic@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 11:29 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> [ + Jianxin since Yixun is no longer at Amlogic ]
>
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> > On Mon, 12 Nov 2018, Thomas Gleixner wrote:
> >
> > Gentle ping.
> >
> >> Yixun,
> >>
> >> On Fri, 10 Nov 2017, Yixun Lan wrote:
> >>
> >> > +/*
> >> > + *
> >> > + * Copyright (c) 2016 BayLibre, SAS.
> >> > + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> > + *
> >> > + * Copyright (c) 2017 Amlogic, inc.
> >> > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> > + *
> >> > + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> >>
> >> There are two things wrong:
> >>
> >>   1) The placement. See Documentation/process/license-rules.rst
> >>
> >>   2) BSD is not a valid license id. You really have to decide which BSD
> >>      variant to use.
> >>
> >> Please get that fixed as especially #2 is broken. The goal of using SPDX is
> >> to provide reliable license information for compliance tools.
> >
> > This still is broken:
> >
> > # scripts/spdxcheck.py include/dt-bindings/
> > include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
>
> Jianxin, can you fix this and clarify which BSD license was intended by
> Amlogic?
>
> If this isn't fixed soon, I will cleanup and remove the BSD part and
> Amlogic can clarify with a subsequent patch.

Oops, nevermind.  Looks like Jerome already did the cleanup.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
