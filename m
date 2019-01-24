Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC19C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:46:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9E121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iy4bgbhY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1LfWsPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9E121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=krzH7e0ny3IDNUz9Qcnekn+GSUm3+DrRIZDDH2iW138=; b=iy4bgbhYiZ82Px
	o6ec1P2iwTrGAzHdszpiRgBdCEImorfcxCINkT/26/Ik072+Zkp060n4nlBfzOrsd5lDK2oACk4Fm
	GND16F9I8A32CQyNB49KNh+48RoROiLGN3t6Cfzc+KH+vb5HO9KRYy4eZ1X8mPm2PlYQ970dvcXnp
	xofkM3KBCwrFCEXEXBNUr2R1I90Rc4DA8KeHJnKBIAUQwLcuUeNyx5ID61oj5MUBFXb9qy8BSs/QD
	52cWHkjdR8C35KYQJxyixsA/84GFhhwdXS4L/C+cS8RN7q+mxcpnNWhccSzz3rXtEFx+L7EQcI12B
	jYElQJ92BSxX3cNr1MIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmdT0-000076-Bj; Thu, 24 Jan 2019 11:46:42 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmdSx-00006j-Df
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:46:40 +0000
Received: by mail-oi1-x242.google.com with SMTP id c206so4608468oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HCLaqfqxnIx3CTAyuVAUeiFx47dXR5GwtO3X8bsylQo=;
 b=a1LfWsPLyJA3ERMeCOPhOSbjIFoMeurGet446KKOhDlw4hpOuVXSyDIFLKOYlyR5qn
 YN1BPRhTX2yZl3vpAq2JV4kvbwJrZhOk0sOZNQWBi7fneJfs2AqvFVyWM/R4lH/JzC8V
 TEcgBjaxQnv88NTWgHtZ0QwOlkMO8pmXXFkMTSmzc2UvPgdHTZ5rAhl0OrbbujHIaG+/
 LR+6Z6pmUZw82avpQimSnc8wHY/G8Yt3VlGEMf/dQhLphy27mPS1MHDmOv3Mc8wZd6Yg
 bWxEHmOVUeHfa+kuLaBnu4p9fNuqOwlaAnL/88ka9h5sZOT5ddXWAxY3nbpoLVXqZXC7
 GFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HCLaqfqxnIx3CTAyuVAUeiFx47dXR5GwtO3X8bsylQo=;
 b=MLoLoCkacvNrBX896VChjrzbrABTAKZl1yIFqBXc5yV1gGleXaEe0DkhZ46xrVGENO
 6X+jF5WNgPOx9UJDqf3YaD8RUqPijhJuV6WeIVz0dwFH9t0sk5c2BTJollwlAegpg0NN
 KDOxnGCBGPlUyEXsyROj3zmBx++kkV27RJyA3IVwqIG/aY39CWsvry4LVdTbdSlgowqz
 XYYDv/Ce0r02B9DUyyyoKbc/KzCBVtmhsecTfNVK7kKkkXPlPd5KyTFYj2KYOjUGsYPo
 NyogMGrxItfS71vVIPelAut9bbMp3CGEg9pGFsB9q7Xvq0c9LPGA1pBvMOG3GMyO5g/x
 6QHA==
X-Gm-Message-State: AJcUuke3xpJWt+eQmaNnZMGd1m/W/iTC0M307Vsz2xgcSeILfB4J4o34
 4B0GOGFvtBR2W20Qb5RbDCSg01+1tQJGtHL16gc=
X-Google-Smtp-Source: AHgI3Ib7ncBFVqodang+8JXtzpYyhabPDb8yUpYDev1bqJrUGdfanm4ROu3NC/lFLRcmBnqXNSl4GUqBY8apsStaOZ0=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr933649oic.67.1548330398157; 
 Thu, 24 Jan 2019 03:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20180912152702.14640-1-l.stach@pengutronix.de>
 <20180926023937.GD22238@dragon>
In-Reply-To: <20180926023937.GD22238@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jan 2019 09:46:35 -0200
Message-ID: <CAOMZO5CeOxzyEG0tTKHfrNjY8WRKs=s5nBvxqZuFuJjR62eXOA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_034639_481151_BF20B16D 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On Tue, Sep 25, 2018 at 11:41 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Sep 12, 2018 at 05:27:02PM +0200, Lucas Stach wrote:
> > The PD platform devices aren't DMA capable (as is correctly reflected
> > in with a zero mask coherent_dma_mask). As they have a of_node attached
> > they will go through of_dma_configure, which will warn if it finds an
> > uninitialized DMA mask. Let the driver core know that this isn't a
> > missing configuration, but a non DMA capable device by pointing the
> > dma_mask to the coherent_dma_mask.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > Since the warning that is triggered with the incomplete configuration
> > has been introduced in the v4.19 cycle, it would nice to get this in
> > as a fix.
>
> Applied as a fix, thanks.

Did you forget to push this change? I still don't see it applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
