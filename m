Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54413C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229FB205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SrYApELJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEFbtNHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229FB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7lV1YwMnWHXpzUxq/RbPb7ZkwfCRcy/ubddvH6ces8=; b=SrYApELJhcG2k+
	ih78ISPUCiANp8t5bGAjxP76b8JZVMO2sQQLgIdpsSaJPVGyQpIc8kRNb8oF5K1kZOa/CmebcRjLT
	NDGrBtFs5s5dDOgaMoVG/8tmO1FCOEOLoSJuFKHpBwkw2K2Axri6wOv5o3o9MGuqdeA1h87G0IFo0
	QbFMg7PJYYFqsPeL/mDCZTFhyUbV/zULc6O9IPDhX7mp0I4jhN+3JS1JjcKcfbZMcTYJsHY9o+AtQ
	8/OsJ+S9bLQqMEZb1EhokNN8uM9XQrW8ZhisztBOdG8MmlZ4WmGOlmQbaU0L5WANXbmfFO68E+G2g
	LypeEjYhQuC4sFRLkdmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgqO-0003Cw-3j; Mon, 04 Feb 2019 16:11:36 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgqL-0003CZ-DK
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:11:34 +0000
Received: by mail-ot1-x343.google.com with SMTP id s5so635410oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ta4gq+4XCOrDKvsTKBwqWoYQvSY8Y3FBsAFTQJENqfU=;
 b=iEFbtNHnWZfhpGaOgXUShnGgEC5sfcBoaouMLzlOhBO9LYmG0OQQf4fnOsDI+a2Fux
 QVZQzB1ch7b4yL7eLUAeX2MvuwQxkykzBuyesVtwPQ3d7UAs7zPnwtKgFRgqV1l2Rb5T
 aE6+YmTz6qxr1yMd+Jpq/AT222DRCFnCrg/yzPiJ9nddJBRBZk4cUXro2OODnUw4J51k
 b3aGhG3P9AmQBHvSNEQQuoVFAbNMRPqGDVX38+U58bthbYLEEaLNGulApVoAOEHIIg5Y
 zR5aP2z6KYuZ0ORH2b5y86NF4qrjuyZOaHBOGaI9MagpOedzaYKsb70uuwG9RgXlU/HO
 rY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ta4gq+4XCOrDKvsTKBwqWoYQvSY8Y3FBsAFTQJENqfU=;
 b=hL61/maTJOW7t6tEYY3/1iUuaM3jaPgX7OmFDQNfEQammN/XfBWIBrDyYbapHMF7G+
 sI2zT8uiLvjvNftLVwHEEUAPqXJ1obeNt/KmRiS0CjEZwPHQ9HlgNQlEtYar8AV/hH3I
 gbtPGVAJFhto5FZm+gNXeOE9T9vdAeHQG4G8qGkrk33fQ3JRuwd6XBXfp7DM92QiOhHA
 s3WtldJqynNn11UjSYDZ7flKaa4Ix88+d3Rr5R4wbwzZ9mzKtB60vRZdN11KMGQLBS+F
 qlGGGkRG3R4M7XprGaRV+vf1Y3/A3G+UBAIgbzBaKQHf3wAEaszFB0yC6mcqhvwhQ1Wx
 VjmQ==
X-Gm-Message-State: AHQUAuZa4oe8yfIOC8/735Ip+cXJs4YBxj4zZYuaex0bj2xx7zdQIedM
 iciOvVjcH5kF85HWBEDponHupe/givAMYyBh8oU=
X-Google-Smtp-Source: AHgI3IYQB9tKwlIX2AuRBqsh57zpjluRefAPK0yBfNypRHQnAljWIMOY9V13Q+hlCkxXOxHyulFEE7mBRYqWRqehfLk=
X-Received: by 2002:aca:6545:: with SMTP id j5mr76001oiw.70.1549296692150;
 Mon, 04 Feb 2019 08:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
In-Reply-To: <20190204082353.GE19087@ulmo>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 08:11:05 -0800
Message-ID: <CA+E=qVew+8__yrAud1gFnLQ8HCwDdGhVjV=c173HGvZxH=7zZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_081133_476874_82A6C95F 
X-CRM114-Status: GOOD (  15.64  )
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
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 12:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > Pinebook used several 768p panels that have slightly different timings
> > and recent batch uses 1080p panel.
> >
> > What panel descriptor should I use as fallback?
>
> You don't use panel descriptors as fallback. The simple-panel driver
> will bind to a panel device and use the corresponding descriptor. If
> your device tree contains the correct information, the descriptor is
> correct for the panel you have.
>
> In other words you need to ensure that you have the correct panel in
> device tree for the board that you're using. This is exactly the same
> thing as for other devices.
>
> One way to to this is to have separate device trees for each variant
> of the board that you want to support. Another variant may be to have
> a common device tree and then have some early firmware update the DTB
> with the correct panel information.

That defeats the purpose of using eDP panels. Panel can identify
itself and report what timings it supports.

If we use separate DTBs then users will have to figure out what panel
is installed in their hardware and use appropriate software image -
that's something I'd like to avoid.

I can add a descriptor for something like "pinebook eDP panel" if it
works for you, but it won't have any display timings in it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
