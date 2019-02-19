Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC53C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B853E21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r3sqe1fI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H579K5eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uUq8RD0Kr5D/L1qgbEVU1ifBim1clK1aI+4+sy+DCx8=; b=r3sqe1fIWpLj52
	FezXxydND+BkSGpeFo2rTurrWB8peeAt/l56fx3OhXLsVWd5om7J5oGSYRBq/DMPeMXKH1p7te026
	OHry2oijo0RaIm3wU5242PqYpWWsibLJhi6yAK4LhQYncOnXp2hGT4PfaxsDBNpWSPIE+C3Xj5SxC
	3Hu3qjs7r0dh3GBdeaCP7KOAMBEIPxjQrVvjyfy/jvcdOkidLUUZWSbbC7hhFusZMqVbfJlgq7Oyz
	rLmaJqTC33t/X36f90E5SZz8T33d0rVQJpCcaLEZJlo4J3W0dHaloasEtAmO0mJtyZi6BeSkXq9DH
	3mUPNhbm09pOexZqNtWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwF0F-0001Rc-2y; Tue, 19 Feb 2019 23:40:43 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwF0A-0001PT-A6
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:40:40 +0000
Received: by mail-lf1-x143.google.com with SMTP id u21so16195619lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=94SH4zc3GWblxSgsPBw9cZZKhheiEMLicrGfPJ6Mqjo=;
 b=H579K5eZ+cwh29VMDSywEbZ/LsPFLC1U9Cl8GVKk+TbufvQ+liENSxNT2OGpEhimeQ
 bElJQIXTEEnrJDdyMHvgj0CTe+Jdd1qCcKuWoWmp47tsbNB6df59kC5Xy4YjYwtgzUzv
 B2EJsxiS8IgETNTM1cutVe9lbgaXJBVVudeZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=94SH4zc3GWblxSgsPBw9cZZKhheiEMLicrGfPJ6Mqjo=;
 b=OdY3OsvkdXkvzW1kqnif2c66ZBvmXHNASiZwkbDg3x3tFuQj2OOjXtA7Vt5C9+xZdR
 lEbYa7iBLODnX/90zlNdK2ac7UGUx26nnQij22PwNghUaVhwbKMQ6SzCJEPlFasTce3u
 0+lz99Ldx9S2M1pJ6/t1gKhPhy6XuNvFrvkw1XJ3Ka6d88mkBGtb2TIEx2LwRjGTh/cU
 1ZDOMTzNPuiadsBzlldY0YYlonSFyeXpPu9VVrzpb3stp9RE0QhVR0+SVKLr8ns8zBw5
 FF6ysJFcp3ucQ6+6bmRKAZQAhVl0Ga0dC2vOa3izzr8GGNDDHqLIJozNtdKvO2VESlFf
 X/3w==
X-Gm-Message-State: AHQUAuYT2LL27JyoC9ivFAsz3RvgrZqEjpSEw9wPqsHSn2QWGH8iFhWs
 twWsvsglfRsnAXFQYjXZ7OaTKx0ntf8=
X-Google-Smtp-Source: AHgI3IaaPKS42P+O54rTM6pewIym95gcuOufX18hPtWAiyQ87TiV8YzhR1ExbV0uMG+ZQ4psNglcUg==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr20236181lfh.6.1550619636506; 
 Tue, 19 Feb 2019 15:40:36 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id u10sm4398402lfl.6.2019.02.19.15.40.36
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:40:36 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id f24-v6so19166533ljk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:40:36 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr18507676ljb.126.1550619182560; 
 Tue, 19 Feb 2019 15:33:02 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-21-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-21-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:32:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Y+YiAdOHEbqO-d9JAs3AqK76AQ6_3AJ9Qqn_82HYtrA@mail.gmail.com>
Message-ID: <CAE=gft4Y+YiAdOHEbqO-d9JAs3AqK76AQ6_3AJ9Qqn_82HYtrA@mail.gmail.com>
Subject: Re: [PATCH v6 20/22] iommu/mediatek: Rename enable_4GB to dram_is_4gb
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_154038_347292_D6C05F56 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch only rename the variable name from enable_4GB to
> dram_is_4gb for readable.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Nice, this is clearer.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
