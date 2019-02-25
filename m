Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05978C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C624F2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFtWr9gl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8xtLOf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C624F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZhcEtBfE3NXv/qBt7ZSntGWMWuZ/uGOVjMHSO5jdh2g=; b=OFtWr9glKRS9Tw
	55JxPQzRcVsacPWWkM/DMlCF9I19yNZZUYtEBL3NMMMWszZ0NHbbu0DIsyMqiG0hEER4dh72pCSEu
	0nt5rvL6bMr+66Cwn/RF+E/x/ulqlYuB9eyDMTgeWzYXfVSzzbGlBRDBRXaMHDTW1w7DiSuuNOUWO
	SSxHz6E/mtBjLpko8zKwhGq7zJmmR9kqYBxViX+tJrendSgIFlzVigXRYLzp4qQwpjljobNqrLHmX
	tx2vHwSHZj6zo9ObgIwt2ZJoumsIMxJ1DcSmHmTsXiC81GxSjhaH429JwZ6yc/P/wk9+pIBqSaRUc
	OwLow5WwlQIC/T+uU6/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQVF-0002Qb-Az; Tue, 26 Feb 2019 00:21:45 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQV6-0002Hk-TB
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:21:39 +0000
Received: by mail-lf1-x141.google.com with SMTP id m73so2736148lfa.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=THittGfJC8emYBhU0KhzGPQFIt3H4BeIZxF6YUUJJdg=;
 b=M8xtLOf819mKuTqGzIZh5FEWMHL4Oj6lRGxIbkhnnZ5YBEtr4X09H5aShqQUNddMw8
 TchEUDsdfvInERbS1NqqA/0tOxlfQrr+sYSeZGaP9wn9qF1Ey1szZRF1y/S0JfadFtET
 bpXsK99UhMnPzhk989HhJmVDvQPeHn7zWDbM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=THittGfJC8emYBhU0KhzGPQFIt3H4BeIZxF6YUUJJdg=;
 b=VbRAAZcFF300VMPADE9tLJ9gqk6XzMBh11DBah1k0F+BvgYug+uef6Krux8YHFwHul
 yxQyeSd/1Lw+mvg5y8UrEWbDd6Z7Jms4u3cB8jqMPVT9+X4ahuKy9ixeGZ3EW82dY21Y
 YLipucPxZ6Hhslnl6QJDqV1DwK7TF1nVf1Td/b5Rzq/S/9WEP5OYuvoyZZRA5QC3obYf
 ATYCLp6lA77mIulk0kpofHkWHGoMOv8sdLsBGtWZnEx50nYRFRn8I2CxoSRV3NRGxVSV
 NduvdsMEA+4BYkO3z1pXOaIy4D8vQUCF1MqBA0lqITn1WPw6WmH8xDQG34Ef7eFyUU3G
 6jTw==
X-Gm-Message-State: AHQUAuZIcYuPBrrvbYP1TJXdKYKZ5a7baoDwB3gpTvRmrGA8uMfm13aV
 jQ/zWHj62mFIQlUHjyq6MBQ8uSRx9ps=
X-Google-Smtp-Source: AHgI3IYk3KXm8Hd+qKJjuSQ78uuSA8Su0HhUUE15SGVOFgpI0XazpwJSsDLtJkw/JR9sCybrf6nz7g==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr12523823lfi.62.1551140494978; 
 Mon, 25 Feb 2019 16:21:34 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id u5sm2783397lfi.24.2019.02.25.16.21.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:21:34 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m73so2736135lfa.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:21:34 -0800 (PST)
X-Received: by 2002:a19:294d:: with SMTP id p74mr7312760lfp.101.1551138989171; 
 Mon, 25 Feb 2019 15:56:29 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-10-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:55:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft7NZtWOCcbNi9uDwru7abHn52R-NgYyU2cnBehf7rAhGA@mail.gmail.com>
Message-ID: <CAE=gft7NZtWOCcbNi9uDwru7abHn52R-NgYyU2cnBehf7rAhGA@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/mediatek: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162137_337046_773ABCBA 
X-CRM114-Status: GOOD (  10.54  )
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
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, CK Hu <ck.hu@mediatek.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Nice cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
