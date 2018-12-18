Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EA421852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ACRCx6Ej";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bOXKUD+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA421852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D4AwHWHJ6R1XowjoTRoTmydcFon4VXw+vpCchpKptkE=; b=ACRCx6Ej9uDu+Q
	80e6DHJQs1N1eABiTOyC080YsE9FDZbURE8gfYtz56QKys7rpZPI20Fj9DMnJwOzWpxFpu7k1mj37
	IDvXb9puHj/CVZooAlbu9ajErgYmGoiXhJd6rKhxno+qZoUCH0c+HLRA3G3jxQFM61Ke07cz7zOMG
	ahfsIAM0BHkXbVwjwrNx1mgjUAlBnU+13dccpYpANsvlAFBstApvK/xa/gPE31wG+wkR3mIDed349
	d+rgcyNfvhxjMdO9YqGZFK+lCPMjhH4fhXNII6B9y4MhYDOw/U9P9ySEQO7Ugy6nzaz+rVkckK7gP
	RkMvt0spV2C2S7kQpvFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHZr-00071o-LU; Tue, 18 Dec 2018 15:46:35 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHZo-00070K-Oi
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:46:34 +0000
Received: by mail-io1-xd43.google.com with SMTP id x6so13087563ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1/zhACGiqYxD973F16CJgW7lHQ7NOo+F2AGOaW1Tmr0=;
 b=bOXKUD+ium5IZD/ej6gBo6AoeyCaxHe8W9E5ZCZ9r7rduXf5QJjE0bAwXxg5B+JEfK
 WS01OpHBsjkNblLxpp6gAfnuzn6KtYTbtpH0ctGniiWx9TjXXVTgeEuZn9Iu+P9Xowri
 3MGz/BfMlSZXAHytSqm5GvouhhTxIq6b0pQV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1/zhACGiqYxD973F16CJgW7lHQ7NOo+F2AGOaW1Tmr0=;
 b=l43yOYkhPonyX3QmzHQke/An/dUcOpiP+yDPJT4K9ekX8Tr0CmSH123yUQngfKyYEU
 73YB2/RIsm0TZEpyROWwnz4rEbu8HskTzT65lZH68RC8lPtvlqZ2MsX18f6i8G6Wh00f
 12QpKXibPK4g4L6QQ9XUYtI0xfBPsFBkkWmEdNjX2zCWu996D2qllJRasix61CEf/jBy
 dWZW+3mqaP/daVUdYTbfQtwgKxNeO3ZdhNKYG43Ibpbxv/4OMLF1IRIA24H2ga0Y+GLe
 SC74K9RghfGX7ts4YPv4FBQfNN/pOrZt2tVDz8rvlwzH+lhNByC1Xe1NO5yxEFNS/fER
 268Q==
X-Gm-Message-State: AA+aEWbE3jU/D/fCWN8Diry7OE47PXgGKSaf+T9Kr4Ri53AdMoak52eJ
 mKIfwFwB+JcxsuKayKoAPeH7DbJre/vkRkxlxa3Amg==
X-Google-Smtp-Source: AFSGD/Vw0JOZ8RKR8b2+LlUMZj0hoUL5Xw8rRsU9Uzbab7HLMC2KsHzEDHMZE7NyQ0gEePst9K8pHK0stt+GL7m2nTU=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr13929097iok.114.1545147508734; 
 Tue, 18 Dec 2018 07:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218113320.4856-4-jagan@amarulasolutions.com>
 <20181218152318.duynff7f5m2gxtv4@flea>
In-Reply-To: <20181218152318.duynff7f5m2gxtv4@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 18 Dec 2018 21:08:17 +0530
Message-ID: <CAMty3ZCS+QT_YqbJueR-qeityaDxNbQ7p_d3D6bNATSJLQpRnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_074632_798250_40257EF6 
X-CRM114-Status: GOOD (  20.01  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 8:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Dec 18, 2018 at 05:03:17PM +0530, Jagan Teki wrote:
> > Unfortunately A64 CSI cannot work with default CSI_SCLK rate.
> >
> > A64 BSP is using 300MHz clock rate as default csi clock,
> > so sun6i_csi require explicit change to update CSI_SCLK
> > rate to 300MHZ for A64 SoC's.
> >
> > So, set the clk_mod to 300MHz only for A64.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 9ff61896e4bb..91470edf7581 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> >               return PTR_ERR(sdev->clk_mod);
> >       }
> >
> > +     /* A64 require 300MHz mod clock to operate properly */
> > +     if (of_device_is_compatible(pdev->dev.of_node,
> > +                                 "allwinner,sun50i-a64-csi"))
> > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > +
>
> If you're using clk_set_rate_exclusive, you need to put back the
> "exclusive" reference once you're not using the clock.
>
> Doing it here is not really optimal either, since you'll put a
> constraint on the system (maintaining that clock at 300MHz), while
> it's not in use.

I think we can handle via clk_rate_exclusive_put for those errors
cases? If I'm not wrong

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
