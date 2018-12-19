Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94EFC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9986F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LZRoxH+b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGbgnkVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9986F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yUs0k3DTxNymdBHPDqcPtu7KR7it04w8Xh76cHv+z+8=; b=LZRoxH+bDldWmt
	CVWCQuK+SykhJWRmFyLRjwhvx8uk7gkQmJcPrO1j0e+FeIB0e7c/c384lGqphnWBEv1wkhL+xe8qX
	iMAQVaMMJAryhe5NYwQF/HhRbpYiO7fa59Lo1LYsSPpHRJ7SxvmhkQItbolMWVgUXMCuR7J7p8NA4
	P4Nk5K5f+aOoi4rmO0nBhpXcaYPnkWsdUSHe0xfP+NKVNQlA7ztk7F/LTBbMXniWq2hj7WmtSzuc9
	UNOLPFBTOElU5xDXMAWb0z67jtmdyZAwQmhY0Q3jsegF+sbUxh/4NUTOGxeULQ5vKykmI3PEMWG8j
	Xv8iIzrC+mMeq5jP0LGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeTu-000538-Ro; Wed, 19 Dec 2018 16:13:58 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeTq-00051E-FW; Wed, 19 Dec 2018 16:13:56 +0000
Received: by mail-ed1-x542.google.com with SMTP id y20so11311919edw.9;
 Wed, 19 Dec 2018 08:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version;
 bh=8oLwxm5kpQNbRjEQiLdYycEfgUMa8qdreVebJWXXSYo=;
 b=OGbgnkVMHCW7MiFeXFmLCZ3rv0Cq4ZxKE8wraoO2cKVtoyMDlesI0Kck/5+jiMdMxA
 ypaBwaNIMeX78ZlB+C5nS6k1drnR2Z2OFznk34Cv7Z3w2FxKha7v0w/9POqWzEVVz2FL
 YXWkJBuO5A7WKE7bWg7TgRPqJuoG8+5zdBLXuOGRNoRmk1jpGaZSOYubHUPYVu3iy3Io
 I5DJAcFgEN8llSlrPHXK7UOAXdVLVlfyQUzPcxzpnV1u9GY+DhUgl6UrPqdbIG5/7ODB
 IMuuxSZvozoP7at5IDmiA9plqE7AQRf9QtJnroPkeqNg1p5SHEzOf3xiiZBDNo/YwvyK
 8l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:references:date
 :in-reply-to:message-id:user-agent:mime-version;
 bh=8oLwxm5kpQNbRjEQiLdYycEfgUMa8qdreVebJWXXSYo=;
 b=eeZwdXAAakGG+M1l9egGjjtg0IAkECcC9NtDd+p+RAwA78OQCzfjVOt6e+7GrqtA9k
 NItkJPwptavAcFhPkaP9Bz/LhjUwU2TJtvlWUwi4CKDvYNV+7YmO52ihlqDBVSfvB4RT
 MNsK7R7bVmc1QMYa8dsJT4QCqjSgjIaIAG3osw5IpFBbfDadRhNchHW2DzgJ+Y/W7QDx
 rnBXHmmXLTquphif83GnWMS4k8ytWHz/KAJCeMZiRUzNEbPsdNAv/QVwrSWUtmz0IBVu
 qXw7PRVkUj1M1K0QzAG/lWtANDHv4FJ9dadcErVD9aOkGB7AC50ITcP5m0QONY6xjSYu
 A7Lw==
X-Gm-Message-State: AA+aEWazvDg/zjAcEBFNq6ahvnYubGGv2RxPzII2xGvHWnG3YMmuOQO4
 WGOut8NcWM4PwRuGLNR2wuE=
X-Google-Smtp-Source: AFSGD/Vr1oxySFbG6ytHgZX/xfmQlhhTI3e9kwXZEY6ik6DttQkATyKi0KESE0Kk29q9mJ0eOub2WA==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr20647605edr.153.1545236022007; 
 Wed, 19 Dec 2018 08:13:42 -0800 (PST)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
 by smtp.gmail.com with ESMTPSA id
 z6-v6sm2798957ejq.63.2018.12.19.08.13.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 08:13:40 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
 (envelope-from <peter@korsgaard.com>)
 id 1gZeTb-0005XC-RZ; Wed, 19 Dec 2018 17:13:39 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
References: <20181219002620.12138-1-khilman@baylibre.com>
 <20181219002620.12138-2-khilman@baylibre.com>
Date: Wed, 19 Dec 2018 17:13:39 +0100
In-Reply-To: <20181219002620.12138-2-khilman@baylibre.com> (Kevin Hilman's
 message of "Tue, 18 Dec 2018 16:26:20 -0800")
Message-ID: <877eg51olo.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_081354_553804_032D3DE9 
X-CRM114-Status: GOOD (  16.70  )
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

>>>>> "Kevin" == Kevin Hilman <khilman@baylibre.com> writes:

 > Add the G12a (S905X2) based X96 Max board[1].
 > There is no branding for the manufacturer anywhere on the product, so it
 > took some digging to find the manufacturer.  But since there's nothing
 > about the maker on the product I've left it out of the DT name because
 > 1) nobody will no that name and 2) keeps the DT filename shorter.

s/no/know/


 > [1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/

 > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
 > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
 > ---
 > Special thanks to Martin Blumenstingl for extra digging for the manufacturer

 >  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
 >  1 file changed, 28 insertions(+)
 >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts

 > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
 > b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
 > new file mode 100644
 > index 000000000000..fe94765b671e
 > --- /dev/null
 > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
 > @@ -0,0 +1,28 @@
 > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 > +/*
 > + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.

Amlogic? Shouldn't that be Baylibre?

-- 
Bye, Peter Korsgaard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
