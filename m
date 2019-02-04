Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30F9214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pFGd+Hdv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFln0VDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ue1Z2+2qTUS/XuYwurE8+bs7rMZGIVV/oGBR3o6IrcU=; b=pFGd+Hdv223qlU
	aLvrTwcCA8bOFD8Quywk4sSfROOJORYnZ5qU98aqatRhe8IBqPXGNd1NKOYhLG8v3rbLjqqNHPC5v
	UoN9p2yC4NhIQsjBd8+/HL9c0lDoVxX+2bvo9n2W6mlUqrEGw/OQdLBV2mVBGWnw7IDtpTA19ToTo
	28GLthKSTi9j/2vTMUMO47uXYnfAtOD0S6DdtlcdFWCyR6s/OEt9uNduZApfJNu7LmsRpour3wGIR
	Gxo/eiiWnOx99C/xhxzczwfFTna5wgeBZL4W6inVBJg6TI3Rk48H9SwaE5QGatN0rVD+5cXXlgEAE
	gjVwQN7/Ej7gT2/buMHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZOm-00008g-RV; Mon, 04 Feb 2019 08:14:36 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZOb-0008Oo-It
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:14:26 +0000
Received: by mail-ot1-x341.google.com with SMTP id k98so11593063otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 00:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vWsfmWMVRKCDMZvhnlwU+GxFlX//Xw6X757q1ELTrBo=;
 b=eFln0VDo95abu3R+mmx2FY74WSNNbVHH+tzlmOJT5MAixuSclILt2WE24Y7FOz9pNe
 /9uAUUfu6ajhXQTqE9RwUF0311WCkMQyr8Zgz9aNQ3CD2ip6qschSmQoR9Tenj5UctBX
 bn8SLU3+u7QV59sfIlZL4R2XdHHBgPKuY3fxSWu9vp5fIah5+CvZRlNKcFB5GuT79hHX
 86Mt8OLQObSEgdS60YtXLGc2wzkQstldT1Ua4i7oU2ssVsBI388CHFTANbOGdxDdGGwc
 haJx5khNeOTC9aH+b53l8wbXUlOVOU8rm9GLgSEJFgl/lrGWVFdlQTkM2DjroDpdxRA7
 RbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vWsfmWMVRKCDMZvhnlwU+GxFlX//Xw6X757q1ELTrBo=;
 b=glC8Bd7N4h6fqPe5pgE1fFz058wqBb9cZHh6Bo5iB1Zt1rj8cVITH+xs7H3Thy8dss
 g3wuypuzB5013SK3nX/EeaZo01IoyEavUx+Q8/bUyvv4ocLcNhsrDQmJPn1H/mQ6st6i
 8opCMkYi1GNxz5rEqcHsBJrI53wI4l1rC3x6oNkQ6pELv8puTJPl02jbXI+Msgnmas2j
 Hnh6XxULyvDwSshCR/8AiCli/ThB3UGh5vbgaaFD6b7Nfo3ebf542Le1dskNMNGKWEhW
 P9wkmjcA8l+o05pd1aFh1U40uiUfhRHIjN/LYZ9tkRBM98DqGfgWqblR/O+rx9MDl4Td
 9Vfg==
X-Gm-Message-State: AHQUAubUbl3c3CGFfe3FGua3KkdFrhwQc4EgPvsMnySfrcRknwlSwKee
 5fLxf3IPtn8MMMHHzzDPaGqUdyuUalU12SXRjsn26g2D
X-Google-Smtp-Source: ALg8bN6le5n+65nb5XHHVvbKS331KJ9HegjW0DWPBCCVT83h8O76z6CE67IYlcGro/W4ul4UWHpzRkLax+9kF9TIfbM=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr26330572oif.25.1549268061635; 
 Mon, 04 Feb 2019 00:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
In-Reply-To: <20190204074350.GC16448@ulmo>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 4 Feb 2019 00:13:55 -0800
Message-ID: <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_001425_649323_2A06FC6B 
X-CRM114-Status: GOOD (  16.75  )
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

On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > eDP panels usually have EDID EEPROM, so there's no need to define panel
> > width/height or any modes/timings in dts. But this panel still may have
> > regulator and/or backlight.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
>
> Please don't try to make panels look more generic than they really are.
> You're going to have to provide a compatible string for your device that
> is more specific than "panel-edp". You claim that you don't need any
> extra information that is panel specific, but you don't know that now.
> We have in the past thought that we didn't need things like prepare
> delay, but then we ran into situations where we did need them.
>
> Just do what everybody else does. Provide a specific compatible string
> and match on that in the panel-simple driver. Even if you can read all
> the video timings from an EDID EEPROM, you can still provide a mode in
> the panel descriptor to serve as a fallback if for example the EEPROM
> is faulty on some device.

Pinebook used several 768p panels that have slightly different timings
and recent batch uses 1080p panel.

What panel descriptor should I use as fallback?

> Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
