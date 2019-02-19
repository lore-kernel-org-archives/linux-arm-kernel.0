Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F3DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEC720859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DeQ/+dO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEC720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=obr0q7tbO6HKZ88lm87vi3ZVvJmNH1NpMlR9oyoefyY=; b=DeQ/+dO2EzA28X
	pKGYrICzMmIfz/U4BrB+oZsGo4rJCwLqN/W6F9RIg7BwvYpCc8lkFV3YkJqAYJlLbn/+xzUcO3zwA
	x4O7kEVcruskW5ZqpVCbOutazX0aAC8/pQh9OnHY/xnALWhumR0LD9BX4Pj0XNT3LtOi6WxFRsXPm
	oKN9nNraj0aT9rnIjs+2gDRSuEoGZRVOkz6l1gBd8gbaQb4uW9+ieWcUF3fSlrjzqtmtbuY1xCrkP
	zSYqqsNg/m4He0ieYH/aCo/2NALtgRLfJ2QwZbXencSVonxSkQudPFPF7YBd80PW+kv1Q7lKZ3Vq3
	5WAYFgRBv7VMBrBC6S1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw708-00025N-J7; Tue, 19 Feb 2019 15:08:04 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw705-00024q-3j
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:08:02 +0000
Received: by mail-ed1-f68.google.com with SMTP id h58so17013281edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 07:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BFn/4GR4Bz5NDgNerN/E5Ph/9HPk+yTnw35wM0/aLec=;
 b=g/yIBTsCnoWrWw+hw2p+rTY8pyabC3rq1AnUMgeLmYlBmdd/eIYG7vo5MefdJSdVd6
 vweXJXtaKD1w4mufDzVy7as1Zyr8aMeV8q9FEZIaNi9H4Xznsn2sebh7UFM5KjvKG/7v
 I/CKgR/01/gOyHrowrsHw7Bb+d7Lp16mhXdHFqs4dIxMC1FaehJld1LveSUGg+q3yZwn
 VS8nnZgtFaldF4OS9j73hzQAfryUfg4YzHwvPy9lE7KrQ8mYt7WVucd9SjhhZGoLl/O/
 O73SjiZ7suzoaVz5+gdmO1bOjdnF0f27jQXquOWokQrENrazT7WmLLZ6OosxnhIfnm2T
 gl8g==
X-Gm-Message-State: AHQUAuZTm4VRMKx1TfxIRts6zSqfdhqo7ILB9Jl+EG9buQ8uOUM4QcU3
 y1RrUOHiatmUDpUvTEqYWp2WP+Jb/LA=
X-Google-Smtp-Source: AHgI3Ia/ruxKr1E4TIFBPu9ZoJSwLR7g0MUnVurG01sLm30tDf2ywOYslRHnYj4ktIxrVbBPFtptIA==
X-Received: by 2002:a17:906:1508:: with SMTP id
 b8mr20644588ejd.48.1550588878203; 
 Tue, 19 Feb 2019 07:07:58 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com.
 [209.85.128.54])
 by smtp.gmail.com with ESMTPSA id v5sm5006443eda.89.2019.02.19.07.07.57
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 07:07:57 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id n19so3188902wmi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 07:07:57 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3370922wmc.116.1550588876908; 
 Tue, 19 Feb 2019 07:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
 <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
 <20190219150311.yfqkr5svs6b3arjy@flea>
In-Reply-To: <20190219150311.yfqkr5svs6b3arjy@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 19 Feb 2019 23:07:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vtTZy7yWcaQ2xKXzU1Jem7PW_hXaWZ9GjT+j0uFOt2w@mail.gmail.com>
Message-ID: <CAGb2v64vtTZy7yWcaQ2xKXzU1Jem7PW_hXaWZ9GjT+j0uFOt2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_070801_153704_140801F5 
X-CRM114-Status: GOOD (  29.94  )
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

On Tue, Feb 19, 2019 at 11:03 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Mon, Feb 18, 2019 at 05:19:40PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > > > Add support for H5's SID controller.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > > > index 570a2e354f30..036029e90921 100644
> > > > --- a/drivers/nvmem/sunxi_sid.c
> > > > +++ b/drivers/nvmem/sunxi_sid.c
> > > > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> > > >       .size = 0x100,
> > > >  };
> > > >
> > > > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > > > +     .value_offset = 0x200,
> > > > +     .size = 0x100,
> > > > +};
> > >
> > > IIRC, there was an endianness issue on the newer SoCs, with the driver
> > > converting the data from big endian to little endian, while it's
> > > actually stored little endian in the SID.
> >
> > About that, it seems the internals are either little endian or native (same
> > as the bus). Either way the nvmem the driver currently exposes is wrong.
>
> Do you mean that it can be configured either way, or it's little
> endian and since you are running a little endian system you can't
> tell?

I can't tell. There doesn't seem to be a toggle for endianess though.

> > My idea is to keep the current one with the current name, but have it not
> > associate itself with the DT node. We then register an extra one, called
> > "sunxi-sid-native" which uses the native endian. This one will be associated
> > with the DT node, so the THS driver can consume nvmem cells.
> >
> > What do you think?
>
> I thought about this some more, and I don't think anyone really has
> used the sysfs interface for it. Since the data are in an unusable
> order (without an additional conversion at least), we would have had a
> bug report by now (just like we had when someone tried to use it for
> the thermal calibration).
>
> So maybe the easy way out is just to disable the conversion on the
> affected SoCs, and see if anyone complains?

That works. And please see my other mail about the DT nvmem cell arrangement.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
