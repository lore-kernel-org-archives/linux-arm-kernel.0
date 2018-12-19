Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC800C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:43:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B9E21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfJFH6Xc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rGN0HFR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9E21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=55EMMdqNPx3vZbbi7hrmvYjKJaYEg40Oh8lTbZGm4P4=; b=lfJFH6XcgesYog
	BU8AOI+OF2BwHlz3qnZ0g4L+Ad9yzkbhK2zWO8ue/vkqTzzW7rTzmNd0ho6bS0LWlPkhXrbQt8ge7
	ZKfsjuPkoKAzTMJvnfNeO1Ep5NdCcvdinSG7mUsp7Jep6wVtDAx0BtMI7xd4uxI3i82F0XS45b/Q8
	XOJtMtjFiP32gK+QlqKrRcQ7d+25DsRZzo/JpWaAQcWYuUYdMcCnoiXbtD4laA6/SB2AQ3rvVBbTh
	crlst5dcuZaaeoUD0GRoMfwa0+YJmQbBHTlMfzXx6omCnJ76NPKCzp22y6t6CZB3nVlZtaC30JdCw
	3t+SNtYGpmyg8dM0lipw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZJg-00085T-BY; Wed, 19 Dec 2018 10:43:04 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZJc-00084S-NC
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:43:02 +0000
Received: by mail-it1-x144.google.com with SMTP id x124so10667858itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TIsaOUia+4f6xiB5ne3A07PpfINF67awrDp0lnaaVwA=;
 b=rGN0HFR6UM/at1z8mRFLiTvtXFt9ibuZMTACZ0XLLWxdXt+SSALX9eFLLwY000QGsc
 ycPc87ljD/pXurAOY/Y06Y7BmGpyrZLBbKUauTcfNpPc5tIbnsiGpaV9MJpifMBM7xNw
 CEVxLmE35zYtXeoNa66ZRqE3D1xSISGZ/RZOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TIsaOUia+4f6xiB5ne3A07PpfINF67awrDp0lnaaVwA=;
 b=W1WcEVLnLg7Of8S4sMxDLoetL1g3MdmQMU8dxYtH+BgP8MPlbScx43vocf2UqQpPrz
 V/kfP9nXDpKbGzzibi9OZj0IfunGHj1XIaIJjd4LnHOdqc2e6ONuXyJe7JAZph58Mv7r
 hbp4pHyoo54oNM1VyXB73T3BgwwgHQ0Ue3spBMyBaUn8rFtdMQX+SkWeRGbgBOJI/j+a
 YKOT2FPbDHNLqhiD8FJ5lETkamwRrzjcIcyt3mX9YmnGoKqevOYzNjE+97TsPl611bm/
 YC99fcQ+OS/E1Er+mZydNyKYCl1suH+ivV8pp2KWhMqGeFi538V5MBEfWFYN17lYW3u5
 cDow==
X-Gm-Message-State: AA+aEWbZpf43Fc7A9Khp1ZcCCUjoVdaznlEytIiOiioJQt46In7WGcUS
 cIkvCbjz2cHbgl16dLPbuCf01UbpnuSWJqUNZrQ9EA==
X-Google-Smtp-Source: AFSGD/UNfYBBYtAG2Nw1A2p+D0ueJnUI8wDsbqBGB52Ihg6vJfQgO94aSPji9meSv+0PKGZCvC5lGisycx2aqaSlTIQ=
X-Received: by 2002:a02:104a:: with SMTP id 71mr7451064jay.103.1545216169586; 
 Wed, 19 Dec 2018 02:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218113320.4856-4-jagan@amarulasolutions.com>
 <20181218152318.duynff7f5m2gxtv4@flea>
 <CAMty3ZCS+QT_YqbJueR-qeityaDxNbQ7p_d3D6bNATSJLQpRnQ@mail.gmail.com>
 <20181219100738.iakvqigi7z3k2coa@flea>
In-Reply-To: <20181219100738.iakvqigi7z3k2coa@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 19 Dec 2018 16:12:38 +0530
Message-ID: <CAMty3ZDm0jPTigzX_jnNcOKRp6MbTFuwHpaTUmxnnkW8AQZRng@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_024300_754122_2B9B6737 
X-CRM114-Status: GOOD (  24.53  )
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

On Wed, Dec 19, 2018 at 3:37 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Dec 18, 2018 at 09:08:17PM +0530, Jagan Teki wrote:
> > On Tue, Dec 18, 2018 at 8:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 05:03:17PM +0530, Jagan Teki wrote:
> > > > Unfortunately A64 CSI cannot work with default CSI_SCLK rate.
> > > >
> > > > A64 BSP is using 300MHz clock rate as default csi clock,
> > > > so sun6i_csi require explicit change to update CSI_SCLK
> > > > rate to 300MHZ for A64 SoC's.
> > > >
> > > > So, set the clk_mod to 300MHz only for A64.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > index 9ff61896e4bb..91470edf7581 100644
> > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> > > >               return PTR_ERR(sdev->clk_mod);
> > > >       }
> > > >
> > > > +     /* A64 require 300MHz mod clock to operate properly */
> > > > +     if (of_device_is_compatible(pdev->dev.of_node,
> > > > +                                 "allwinner,sun50i-a64-csi"))
> > > > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > > > +
> > >
> > > If you're using clk_set_rate_exclusive, you need to put back the
> > > "exclusive" reference once you're not using the clock.
> > >
> > > Doing it here is not really optimal either, since you'll put a
> > > constraint on the system (maintaining that clock at 300MHz), while
> > > it's not in use.
> >
> > I think we can handle via clk_rate_exclusive_put for those errors
> > cases? If I'm not wrong
>
> Yes, but it's not only for the error case, it's also for the inactive
> case.

Yes, I will try to add this next version.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
