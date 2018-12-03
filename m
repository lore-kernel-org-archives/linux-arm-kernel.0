Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8292B204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p72zH10y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMBo67uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8292B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VjEqFfuZUjfdSFOr+YejMruc2LEYJutOw4zOLexAoWE=; b=p72zH10yQ0b9CK
	CBj05gGf6zSjOfQRPh6TYsnThLbDDOVTtt09P4XdFJjHYsgLNE8CqOr0pHIn8xoxme5aqDJ2nbnJm
	3HbRdxByYHrAusz+ibt52unRnnerKGB0rVLrozK/0sr8gCtix1jzmEU6W5gf1wqLq8eBJ+hnFIErJ
	wYtApvg/DYerR09k57TgH0rQGagHLog2TUbulUzfbFn7FyzgMIEsrSaa+iXpEd58cfZX7nmM04fPm
	GXp+xSWVLi9TaODd+q2mQbKAYN4bNBtX5OjbNiGqpb7H+WXrPtXt4t8iFgKAWZPLdkHRLntFUGiNK
	QN1OjdswvpkGXZ6x7R8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmBK-0004DW-OB; Mon, 03 Dec 2018 11:14:30 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmAq-0003PP-2r
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:14:27 +0000
Received: by mail-oi1-x241.google.com with SMTP id i6so10521920oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lJhPkqbemsu/Gscn14MFiWsyxw5AFHX4bvaLNq9tY5Y=;
 b=bMBo67ujcxYh8rHzNNSFgA2dhRfx3DEvK8aiidLX2tNueGfKyJprxTrRv4PyGQ0nvD
 oltMjXrWsjX3wQNpseQCFrhO3/9oxqfrngvesjA0BvlmXZw8rx9Vom7zWkUSjmCWNMYh
 Ua/cDQdp/hhiWExHSH2X5t6wSo5DDhePv1eGv70HUxj7S1mEFM7o+DRWnRj0vREsts3z
 k/oT3rD0IlEO5dz0XnUUASL4lIIG0MhiFNIDvipJpuNlBvkumPSzKvfgHf8ALwvfU9cw
 ejSv7EsLZ7CEzb++/XX5/8hf9zbtADg+vBOhmSfQCF2GFeDskeVvyqmPa68XEU/R4oNk
 o6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lJhPkqbemsu/Gscn14MFiWsyxw5AFHX4bvaLNq9tY5Y=;
 b=gzfQ3hRkzu4QXv6woKa/bd1zwm7OMWFnobLHl37fSoYUSnLPkiYkiDDdN5QRD7tMBr
 b5kV9SwWd6aaX5rRX4uK3LrN0bs0jFR7hMV7dKrepq7adKhgDc2gcksKss+Hl2/X0IOa
 djBhC++AoNCOk0wM1x1rgRktF/A+tNjaoE1B7dtwa/c7TTtx5Px49cTuMJMT0bmEld3e
 lQv9Ro3EYOa5kxHqrJ6CZ/s+ToKD/YyrAb12lFRQbG/g0YfMAlkHCVT0mOjv2I2RJ9Og
 ZFjq6ReB+9Lg+l/x/35yeP88wIxFeI7dpmQPkHjX60FxTCAaJ3/G2HQeKh41jDkHu5q9
 gLng==
X-Gm-Message-State: AA+aEWbEip2FsY42Ekf36OUH1SX7CpF9nWkDGu+gzZbXwLFMVdEGXgRp
 2nUjB+Vp4at/rjRStT058uK4NUeVYLzhYo58EUw=
X-Google-Smtp-Source: AFSGD/UDAK/GF+/q/fi9nzGAkqJYykL0Whiy0kgcATEBA2m6bXDDkTYnOTdtXpPtx2TxXUUeors0/lOhpjCmIiSgzxA=
X-Received: by 2002:aca:6155:: with SMTP id v82mr683718oib.259.1543835628797; 
 Mon, 03 Dec 2018 03:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20181113121213.14296-1-lukma@denx.de>
 <20181126143619.GB31334@dragon> <20181203103333.111c2463@jawa>
In-Reply-To: <20181203103333.111c2463@jawa>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 09:13:50 -0200
Message-ID: <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
To: Lukasz Majewski <lukma@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_031401_103723_75A18498 
X-CRM114-Status: GOOD (  11.61  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lukasz,

On Mon, Dec 3, 2018 at 7:33 AM Lukasz Majewski <lukma@denx.de> wrote:

> > > +           72xx165@0 {
> >
> > Please use a generic name for the node.
>
> This is a bit tricky.

What about using 'gpio@0' like described in
Documentation/devicetree/bindings/gpio/gpio-pisosr.txt ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
