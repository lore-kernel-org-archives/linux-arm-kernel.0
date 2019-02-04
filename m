Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A441220815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BG9e7FWG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5RP2od8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A441220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J6ZTtitmbhktkQ6RBblxFtul1xwjjptcn7a6XMpRP+M=; b=BG9e7FWGdxPcFb
	ZClH9V8GSZU0VNRdUAIBTSEWKkuaqsaytp87z8AcF12cg7F8IeQeRSbjkBY4TsubbNKrMkiPEl/vM
	dmJSRIYg+PusDmHPG5E6N1vBMvZWze+WwnuOXL5XUo3Ksyyau7jweF6xJ6wt6x0YC2nd6CELVQY2t
	jM+144d3yKEI8aaiTXUNxFJidJtX/N5pOC/RUPL4PyKzN4vhqr+u5AxECbE61PsoDMgl7abicI5TQ
	cbTgmA7GY6S8en4g//xOtPvsuS5K+mRA7IjEYfJdwuUPgCmg6btbZQ7ylxHgi+T8C4dJVvW/uktXG
	TTVlRhZCbTOqojYm3r0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqheR-0000lG-6R; Mon, 04 Feb 2019 17:03:19 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqheO-0000kr-2T
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:03:17 +0000
Received: by mail-ot1-x341.google.com with SMTP id a11so912641otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHIv2ayL4rpJq73Zv/i3JenXqZ3Mmi6DM/rkqyVhHQY=;
 b=e5RP2od8yEyu5HwmSNufBd8uF0+eNgfqGSOQzXEXH/gQ7F5W7WkNsjJCUzOZ4muB8I
 2e4VTTd/VrzRlUK5g3Phzb4GaUCKaNuv3vWDtJpQGueCVKG05taZw/dQ+vkGukFA58Hf
 dvKMcD1QGDisv3Nfpj0FIxNebRoc17th54MkABLRH8hcWKBshEIDLu7GZSueIQCnqFdL
 GxJAODXG+n7lnIpuZzK4uAu3oTJdq/NXJCdakHUb+dUIGoEtfhQaOvVrP8t6LGgrqZvE
 fcdKJDYM7qDxbwaAHANFq+b8lJ02Hl6QcWas1QmleI4WVJEmTMbUE19XupaFlcVQpMj0
 IajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHIv2ayL4rpJq73Zv/i3JenXqZ3Mmi6DM/rkqyVhHQY=;
 b=RZJT01BhTlAlbYTbuvGBSYqb0sia+2qgORqeNdTY1E58zABwdAW02Smmvo+qn9/xKF
 MDrC00GlIRINttnP0OWgPn9Iyh7K8KL0MkNY8x+SfW9p/7hRKD1CU43rMzrnzQNF07yn
 4NPmSHDY8uuqDXqmvLm68DZvMnVE/cTAb+y02xDSMP823gm2jFFJTZDLnxtmsQWFVA34
 JOZgFrP0irDnHI1oqk7TI1Oc+dU6PYyvqjHvHlk3/g3/m04U7FodqmFpAWtOz1DHJq2x
 KoWiIV5NJObqm4ycNCBqjQzXRLaqIhMMrx5rNe8vJ5E4Pat2/2kW2B8trZVvKAbx2VsT
 u6Ig==
X-Gm-Message-State: AHQUAuZj77tB/1jiCOBQK5qp6NnQC8tn1ydN1POJnvj3+tPfOQzsrZfT
 xU7RoTclY0g3FyIl9D22EQCIxuKbuuoy7fHs8Fo=
X-Google-Smtp-Source: AHgI3IYpZIQITKXmFr6eiK47r/3RWnbfTK5vm4QNaweeMEsWzF55YA/M+EBrGmoepIPXYGgQOFDOTK0m9mk/P3rxAVY=
X-Received: by 2002:aca:f044:: with SMTP id o65mr158146oih.145.1549299794847; 
 Mon, 04 Feb 2019 09:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
 <CAL_JsqLAODca_U94hCi9O3E6XiUjAYCoL7_0gkf_eMY0nnT8Ag@mail.gmail.com>
In-Reply-To: <CAL_JsqLAODca_U94hCi9O3E6XiUjAYCoL7_0gkf_eMY0nnT8Ag@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 09:02:48 -0800
Message-ID: <CA+E=qVcgFQvxvMn88wwcNbkp4e=NB4TAhi=+u2SYEGD1NGU6+w@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v2 08/12] dt-bindings: add
 binding for generic eDP panel
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090316_134186_95123111 
X-CRM114-Status: GOOD (  23.40  )
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

On Mon, Feb 4, 2019 at 8:39 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Feb 4, 2019 at 10:11 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > On Mon, Feb 4, 2019 at 12:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > Pinebook used several 768p panels that have slightly different timings
> > > > and recent batch uses 1080p panel.
> > > >
> > > > What panel descriptor should I use as fallback?
> > >
> > > You don't use panel descriptors as fallback. The simple-panel driver
> > > will bind to a panel device and use the corresponding descriptor. If
> > > your device tree contains the correct information, the descriptor is
> > > correct for the panel you have.
> > >
> > > In other words you need to ensure that you have the correct panel in
> > > device tree for the board that you're using. This is exactly the same
> > > thing as for other devices.
> > >
> > > One way to to this is to have separate device trees for each variant
> > > of the board that you want to support. Another variant may be to have
> > > a common device tree and then have some early firmware update the DTB
> > > with the correct panel information.
> >
> > That defeats the purpose of using eDP panels. Panel can identify
> > itself and report what timings it supports.
>
> If you are confident that this works for all panels, then the firmware
> can identify the right panel and update the DTB with the correct
> information. If this doesn't work in the firmware, then it is not
> going to work in the kernel either and you are SOL without specific
> panel information in the DT.

"firmware" is u-boot and on this platform it sits on the same physical
media as OS (it's either microsd or eMMC).

I guess u-boot can fill in timings for kernel, but I don't see much
point in it. If u-boot can't read EDID then same is true
for kernel.

> > If we use separate DTBs then users will have to figure out what panel
> > is installed in their hardware and use appropriate software image -
> > that's something I'd like to avoid.
>
> I think Thierry meant either way this is a firmware problem. If you
> have a SKU per device and panel type, then the firmware just picks a
> dtb among a set.

Unfortunately it's one SKU per multiple panels.

> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
