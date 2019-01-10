Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D649C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF38214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEDh1GAm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7H5HjFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF38214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tG79vn/6aa2RgKnTSSQBJgNOtZ7rdILN8GydXg5jQj8=; b=fEDh1GAmAQivPV
	jPQ9sLz0cOqGms0qZS9bjgS7IKSWDlZv1mOAk/zKxE3VoPmRghipT8FprCs6aN6AOSWssR7ul4UkA
	wbycLSDVkItS9pmKQ5kbvb9G8v7L6DKbAtZGWCj0fmTeeOYabLELyogovXDPsJW9HZq9QwX1q85tU
	sp4CVFm8KDSy78folQhly/shTnZSx2Gx27TK2OnDL1cN83VmroEDbnUncdjIOj/wxop2EwyXkFzTp
	2ZQRyQGi8DDXdOwFKZQuYpeWKdWZrUPtCZr2Z0vQPXVdh1BJtsohdneBZqaiZiaeD8pGBlrMucC4S
	tpspyYbnV5DgRUIwNJRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWz6-0005Ym-2g; Thu, 10 Jan 2019 09:50:44 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWz3-0005Qv-6m
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:50:42 +0000
Received: by mail-lj1-x241.google.com with SMTP id l15-v6so9093285lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+mgEpehwQtRm1VaqM2ytGzaq+6JKimat4K6WcvNJrQ=;
 b=B7H5HjFIKCJQMjo99p+hkQpmllKjTsNXeyPfIFpP/y1ZpthWnPgj/nBO6hBlsGUDZ2
 qQ4EU9+U9heQrq7tegSYwMx/gAZ8/6lkxvfYH/2YHkSd139q16rhY7x9c9n2J3UViXMZ
 bpybY4LdCJgvLciuAjlw8ByJWfY/tHBk9v/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+mgEpehwQtRm1VaqM2ytGzaq+6JKimat4K6WcvNJrQ=;
 b=rW5WYKhu7jxDnSTd41Qxbtmcs7C5lc4cN6KEDJKovthLUbtybNU/ueqFnKlu2KzOl3
 IUHFt8sQvgXpMpzPY4SUPGPiY19Dfudc4XZlSMSkeTDLUi3wzO46mNsjSiB3lvkHxdjI
 qPBJt99lJG3HmpsZjzfoW5T6APXu9+k8Yphtrl4gmGlxfe7K+yNSkFWqvQsPqixle4Nn
 7M3h70Fq+QP7qL1l11fIRiTSF62zW89YiM32E//KZFECda8hPrQY1eLKxp48c1anWsP/
 27/SHBC46ccXqQwApLE7UxEXum3LTQkPecd9B2EU6emQGvYSD53NwbRplKn1wv69qD2g
 PoYA==
X-Gm-Message-State: AJcUukfgj9y6P+W/1ajwYSY7yNpjFDtiS55s9WRC38n0CqnBtLVM+ZX+
 kbymMQWzgZQF0C0DIAd1jWNivf75KLOCcYEZab8F6w==
X-Google-Smtp-Source: ALg8bN4QGP/xpZwtpHWq6GnFSnP1afF5CyDI1fHpn99TRCtvSkpQPfA1eMsoFPbNIo9Ygv2za5fK5EgeRq9sItNA760=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr5499773ljg.23.1547113839345; 
 Thu, 10 Jan 2019 01:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109134208.5660-1-dev@pschenker.ch>
 <20190109134208.5660-2-dev@pschenker.ch>
In-Reply-To: <20190109134208.5660-2-dev@pschenker.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 10:50:27 +0100
Message-ID: <CACRpkdY97wU8UsEpHWNHzpv0LzoM7rQWaNsHoi_WrNy7dkvoyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
To: Philippe Schenker <dev@pschenker.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_015041_268228_1213A128 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, linux-stm32@st-md-mailman.stormreply.com,
 Philippe Schenker <philippe.schenker@toradex.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Rob Herring <robh+dt@kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Linux Input <linux-input@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 2:43 PM Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
>
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
