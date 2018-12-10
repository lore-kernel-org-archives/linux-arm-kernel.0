Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A48C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CE620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EPUcOIhH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhHD3mR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CE620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NXPoGW+MqJ8IFUIbTHJkLJAdmIrp+7fOUGcSMN0bUSc=; b=EPUcOIhHn+3uNh
	otHu/N43p+UcWyrwV9mwscKptrvGvu9L/tXtcMnGKC0KDhglOauymSD2k9W6Nr/RGkIY9Z0mNDaKa
	n9xGsR6YzdLp9qMsqRqHS15D+mnN6Vx0ay5epcVkyyXDZI6RxE64F91CRUamlGYfOEg+0BGbLOKRw
	nV2c9bnEaPvnlDvh4PAB5+enAIYFB5RFtNMOcA5ekclkQ22Wo0k0cHhc8JwMmLpOwhvFyQLEpdnT2
	rRa/UmJb7slBDrSxsWXhEinTN7ikas/YooJ/I3SnG6XgkxBSqXqG0zjNNQVXWdDMq968ZkSf7k0xI
	azaoICE2ZQLLXhx+2Amw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJtE-0000sc-PI; Mon, 10 Dec 2018 11:38:20 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJtA-0000sC-4i
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:38:18 +0000
Received: by mail-lf1-x141.google.com with SMTP id a16so7742765lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14KAsRnGAQBDieHO5XCras/Sxqqc2d4jTpz3Tz86rds=;
 b=DhHD3mR9eVHozC6qH1Eitt2udK3gHHnkLDgyudvjx/e3pcyxBVga7DwSs5K8afu9la
 qOA7IUfwTvqWz7LScph7B1wHWsHcrLVvzOAXvxjEhHGjAfNpd8MKJvIMdiWo8wHwOXl3
 oj6k2CXtXPGxOLY3hysIxAlBbDDhbJrhWBOBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14KAsRnGAQBDieHO5XCras/Sxqqc2d4jTpz3Tz86rds=;
 b=WT0I3n+OsvzrdGhXdUNhBVYFsY5ZlqemNZgP9Vybg5c6jUxSBRJaVmJ/GyHEmHm9dP
 VEO2x/ZGS7PL8olW2zc7rkFq1NXEvglyfmiB0zN5cN22MbxL8d8xbfLD8iLJvd6iQP0V
 wvSQLZBrSHccXBJpZmOgztam1VfkvitEIvSUTnpixmTcZoBZ8V6tzjwo6wml2SGXxO/1
 2UhtNzNlxE6socpqbxMuXS2Qq1aP57348ziFm6RqMvtjm1DBAMh7BxFgjJh2tSSZk+jT
 7o8uQHICf6lU1hWuRCEVpyk9NLcxB9vD1xMx2WqRdmqxQBjyiIBr6ojR8EEVB4VmAEqs
 2Q9g==
X-Gm-Message-State: AA+aEWae7LgSoIOYZ3+hdvlPN8AGdq7TMH9BgT5oC+zPspYgjsiWFexo
 8Q6cJcjlmZyI/C6WItyDkE1cfQt3ID5QAIpC4D6COQ==
X-Google-Smtp-Source: AFSGD/Uv5hyup2l/HkVV/YiXn+xkaMEZnY+7MeaoSwTwO9UgSVgtp6w7ui7ArX6HAYEtwJ1thVHb2PdCg+GmZZ57GfU=
X-Received: by 2002:a19:c801:: with SMTP id y1mr6254376lff.53.1544441883603;
 Mon, 10 Dec 2018 03:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20181210101620.418-1-linus.walleij@linaro.org>
 <20181210101620.418-2-linus.walleij@linaro.org>
 <3c2118a6-b729-b809-654b-717048f56cc9@mleia.com>
In-Reply-To: <3c2118a6-b729-b809-654b-717048f56cc9@mleia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Dec 2018 12:37:52 +0100
Message-ID: <CACRpkdYrGV0y9DpmBy+tS3+0aG9UP8uRQw_HbJuvkjhq7BZ6tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: defconfig: Switch LPC18xx to use PL11x DRM driver
To: Vladimir Zapolskiy <vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_033816_206326_750E962F 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 12:23 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> FWIW I've tested DRM PL111 driver on my board, if you are interested
> the pending DT patch is https://patchwork.kernel.org/patch/10636591/

Looks good.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Thank you for the changes, I'll review and collect them for v4.22.

OK feel free to use however you like or use your own patches,
all I really want is the PL11x DRM driver to become default
for all platforms using PL11x.

Will send LPC32xx patches next. Same thing there, use it
if you like, all I worry about is the end result :)

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
