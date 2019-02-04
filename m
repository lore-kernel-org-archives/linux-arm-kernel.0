Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC217C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801042087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwUWmkCY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD+kEoOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801042087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7l2idyi2zD/pkkmCjIwukL3AhehfgiUYp6OSN0xolWU=; b=UwUWmkCYjiZVks
	CF17vqHs/xVI7u62hwY307tFT8yHtCB/YbQG6hyrUZHyCgdhwUWlqTfbO52pAwZ+7tsGYgKwX4zhC
	Ji6w1uB1ZL2h+FAVfQ52Lny2uC7QMoAAtYCv5t+MaWL3H7Y0YQoSZEr572JnLSdPKsml5lJX+wDxp
	2VgMWekOil80LeSaIUAxDUS5p1cTYuCMBOBGRY6+ZG8xcL0a3Ww/PdMsBcg1LobVHSzlUOEyQhHpI
	i/Cz8/va+GYzujBsCOlUhAQ+kKaS/fyzekAxCoy8QwGwZB4vq4aSnE+0vVSvH2apfiABVgE7dWvzk
	8l0c7S7xBX3tlmIZz4pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhHH-0005vU-KO; Mon, 04 Feb 2019 16:39:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhHF-0005vA-1E
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:39:22 +0000
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 710C0218B0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  4 Feb 2019 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549298360;
 bh=jV7Lv15oSKC92H7pCYB+ZCNF9iW8VUOlSifjXD8OVis=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eD+kEoOqIFgJ5hWMZPYdAvenN/ctyFI+hyuGI9x00ySSzl1xcML6HP0PUTj/KwtOk
 ik0XLY8d/hqUcp0xdWFt9A9YbM/nESuTLEa7krCYSoNAP3AIGUUZP6emqU/LM9cMj+
 X45sFDtQt0Hh84e8I5mmDMkY/zIYKSG6C37vEt+U=
Received: by mail-qt1-f174.google.com with SMTP id k12so560523qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:39:20 -0800 (PST)
X-Gm-Message-State: AHQUAubXFtU1kAEoZUwisY1aSXTUrtKP7nJfHtcJp02K037qZkFJtMZR
 tXaLsNXWGJRNBc+03x7m3GrrfIWhsRpyp/SLNA==
X-Google-Smtp-Source: AHgI3IbI6QIritiNy6W1m0yxbNnetf34MseZ+Z5sN292CV9mzbXOy9X/W+PL31CJwhSC6b1CZxAH+z+HGG9uTA0s84Q=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr231384qtf.26.1549298359505;
 Mon, 04 Feb 2019 08:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
In-Reply-To: <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Feb 2019 10:39:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAODca_U94hCi9O3E6XiUjAYCoL7_0gkf_eMY0nnT8Ag@mail.gmail.com>
Message-ID: <CAL_JsqLAODca_U94hCi9O3E6XiUjAYCoL7_0gkf_eMY0nnT8Ag@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_083921_105642_081A0B11 
X-CRM114-Status: GOOD (  20.83  )
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

On Mon, Feb 4, 2019 at 10:11 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Feb 4, 2019 at 12:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > Pinebook used several 768p panels that have slightly different timings
> > > and recent batch uses 1080p panel.
> > >
> > > What panel descriptor should I use as fallback?
> >
> > You don't use panel descriptors as fallback. The simple-panel driver
> > will bind to a panel device and use the corresponding descriptor. If
> > your device tree contains the correct information, the descriptor is
> > correct for the panel you have.
> >
> > In other words you need to ensure that you have the correct panel in
> > device tree for the board that you're using. This is exactly the same
> > thing as for other devices.
> >
> > One way to to this is to have separate device trees for each variant
> > of the board that you want to support. Another variant may be to have
> > a common device tree and then have some early firmware update the DTB
> > with the correct panel information.
>
> That defeats the purpose of using eDP panels. Panel can identify
> itself and report what timings it supports.

If you are confident that this works for all panels, then the firmware
can identify the right panel and update the DTB with the correct
information. If this doesn't work in the firmware, then it is not
going to work in the kernel either and you are SOL without specific
panel information in the DT.

> If we use separate DTBs then users will have to figure out what panel
> is installed in their hardware and use appropriate software image -
> that's something I'd like to avoid.

I think Thierry meant either way this is a firmware problem. If you
have a SKU per device and panel type, then the firmware just picks a
dtb among a set.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
