Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5275C2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KVFUCMHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5275C2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1hmA1P2m4I3H2N3ViU+34vtV2qa1OpyYy/QjfFBYem0=; b=KVFUCMHcxqgJ1u
	3Nyc9d9p7FbjKNITIKTkXpjw3tLjq2ruatMVmR6mEQmfJZX9Z1OZlmjFG0KD/ORJ4bh3LPOiYb4Ro
	EEZJBBi+kQWtdaCCcH4nSkvfuuNj3Pmp8Oz6YdxGOiN6TiCsljd1Wk2aDHwIoWiZSD86PD/E/NM17
	MgBnIwIwf+IzYu7qY9VMegZGCtkfnOSy/8QCbWZjXk9Z+sX4LfVr/BC4fkmBDkTIyAox/bEYnvQhc
	R9MMc8kVNEa2V3Votp0PAaWI7EtfgwLKk3EGYmaVML1pkFCPs16IJwHU3/hOFzLSchA4D5XsJtEZR
	R4FCs56q/1QCx40IMTfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvf5l-0002xg-83; Mon, 18 Feb 2019 09:20:01 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvf5i-0002wQ-1d
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:19:59 +0000
Received: by mail-ed1-f66.google.com with SMTP id b3so13245889ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/XrklYpNWnYcNWVDYLyQUagxKF+mFK8VoH185hzGYac=;
 b=ODbdp8TW8kxGGkNp73xmGEgiPLcOeyiACtp/3tZU7acquAgcxv0Ma0eb5Mu+p7cRlH
 zu0m+dxgxRyMQ+sJPmkJO//EKcTIIfnSuGM1k4n1kCqQ7qRuLycfIeHA6J/4SQPaEaPE
 +g1ZZAmod8a0hy271Mlt2QO8B7gmUQoykO7HKe3Yzo/2l980XuQXwPJhe36lNi6PHp+6
 MaZmI3isGUpf0FwjCf/sIXsS5oUrVuxd7CoovmAvkV1eW+HkLka9cCpdF1DJFjf3XM/8
 4vF7Q4BX1kGblhmnAFglZoKVbyEIFtC54MBH0HbrjxIePNDFr/S4iya7ZX6+2oe+V3Xd
 QxBw==
X-Gm-Message-State: AHQUAuZjQmswgpUlK14lPQfAVFI7zlXccVfcItMNHYeLzbV5LkPY71DH
 UdYeDFLcSyK24vYfgYbvlwxg2Ksso5w=
X-Google-Smtp-Source: AHgI3IZewjmRNyUnB7CgELm8ubXIjX+eFWkKAa0oUYP5uktNcPwxLNzafQUhfF4ZTXo1LRHic+cwpQ==
X-Received: by 2002:a50:c299:: with SMTP id o25mr18568058edf.281.1550481592427; 
 Mon, 18 Feb 2019 01:19:52 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id s3sm2920380ejk.34.2019.02.18.01.19.50
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 01:19:51 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id x10so16130725wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:19:50 -0800 (PST)
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr14993134wmb.14.1550481590283; 
 Mon, 18 Feb 2019 01:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
In-Reply-To: <20190218084931.fdut6d4cgwkwvihx@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 18 Feb 2019 17:19:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
Message-ID: <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_011958_087324_667D157E 
X-CRM114-Status: GOOD (  20.61  )
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
 devicetree <devicetree@vger.kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > Add support for H5's SID controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index 570a2e354f30..036029e90921 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> >       .size = 0x100,
> >  };
> >
> > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > +     .value_offset = 0x200,
> > +     .size = 0x100,
> > +};
>
> IIRC, there was an endianness issue on the newer SoCs, with the driver
> converting the data from big endian to little endian, while it's
> actually stored little endian in the SID.

About that, it seems the internals are either little endian or native (same
as the bus). Either way the nvmem the driver currently exposes is wrong.

My idea is to keep the current one with the current name, but have it not
associate itself with the DT node. We then register an extra one, called
"sunxi-sid-native" which uses the native endian. This one will be associated
with the DT node, so the THS driver can consume nvmem cells.

What do you think?

> Have you checked the SID content?

On the A64 and H5, directly dumping the SID registers (not using the H3
read method) shows the contents are little or native endian.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
