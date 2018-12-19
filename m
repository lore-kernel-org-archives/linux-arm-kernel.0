Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C545C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:32:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EF120874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NG5Qabep";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XabPlfjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EF120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Clt7pxdyxLqtmDvO5PRYEG2vtWDmjtTC0LjOzNoAb9k=; b=NG5Qabepb4EElM
	BiqOaULSXiDu8tPS1L6o2o0f1AT/WiLWXWOjr+vo7FSsK2xZoT/dMi4Y0tNkxXJdD4xNRzpd/j7mG
	gfdUfWrAt1Rb1eQs3bmZjPCj2Z0iS0Dm7F+GUdexCB9KKZAWBIYvAFG6Fa4FMeqxkTY08hpRvwCPc
	hUjFGSKQmoLe27jquo+YWb6G8Fl+eH5BuFJr7HjfSZVfiAK5BU7pFF3EyvBM8k4Wys7lRykYct6oY
	/CunvazWMf5MmIupooAuLAybYYGTIKErhqRSVkRqbxfJPb33RCZ8M+srX99unm++krOKXUXK2lZ1X
	ewFB5zHUlkLVx1nUty2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZlK2-0000mf-V3; Wed, 19 Dec 2018 23:32:14 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZlJx-0000kn-N5
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 23:32:12 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so10128636pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 15:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=AnhRXD8JtTDZx8cD48gAZvL0e/SPIdCg74t+erkzhw8=;
 b=XabPlfjqjZ2sDUIEKjY0NlvuZaTbnCC84JlBVi1M8eYwlpdarY4LY3GKzR20v4p8oX
 UwF4A7UuK8Il1O5AShvDPU6WlYn7PGPmH4TVojoJW1YyyuHvp+r33kAMJabnEihOL1KX
 VnPk3ykcVPhyUVZ/r+J/A+POlQKn/J1NzLZlfjSPH0gJHIg5NAfIYE9lR3rwrW3zBiyN
 Ysv469wHriALdEgluq61GWgCBeBI721NSBFWt6lYgsTTreWT0b6Lq/FkBPKBzAgdI0NJ
 TNlNkP1aLIIqzUH3wOH1JQNejzkXCG68LCTjbLE6lkhrNoEkTfxoFDTIAh/xATp5TIVi
 69TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=AnhRXD8JtTDZx8cD48gAZvL0e/SPIdCg74t+erkzhw8=;
 b=gcaxIyW1bsaYCgb12j5oQs/iS5tuc8AQC3QgKbJ6T1Snas8FWAS9TNQJpP3iW4t9jj
 PGOpCBziAjzZVWeGxKjFXzcPoTZN8Lvxsh193S8RI8nqBelGrjFP5POH5NEJQj0XKKRg
 QFVmyfNnwSzlE8/dlE9XBDWlcHBlfm3QI+VrBYZbnAMoxypuN4Vtg/g28ktVtSciq9MB
 YuY3VtjnRpGovJ4f6tFIiC6XoPPOCvpCoLfq1mPUGebaxvTPfAboUDWfnG+fuDylXzwJ
 4ePq+HfL6m5scqLb3mZFNDPgovT3LWrd3Ra3pENNMJiMgkECGSSLQgBwE7SZ/7Daipi1
 8gmA==
X-Gm-Message-State: AA+aEWbMO1NPTXFoJE5GwVzIXyCo/f/BBfR+wwq8lhkK4T/Znm0XQNFv
 GEO+iTXpNFnC+e3vkYp1w4djt+PEZ9M=
X-Google-Smtp-Source: AFSGD/Vk+oAwHw2fSDYe/2wyNoPZCwhQbXe7pcXZ9REiPskAlY5PhXYHaTvVnVKsVN2Mdw15m+5HiA==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr20926225pgf.199.1545262318198; 
 Wed, 19 Dec 2018 15:31:58 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:4dea:8076:74d1:94e1])
 by smtp.googlemail.com with ESMTPSA id w88sm31550074pfk.11.2018.12.19.15.31.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 15:31:57 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
In-Reply-To: <877eg51olo.fsf@dell.be.48ers.dk>
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
 <877eg51olo.fsf@dell.be.48ers.dk>
Date: Wed, 19 Dec 2018 15:31:56 -0800
Message-ID: <7himzpt7o3.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_153209_803630_EC37C8A4 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Peter Korsgaard <peter@korsgaard.com> writes:

>>>>>> "Kevin" == Kevin Hilman <khilman@baylibre.com> writes:
>
>  > Add the G12a (S905X2) based X96 Max board[1].
>  > There is no branding for the manufacturer anywhere on the product, so it
>  > took some digging to find the manufacturer.  But since there's nothing
>  > about the maker on the product I've left it out of the DT name because
>  > 1) nobody will no that name and 2) keeps the DT filename shorter.
>
> s/no/know/

Thanks.

>  > [1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/
>
>  > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>  > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>  > ---
>  > Special thanks to Martin Blumenstingl for extra digging for the manufacturer
>
>  >  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
>  >  1 file changed, 28 insertions(+)
>  >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>
>  > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>  > b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>  > new file mode 100644
>  > index 000000000000..fe94765b671e
>  > --- /dev/null
>  > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
>  > @@ -0,0 +1,28 @@
>  > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  > +/*
>  > + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>
> Amlogic? Shouldn't that be Baylibre?

Yes.

Thanks for the review,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
