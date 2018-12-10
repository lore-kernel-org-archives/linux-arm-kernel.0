Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2EE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FdCpeAk1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gdMeAB/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2EE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KiHIUuJe1RDW4c3HVc02xX01jhgR9f+PX1Oeh6A6+aY=; b=FdCpeAk1nH8I1l
	UMZm4sKVfOhtdv/KBpmr0iOcaoMDP4Tlxba/ujAg7guHTwnQgNLNPZx4P+YSY/0/EZ1zGBxdYbHmd
	K1wD9nBceWIZ6BGOeRCOjFdjdS+WyxpZfcnlImeLqHqiy29CuyfkbaERqklrVBnUSV2P++tnL14Xm
	3qaMNuPDpx+4LsOWTbZpOrUNGGXaYQvTohskQ9mEYlkLKLG6SCS2QQ/txvekR66zC6clZQ+Rmgbcm
	7ALoc4td/kIfJsLdNArLsw78+sDQlsr/YFtSPnyAj3oZJ6wefBpHP3xK0pKQ5iio+IMejwLjM9eUm
	4Xr/IKjJc9WdSf7g6R5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSu5-0006pc-5v; Mon, 10 Dec 2018 21:15:49 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSu0-0006oV-PE
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:15:46 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so5833939plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=qpWHzIv7pNjRZyMT6tgEt1wKg39Uqn+aiTQ/opyFTpE=;
 b=gdMeAB/GikldyE+AGfWPd63GZmMTdKQi0hboZPtbfo6EVY5BX03mBJkexI0YeHYXnE
 CtbNn/GhIRhNLDHP9zTFhoWE0M2KFSqDycZCF7jtBqN8+D6kWJEG9lXsE7JJY1i4kJi8
 +p1tbsayBOE1SeH8p0DApHsnuOlCUYtxMqw9rMQHbx5tMWzBVKIE6k3AO/FA1gdBRu/q
 CP2FazBp9664//NrgviCtkjckNAsa15CkUsJKmZsiNi1c0aVVFX/yQUjy1nRJobYdHO5
 gKu7/fz/YEmkvABiQ5bg7xTEWWBOofBtSXUohgHTUY6ULq+FctuTJE21dGMfOJpxqS4w
 lcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=qpWHzIv7pNjRZyMT6tgEt1wKg39Uqn+aiTQ/opyFTpE=;
 b=eOPrR1bMbC1/tMvRtAwsLrnnuch7YoC9GeW5CSggEYuoFCW2fp1l0p/RkHxkcturX1
 7DkRf9XLyaVx8o3sVmqHN7PzyF77U8EItR8paZ5QCqVduRu5mi44Vs5fdJM3KkPs9ICg
 88CHINwmCI4+h8c2GJZiX+0IxVtid6t345NY4ns4s4r7/7SWryL1xDdNJV5kyapa7LkU
 QX3dJRerESQoXePP+5pA7n1/0J/zRaF2mRiArgBeCmKyFkhMFViWguPxhhrQ5BsuN6cr
 EZF3X9nYEY7RslJL5s6SjiTCGa5QhwiA2YUJd/LTjtlGVvIWMZScAcIOemle1AbS5jin
 rjYw==
X-Gm-Message-State: AA+aEWZoPNHLVY12FWlN+4XhmfzNOWJI3fNtVDX5k4GRwhjEwI35h+ZX
 Jih9hw1YSyI0Jseag8gaZyl/5w==
X-Google-Smtp-Source: AFSGD/XH6hxq31NE50qY5ngA/X66f4DEawLdoLdY/wcrp1lkFTFoq6f4bV/pIdB8krmRBmo4bGQVJw==
X-Received: by 2002:a17:902:d911:: with SMTP id
 c17mr9450732plz.151.1544476533954; 
 Mon, 10 Dec 2018 13:15:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id t21sm15814671pgg.24.2018.12.10.13.15.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 13:15:33 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] arm64: meson-gxm: Add support for the Mali T820 GPU
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
Date: Mon, 10 Dec 2018 13:15:32 -0800
Message-ID: <7hzhtdulqj.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_131544_824256_25D32DB6 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds :
> - Optional reset properties in the midgard bindings
> - Mali T820 Node in Amlogic Meson GXM DTSI
>
> Christian Hewitt (1):
>   arm64: dts: meson-gxm: Add Mali-T820 node
>
> Neil Armstrong (1):
>   dt-bindings: gpu: mali-midgard: Add resets property

Queued for v4.21 (branch: dt64)

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
