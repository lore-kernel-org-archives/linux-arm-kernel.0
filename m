Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A43AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:05:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF5520651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FPQ/AlNk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCSCszBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF5520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itvnHlPfKSs9cBFNQP/I+RjctrYPGQPZigcnhrXMoKM=; b=FPQ/AlNkzVIWYi
	M4Ru6uYfJVlLZwIP5O8OS/9pcW92Rqhy7i5JMOdRG8b997RSHF2Uwzx2FTDAw3b1ZWVKZKwOfku0W
	MgVtlU0wyL1vWc9+rk+HFV/iMB4Pa58kxhlhap8hf3U6NfIZBgWC3IQV2Q4dXLkaIofkX5iCQPlDQ
	IAyrQKF2Vo5sI8VZYYuKwiajFHSPkmwi3LPx71nVvmQnJCvm5kQVrhAWzgFB5D5qerP8qHsdAysLY
	SjRO5y1PhVxCrUGAwjRNRLGRkm8KXyblun3GdNIJAssDIJhdDXVpRP8wk8nF2sWvqEmJ1VOYvvtIx
	NXEyrjdfc4sWFz1hJ34g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycQV-0007qx-0N; Tue, 26 Feb 2019 13:05:39 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycQQ-0007p8-1G
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:05:36 +0000
Received: by mail-ed1-x543.google.com with SMTP id c55so10678641edb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=81RgWyYCtHg0Be6F/oJvEJ6i+v9q+5k0Z8Yu1a/PYIA=;
 b=CCSCszBD/P/4CITusqmG1VEw0yVBGGWFufDeNKhItQkD4ye0Ls+egXVr+pePl9ZrUB
 BeUScdTqo3JOAicb18iJsfkt137USIfJJJEGFDBDgkPyEKf3zSYIqP7Z4OnLAq5OEV1e
 FDJ4lCa5rRMGhlOiqC0F609XLneZMenA7n/Av01idBZTqMB60hFPTO0dQQ6k9wx3qX6E
 Zc/0hdt6MOyuQeJn1YSNKCZrfD+N0fUhRFJdvDWQd/JZl4wNhAGZ87wT4dLFr+VQuUMA
 SN15/rU3HzLXJwl3sZEpZuyEwk+m+fKsh6vv46NmGlGOvBYLz8v2rSQz8RJuYiPS1WKI
 k80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=81RgWyYCtHg0Be6F/oJvEJ6i+v9q+5k0Z8Yu1a/PYIA=;
 b=ht+ShbSSRbLGARFJ3n3x7hbVqdNEwu6/9nlYxWSZFsrtFsI81WIpAeN2bnIT35/wM/
 rNn9GZJ/UXmvA+zxZ7q1YN7fwTMMqZgf8njSC+o/XGFzjvzh/qb4qSvfUX5y7rGMn8zl
 EECPzcYeqs32/Dkjvg0SE5p2bjo0PaPkVJrYhGea3qmDzM9B0n/wTZHiJeFBToJd8P5G
 EeqvAaMflenDj8C8BVOVWa5FD9vfnMgcjs7J7saTSFp6sWWiXC5cUbGtUGNS1YHiwPcE
 Zb01m4rY+B9PFFKUIO7WIsU+hooQuQYV//JfQV3xJaXbfXdyfyJiWZk7880rx3RCHNsH
 OYfw==
X-Gm-Message-State: AHQUAub0vSZNGeAcKPggJyLIa3F97rZL3wK20t72BnZw4NGSznBPQvwy
 QkHkYMIcs6iarb2TIS9CXOaNae8RiSpYil8ElIQ=
X-Google-Smtp-Source: AHgI3Iaq6DHWOiVk8whPHGRNeTigjx0cVmfqqdlqaYVS5fZTpHSiUhE0w/GA+DV2LlqopCjoDbcpcF6texwGYD76RNs=
X-Received: by 2002:a17:906:f1d8:: with SMTP id
 gx24mr16656106ejb.227.1551186332278; 
 Tue, 26 Feb 2019 05:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
 <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
In-Reply-To: <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 26 Feb 2019 15:05:20 +0200
Message-ID: <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_050534_098410_23056290 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 2:53 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Daniel,
>
> On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > On i.MX8MQ we can start the party using the wm8524 codec
> > which gets it's data through the SAI2 interface.
> >
> > In order to make it work this patch series enables the SDMA nodes,
> > sets the correct pinctrl configuration and uses the simple card
> > machine driver to put everything together.
> >
> > Changes since v2:
> >         - s/QM/MQ after Chris comments
> >
> > Changes since v1:
> >         - added cover letter
> >         - remove "fsl,imx8mq-sdma" compatible for sdma.
>
> Why? It is good practice to add the new compatible entry.

I get your point here. But for the moment it is identical with
"fsl,imx7d-sdma" so there is no need to add it now!

See the discussion here, and comment from Lucas:

https://lkml.org/lkml/2019/1/28/194

So, I prefer to keep it simple.

>
> In case we find out a need for a fix that only affects imx8mq in the
> future we can do that by using the specific compatible and no dts
> change will be needed.
>
> >
> > Daniel Baluta (5):
> >   arm64: dts: imx8mq: Add SDMA nodes
> >   arm64: dts: imx8mq: Add SAI2 node
> >   arm64: dts: imx8mq: Add SAI pinctrl configuration
> >   arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
> >   arm64: dts: imx8mq: Enable wm8524 codec
>
> I would suggest making the last three patches as a single one.

I'm not convinced about this. I try to separate patches like this
in order for people to really understand step by step how
audio is enabled on i.MX board.

I will give a second thought though. Maybe 3/5 and 4/5 could be squashed
together.

>
> Also, please make the Subject as: arm64: dts: imx8mq-evk when a patch
> is specific to the imx8mq-evk dts.

Indeed, will fix in next version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
