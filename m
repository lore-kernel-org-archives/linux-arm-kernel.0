Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0447C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:38:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22102086B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bpzNpghJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22102086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ezMoeRuNZxt31CzPmaJLVWJwP+Kl9rb1HOkdW7Cpsg=; b=bpzNpghJgTDVuG
	XPjhEMbok9XaeHeXfiE00iLgEhpI+tFwuLSJ11CHyhthLJd6azJDXZTIh11hRO1EOkPJzvXPz/j08
	e/X0tBgxnEgwuEVDmqA7zCpFz4WH01M2xqvCDfirjwb9QDSC51sPmcVqVU9vBcO9lO9jK8rwsSJKi
	SlmZE7F6QFr7V5kKMzwXQ+Usj4N2R8NFObUU1g5/iuy6daJjGBoljuDsPyc9MGuCbKB7Cwa/CSwTZ
	OQuT5mOq9MCuS79I4iztDDWgBOT/oo/mcCEWqsPYEG7mXV24GwNAhzmcH0R2k/Aitn6d6Iq6Hs5pI
	Zykm/7FcsSCUtSyeZXtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSZdm-0003Kt-E5; Fri, 30 Nov 2018 03:38:54 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZdj-0003Ju-98
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 03:38:52 +0000
Received: by mail-ed1-f67.google.com with SMTP id h50so3703811ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 19:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mG8evtSjAEIqTCabuI83P9ZLeSo+48+408z67jqVjIw=;
 b=kgnn1nOjnXztRNolKOgLdQ2JhHbl+lCtIzderq5FNN06O/h7ZN3Ol/kZO7tcPudVNg
 1X95uE7Kw1DtILx7VE7U4O9hQrqedpEJ7+PNS10Pmj5/jgWCJwujvQRhYoNBsCaeISUn
 n8cf9SPQ7KGyfg7eLMWM8V9ZJ+rUTXUe2Q7TOOKVjbDp50oT9lsci9TF+sbAb2KVj5Xx
 VKsNpdTv2ns8D+qMQWiGo0TmKP6j2ABn/RvSp+73ogDK5QGCDUDKtVlSwDVZY0bnFPbY
 QFpl9l0IC+rdlD3/pw6Xu975laAclPL2vKhP2muJzm5IX1qPlFlv6VQRy51Xt4ngstD+
 ZfGw==
X-Gm-Message-State: AA+aEWZmXBNhGiYekfn4c7gIp9R1SWIzUOZn5aD0gS1Nd/c/8BFuogNj
 zhOKNEKi3YRuYbeEYXSCzzgDmN3ZFGo=
X-Google-Smtp-Source: AFSGD/Ub40GYx6INHfCdLGUJOfT6bi1iRabgrFwsVV+cgvkgsfGCGnEfAMFC9fcTwINE7achToOA1w==
X-Received: by 2002:a50:d5dc:: with SMTP id g28mr3704911edj.226.1543549118614; 
 Thu, 29 Nov 2018 19:38:38 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50])
 by smtp.gmail.com with ESMTPSA id v20-v6sm599141ejr.46.2018.11.29.19.38.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 19:38:38 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id r10so3879577wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 19:38:38 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr3628272wrv.188.1543549117778; 
 Thu, 29 Nov 2018 19:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-8-paul.kocialkowski@bootlin.com>
 <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
In-Reply-To: <CAGb2v64t6t3Bwf4nc8gQWRDkdv4zGRF1-+Q7snqX6bkEVqirvA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Nov 2018 11:38:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Message-ID: <CAGb2v65yNKnqbeQmUYjMzDtydYL=7kxmtPrAEEU9U=a5XbMiFg@mail.gmail.com>
Subject: Re: [PATCH 07/15] arm64: dts: allwinner: h5: Add system-control node
 with SRAM C1
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_193851_321009_1510C1AA 
X-CRM114-Status: GOOD (  24.46  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 12:52 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Add the H5-specific system control node description to its device-tree
> > with support for the SRAM C1 section, that will be used by the video
> > codec node later on.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > index b41dc1aab67d..c2d14b22b8c1 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > @@ -94,6 +94,28 @@
> >         };
> >
> >         soc {
> > +               system-control@1c00000 {
> > +                       compatible = "allwinner,sun50i-h5-system-control";
> > +                       reg = <0x01c00000 0x1000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +
> > +                       sram_c1: sram@1d00000 {
> > +                               compatible = "mmio-sram";
> > +                               reg = <0x01d00000 0x80000>;
>
> I'll try to check this one tomorrow.
>
> I did find something interesting on the H3: there also seems to be SRAM at
> 0x01dc0000 to 0x01dcfeff , again mapped by the same bits as SRAM C1.
>
> And on the A33, the SRAM C1 range is 0x01d00000 to 0x01d478ff.
>
> This was found by mapping the SRAM to the CPU, then using devmem to poke
> around the register range. If there's SRAM, the first read would typically
> return random data, and a subsequent write to it would set some value that
> would be read back correctly. If there's no SRAM, a read either returns 0x0
> or some random data that can't be overwritten.
>
> You might want to check the other SoCs.

This range seems to contain stuff other than SRAM, possibly fixed lookup
tables. Since this is entirely unknown, lets just stick to the known full
range instead.

ChenYu

> > +                               #address-cells = <1>;
> > +                               #size-cells = <1>;
> > +                               ranges = <0 0x01d00000 0x80000>;
> > +
> > +                               ve_sram: sram-section@0 {
> > +                                       compatible = "allwinner,sun50i-h5-sram-c1",
> > +                                                    "allwinner,sun4i-a10-sram-c1";
> > +                                       reg = <0x000000 0x80000>;
> > +                               };
> > +                       };
> > +               };
> > +
> >                 mali: gpu@1e80000 {
> >                         compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
> >                         reg = <0x01e80000 0x30000>;
> > --
> > 2.19.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
