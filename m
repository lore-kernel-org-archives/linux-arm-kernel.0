Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC9B2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CctNdZLA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4PpKg+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9B2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdOqlzYv7M3EhlktMhfQhn/p+5FT31mInIlzzBSbD0Y=; b=CctNdZLAWa/xEW
	BPRCFe9oITrda+G0IsBwgxD/Xmgm+m1zFC0sjR3cqMD5NtmgMeY4LmVNmfBqI1HtaDfxV5Omhc+D+
	WE9mvqeydeGM03KYzkT7xVEdJDDFnDNXOK6GdhJlZUGIW7u0qOnOtp/79+6+IkwCwCaR2MdDGyYjc
	4hgUelQOPZ6Cl5SsYF6ZKZYG6ZEDEUAeyeFvkvwEkWkG0+0iEVSkEnk16O3WSnPg/E+dOWbSPjf1Y
	xbpUUhISnKExtxEbOlvjfn23DXbU7oviuzoUUBo/7oYANmfVUShMtO02Y3BCu4lTazVERMRF4XMXP
	TOVCMII1EAgzwZ3Dfv/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvofX-0004lG-JG; Mon, 18 Feb 2019 19:33:35 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvofU-0004kr-Iy
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:33:34 +0000
Received: by mail-ot1-x342.google.com with SMTP id 32so30116390ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jb0Z2iHBbnz36VaZoxk4OAsnN9fOzEjk6X2AU8eyo0E=;
 b=r4PpKg+38hRmMOJrUqFqfIphcbGrQIhqYX0Q73FrK+FfRa2lO0UuRqfcJFQgT9wbbd
 kKGdI35U5P2PUfCHtIXKviIuvVUEqBzPM5iqYHITXwvRlnyUWz99Bxu5FF1brXc27BeH
 6VBrKVgc1UxmZzrvB/Vqrwf4GjajSxHTxtyYpUdDGz41yjiksUdrnp73uzsNZxV+i1pM
 CKLtZrPSOdneI5ii7aalmnug1M+ej79822TAU1FcvAN+j68gPR64+WQXaOeWb+OiDbbh
 LbYEySXL9jw1ItmriIrmposTILR4EcQkT6VLbTn/+RcNHwDeOTWU1h0YhJrdB33IuO4t
 gQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jb0Z2iHBbnz36VaZoxk4OAsnN9fOzEjk6X2AU8eyo0E=;
 b=e203hFYX52JBMkQfkro2NgNCVjYADvJ9C3SeYneUkEmZFe0dc2RuW38TPRpf8oTr9Q
 xpRcTkWdgSPF/xplYLaxq6d9BsFPpmOND15mENhTYLSvF4su6E/hlCw5TB8Hel+N9JBH
 mdaVjjgljcpoDI0FDBy+jj5An2fgQzGMG0db0kY2nJvKoLkgH8Or0DHt6JV/D4KmTovv
 ljUY9jyQemTmIu9vmxuQA8uXSSGO90JFaaeKGrjzyZdVFxvPU6lzrJxlBnOI9NRF3MAy
 iwJXCfYlmcsHb/Dm2bPMlP7FjzIWv6N5Nz0HmS6eewTydBUErx5frdNDTTFFa0DRcotP
 EwzA==
X-Gm-Message-State: AHQUAuZdvBigTmeJJUbWlMHWFW4R8XftsY8XoTK6+bPKdgbfg34xFoIW
 SmSx7VB58a6JCIjiO1zG12Mw/Jf/LabbtGqTggc=
X-Google-Smtp-Source: AHgI3IZBy03IBGCnHSOQyJ1ZPtgw0iSa+L6PUIJD7W+NQ/GvzIA6ceLesZIvrYHbosh1zCzippw5fZ4gh1smHRa1Lc0=
X-Received: by 2002:aca:550f:: with SMTP id j15mr238536oib.145.1550518411389; 
 Mon, 18 Feb 2019 11:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
 <20190218182629.GA14714@bogus>
In-Reply-To: <20190218182629.GA14714@bogus>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 18 Feb 2019 11:33:05 -0800
Message-ID: <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_113332_645810_35837FC7 
X-CRM114-Status: GOOD (  23.96  )
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
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 10:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 14, 2019 at 09:09:52PM -0800, Vasily Khoruzhick wrote:
> > Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
> > Validate the clock rate") prevents some panel and bridges from working with
> > sun4i driver.
>
> Sounds lile a regression that should be reverted. The fix is not a
> backwards compatible change either.

anx6345 driver isn't mainlined yet and I'm not sure if this change
breaks any mainlined boards. So likely there's not enough
justification to revert it.

> > Unfortunately, dotclock frequency for some modes are not achievable on
> > sunxi hardware, and there's a slight deviation in rate returned by
> > clk_round_rate(), so they fail this check.
> >
> > Experiments show that panels and bridges work fine with this slight
> > deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> > requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
> > fine.
> >
> > This patch adds DT property to disable strict clock rate check
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2 ++
> >  drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5 +++++
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3 +++
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1 +
> >  4 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > index f426bdb42f18..18c8b053a28d 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -63,6 +63,8 @@ Required properties:
> >      Documentation/devicetree/bindings/media/video-interfaces.txt. The
> >      first port should be the input endpoint. The second should be the
> >      output, usually to an HDMI connector.
> > +  - no-strict-clock-check: don't reject timings if exact dot clock can't be
> > +    reached.
>
> This should be the default IMO. Most panels are a single timing, so if
> we reject it the fallback no display?

As far as I remember the change was introduced to reject some modes
for which dotclock can't be reached when driver is used with VGA
bridge. So if we make it default it'll break boards with VGA bridge
and old DT.

> I thought we had some mechanism already to allow some range of
> frequencies. I think the chromeos guys needed something IIRC.

You can specify frequency range for panels, but there's nothing for
bridges. In my case EDID doesn't specify clock tolerance.

>
> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
