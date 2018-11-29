Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6AC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD332081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CAUfTu6i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="V5wTcec0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD332081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i8NH1guPVqUp4cgEv51Q9WOMhVox09Kqi49RIS7g4cw=; b=CAUfTu6iHCUqL1
	px8MS7cO77mh9X3OU2x2CxdAe98MgL0iapbM6GeTZajV+x6Xxxx+gQu9VSQMkJnj2Mp1FYe2MZ8Gh
	xkFL+tmKylsPWCxeE2OoAYbzIkvrL1sLh3jp6gpEpf50NXyuH+0ZH8GhKnEQ8nxpMSbgxZRfV4CD2
	gNSabKb/VxZhw6JMdV1kGY1uBxnVZGnGhwOyZgcCd5Pd7HvM7SvJUZv/RkIlrUkrqkNsDOkWX8HJa
	AsIZwqWTk8sq/SNjpHRJt9+HX7mf8gUZLsUNmUszQMANFJ25YRtZGQODnxDVrD6puKlXFyhL5fGwl
	fZQzDpxVG11zOmI0QcBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSNjO-0001Qh-Q4; Thu, 29 Nov 2018 14:55:54 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSNjK-0001Oy-Tr
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 14:55:52 +0000
Received: by mail-io1-xd42.google.com with SMTP id f6so1811278iob.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zltmiCUlVco/OMj6WMOtVnqUWC0sd0wXJjHaa3DT8Ro=;
 b=V5wTcec0hhJjeUWi2Q740IfROGJIYTELR2rd8+dLmffCGPeZpQMFmi9dqyGY7D72Zw
 RWvWuGi2OY+OLSikRtN5CVmwp0IflTtek+mFwc1GAJk2pKuIGn2lZ7kufu2cu8qcgrzA
 XpDWqgsXr7+C4P3pUGDKXo8I1oIAK7G49Ihcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zltmiCUlVco/OMj6WMOtVnqUWC0sd0wXJjHaa3DT8Ro=;
 b=VPQCeGOJL26iXNgFSwVLvzyydSRTz21ZXEIr+yVOh6wnI46ttFsnFDsfagLH1l5HbL
 qcq48CMj1vfk+huZYFQTuvjuPJlIesTPf+Ux0KNAkYlnIcRCqItzRUv5ckkRF9BRlYFg
 NSTFPz9Ry+pGoKbZZHwDbHq2lFPh2MeY28txKBpwTrJ5sDK3mIDxMPBR/qT1JF8u4nAi
 r2mJn/6zFdu8lfKw7zOD59f3x9cDWxmQf6b3Ri5nS8kTpu5QW6pLcgbTZUOFgx03MvOX
 +CvmHK1CwBqMNPcyEFw653NN0dgsah90QRZ9+u0/k+z6iOExQnFrs2O/yhIGrfKWtgE5
 mdZg==
X-Gm-Message-State: AA+aEWaUag7/BsCzGmQZLlM5Gy7vPr//913r7A9MLB03368O8tv72q88
 I6MewGX5ebRL228KclucnWLmLeL9h5USCNtngS+eoQ==
X-Google-Smtp-Source: AFSGD/WORmHTU40LHiSoYvEcp5Yjz7OJkhXJCIDbSmkmMi8iTkUUs9bN4CzbB4Yilzxly7ZRQsfX9skW2PxPyeQAaVs=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr1582174ioa.34.1543503339523;
 Thu, 29 Nov 2018 06:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <CACRpkdZmTSo02yQeU=qe9WyJMXEq76CNmc2kkFEHuwdo=HKPJw@mail.gmail.com>
 <20181121094233.GN4266@phenom.ffwll.local>
 <CACRpkdaXUFwSiQnMqv2WBXr2ytn7kx3CeAuamkj9ZYU1C6bpnw@mail.gmail.com>
 <20181126141241.GM4266@phenom.ffwll.local>
 <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
In-Reply-To: <CACRpkdYmBSVKBvu=YOV87zWK8WCC+pcn9ux_W4VEYwzRzexQ_A@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 29 Nov 2018 15:55:28 +0100
Message-ID: <CAKMK7uF9Q-LySAXg=kT9B-ueFR9qhr_B0N3y1g1D_OTc-+Vbdg@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: remove deprecated functions
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_065550_967404_D92FA5C3 
X-CRM114-Status: GOOD (  17.63  )
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
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Gilles Muller <Gilles.Muller@lip6.fr>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>,
 Archit Taneja <architt@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Alexey Brodkin <abrodkin@synopsys.com>, Dave Airlie <airlied@linux.ie>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, greenfoo@gluegarage.com,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 etnaviv@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Stefan Agner <stefan@agner.ch>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Sean Paul <sean@poorly.run>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 "open list:DRM DRIVERS FOR RENESAS" <linux-renesas-soc@vger.kernel.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 3:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Nov 26, 2018 at 3:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Nov 24, 2018 at 10:17:13PM +0100, Linus Walleij wrote:
>
> > > It was especially scary.
> > >
> > > But I think I managed to apply the patches and push the
> > > branch now.
> >
> > Except when you're racing with someone else you should only see conflicts
> > with stuff you've just pushed. Or if someone forgot to fix up their mess.
> > What was the conflict?
>
> dim push-branches was complaining that one of the commits was
> missing the proper committer sign-off, it was the bottom commit under
> mine (IIRC "drm/atomic-helper: WARN if fake_commit->hw_done is not
> completed as expected")
> and dim update-branches seemed to rebase and fix up my patches
> and then everything was fine.

This sounds like you (or dim?) accidentaly amended that commit (which
changes the committer and results in the warning), and a rebase would
indeed have fixed that. If the first patch conflicts this can happen
because dim apply-branch doesn't bail out correctly. Or at least did
in the past, I recently fixed that in

commit ee299e510ae468aab27610bcbc4fdd4de932f74b
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed Oct 17 08:53:00 2018 +0200

    dim: make apply-patch fail again

> I just felt slightly out of control :D

If your dim didn't have the above commit and you had a conflict it's
all explained. Otherwise I'm not sure what's been going on ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
