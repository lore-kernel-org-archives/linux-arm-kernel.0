Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DFC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:44:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BF12171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oR+Q+Ix8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWWjD84E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BF12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oaG6PorcOiVJ88oMyIiCLrqskJ87KFKz82nMxhPba00=; b=oR+Q+Ix8wL/zRD
	cPVT+WVjZvG1tfoNwIU2H5Atmx87zdf+K0eD39pvIXu72v7coTQNMS24bUxoOTPIzc55WoZTbmI1d
	ByzNJbYwgx8gpZF6qycQPu5FrQoxWC4A6lw586twz95jxaKoaW6kLEPVIanpCPTM2ZBkfM1zTjvfd
	5QgJ2IBhBf4zWjQODPY9tU7EykVdeXxBRBgNRIghomF66GBcadZ7l02OFJAc58zu9s9BJX1MHIaWI
	5v1sy8pW1Fyx0KpygVLN6imWxEEU7dQ1ggl7pSsiN/orWqZxgS9B8VSX6ZaP+/gUEVfqoAV0P+14A
	D3cYw2/bHcO4VOBizobw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7Ch-0004BB-J1; Mon, 28 Jan 2019 13:43:59 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7Ce-0004Ak-7t
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 13:43:57 +0000
Received: by mail-lf1-x143.google.com with SMTP id v5so11856679lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KSSQy5S6QE7RDBm3NS+S4YIXbwfX8BbfMaGVRtuBv0E=;
 b=XWWjD84Epz7vnqMkXSHZVCUq/sjp/B6pTtUdidS/5oy24oLuLFTUDYjFSyvcpccNQN
 R78w2Y2yixr2F2QRXssOo3isRniZswRW+G9MMRg1sTXKA/QQE/5/71Gd45Tts1CFhrfL
 uE2JGRMhls3fGI5CfFoaym4r9Pz1j8EwJ5Id8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KSSQy5S6QE7RDBm3NS+S4YIXbwfX8BbfMaGVRtuBv0E=;
 b=ALkncIZvN8REC/L7CvpLPbCjAECvA+GRRBnz2Kdt5jSF8Vg4MQX6PZbI6prR2qda24
 mncXKT5I3KUqSTXKyenNPdMnqzcce6nqsgM2Z67bdjSAgAlZOrzoHQloB7jr78BHI1ou
 6b95LdWvUS1qwZETc+B6eeBBP4THssxsgiw/RZg9wzI5VHJUhIgtI/p+nUoDRGI4oSo1
 VgE2HmPi0ML/vcthrqpST5T3qNQezHNzeTCgEBXReBf4xGpuGbX4ShQ/T/zOTMAzWyXT
 HxaVrOtzwg2qtynNREHPjX6izA+wiewlwDoXuPOqdbSbxUuJffGCaj/7Uo3ti3Yn04yC
 i0Pg==
X-Gm-Message-State: AJcUukcjOwr7iVWRA4toMmP2qHWQ46tn1Vd8OtUSf2rPWAsYKJUAXBuo
 py5AfP1nyZA7S3Nsiuk1bZ6b2UdAlF0uSmgb+TnmDw==
X-Google-Smtp-Source: ALg8bN6jhe7J5o0PZRdUP/xOMN6ZHj21qHLi7KUc3yGZo1mvObn/9lPcX5QETWqo41Lqs46p28KfdyrleyM0jtlA0fg=
X-Received: by 2002:a19:db82:: with SMTP id t2mr16334927lfi.130.1548683032916; 
 Mon, 28 Jan 2019 05:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190123084140.16524-1-yuehaibing@huawei.com>
In-Reply-To: <20190123084140.16524-1-yuehaibing@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Jan 2019 14:43:41 +0100
Message-ID: <CACRpkdb0V5e5=OgaFe=jPubEV-JaDNpEGNjE24SjZAAuEtMweQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: sirf: drop pointless static qualifier in
 sirfsoc_gpio_probe
To: YueHaibing <yuehaibing@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_054356_280356_27CFA534 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Barry Song <baohua@kernel.org>, Kees Cook <keescook@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 9:42 AM YueHaibing <yuehaibing@huawei.com> wrote:

> There is no need to have the 'sgpio' variable static since new
> value always be assigned before use it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

I haven't heard from the SirfSoC people in some time, I wonder
if they still actively maintain this file?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
