Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA165C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB45620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3FJqh8K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo6cjjwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rocSA7E289trv6wz2gVYcfMjB6h6BgvatStstqvDMm4=; b=J3FJqh8KWbvMQh
	mQFasosHxc4qhdmjDnp2A1gCx2MGYPOz8yCTz6UFrrJaBjTxQ3EB6CEIgPVUgn5Zme6kFsQtKFdOa
	2lMfPV9y5BC+0Du3ulNUrtZFYNbzJY7ZhqV8Qj1i1KSRn+HuguvUGqmyuUec2b1TtD/jtCBHTHK2r
	EksbNKORR1j3bXTwO/euYw9IsT0Q0HtkKrxWz1MKB3WhU0ftTUR4wONZGo7mPEEJ98XJyX9FmEnmW
	Bx2RGuO//agIGxnpwx1Zd/wtJWgywAA3CrBLWT5/vKjU0PW4DC5bTaxrf4jBWe7wPamht88fYKR5Y
	vrTOZxid2Ps8wyWTf66w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4qU-00067W-Fo; Tue, 05 Feb 2019 17:49:18 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4qQ-00066O-Bb
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 17:49:16 +0000
Received: by mail-ot1-x341.google.com with SMTP id 32so7111905ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IwGl7mp6u2lvxxpbmH0RlNtCWShrsmXUYHuORBymzCE=;
 b=Lo6cjjwNKUsbmDWMWam/0YE9DKaXZniMhzCuF7EGpneThGwX/goPxFDzCQUmhfo+02
 ZUexToVx3K5B7Din8fWKpGD8C1+rejiQF3e0CQyh+IEreKFDWB9EYMZTtg6arVTrveFi
 Ra+6WoDQ0eeCVMK4X7w7xhTeEXihgG3eSxewguMvulObde45017v6jfFqyDIljix7ung
 0+EGZ9bGe7u7GYHbqAMeFV69YGwSAj2E8Rjy66ZEW1jLI1tryOP8prTQrPeeO09exhXk
 PhqEutuIFMxEa9V3+fM6A4UEb5j4lojIzyAV4tC/JqlcWig8Udf8kfr2tCmQJBF1Jcof
 ONGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IwGl7mp6u2lvxxpbmH0RlNtCWShrsmXUYHuORBymzCE=;
 b=TjDtKGh3sbRhLDfsXzw0zmTbKEineAWzgDrnPLrpoxJTmYVGNuGDK8wGLRc16pAPqT
 pRkNsAbCkdfxnYTpSLmVvHQ5BcusOojsmb69+UfjE1JcWrfbTj+I9vkEKCqL/nY3u448
 oE77Imw3hS8xDzs6/ahEBNHBj1+euUOoIw0LUclJL4Fg8i6YcRAqpGZYnkMYrp7L/GqH
 ItzlUIM/KVn5VZgGb/kjikssC7h5r+y+CYJ9+dA0B0meeFqdD/VO4TXXV+FOtsw/N0CO
 yryXoWrv6kvg8EU+pe5z/TdgNLyAm9iYilN1yXHtLMDITb+MFjbaLGtk2bRMmaw4Kg75
 YZlA==
X-Gm-Message-State: AHQUAuaviFAgZ3hG3Cv1PQGs8GnU7yTQaUdCLPLeAD2aGuEZLVqawJnu
 cPFUBOfL6+VPjltErLPCfMIJEtOdR9pyln8OGPsOzBqW
X-Google-Smtp-Source: AHgI3IZHcyhwerrbM2JasQK/vtc+MO/iz8tXZg9DbupoIgnLKtZ6GqNcFNsidsOEqWNFzsDty/BTpEnwIvVOBjQhuiE=
X-Received: by 2002:a9d:966:: with SMTP id 93mr3220144otp.25.1549388952985;
 Tue, 05 Feb 2019 09:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
 <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
 <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
 <CA+E=qVd7yh=JNZSvrfY4Diu+VJWFK6yLUJ5MavBcZ8Cftn6f-Q@mail.gmail.com>
 <20190205154156.o3aa4cy6uxenkwol@flea>
In-Reply-To: <20190205154156.o3aa4cy6uxenkwol@flea>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 5 Feb 2019 09:49:17 -0800
Message-ID: <CA+E=qVePKnQLwObfu=ya7-GcUiUkjyFg2p-rmg=FiJJUhQBvxw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1%
 tolerance to dclk frequency check when bridge is connected
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_094914_393056_FDA17D34 
X-CRM114-Status: GOOD (  16.39  )
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
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 Chen-Yu Tsai <wens@csie.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 7:42 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Feb 04, 2019 at 10:50:17AM -0800, Vasily Khoruzhick wrote:
> > On Mon, Feb 4, 2019 at 8:29 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> > > >> IIRC, from the previous discussion, HDMI had a tolerancy requirement
> > > >> in the standard. Do you know if there's such a thing for eDP? That
> > > >> would solve the issue for all the eDP displays at once.
> > > >
> > > >I don't have access to eDP standard - vesa.org says it's available to
> > > >members only.
> > >
> > > Try out to grab an old version?
> > >
> > > I remember 1.0 is open.
> >
> > I can't find anything regarding dot clock tolerance in DisplayPort
> > specification.
>
> I guess since the DP is a VESA spec, it's probably .5%, just like on
> the EDID (well, CVT).

Unfortunately that's not enough for Pinebook. It needs 1% for 768p panel.

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
