Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80666C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448E32146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OIYa0GOU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYVMVNbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448E32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lq/twLyvOMyegXgm5noao9Vu3G89RBA4Z66EHa4o24E=; b=OIYa0GOUSB2SF1
	LroOQlVWn8kZU8Hj7iWwsWKE3IQUf1kkFpKRlvFVN2c7d/kCQ4PCIbtXPoCwkd34HMw52/PkrCcvO
	9I5BCzMv1DV8TIaDSiKBfDfT65FuBXcspElx2bDmHUI1WNUuNXjV1Qor6dQveJvNoAmgDak9tS4cw
	ik6GHkyjLRPXoRwIcQoowab98hWK9FqCx7bmkAaVAJZgIXe81xSUG1WeygQzTarVLYU+zbEStbqZ6
	B3FQNrpHdz1qjZaiK1LYCbm+6qR6wlGvdFagqHtFBaiGDJFDjhnaRDAHCRKKDc7sggsIuNSKZGdXP
	rcW4Xsw+s/N0wjilOHBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtHO-0001Xq-I6; Fri, 11 Jan 2019 09:39:06 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtHL-0001XN-St
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:39:05 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so12360847ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VOAK6HVhb+bILEvywTUCsGY0OkknxUI9FX+ir9zNtFw=;
 b=IYVMVNbnXugYliKQnhoZU8ETetDGRI7qiDCCBphRY6bSSpuPWZT2DToct1wvV40/En
 j9UFGSfp/URY+0OnvA1YVWm6r3keqOzjnN9OkCQfKdziQpa99pXKdPO0b3nppk+8RcGG
 xQ5hX9VBvcGwPsuPX8ZbFPX9lK1K3NEBtJxXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VOAK6HVhb+bILEvywTUCsGY0OkknxUI9FX+ir9zNtFw=;
 b=Duf+w4fCp0IvV07P83AAZL98N4ms/LfeXJgJVdOpEjopsOUEQFjcdCSrwlFrwKvSNz
 qiuEqh412oSyRl8t3V9TTuvm+5iUuJB8P1fsgi2NIdyfUcyBRIoPeY1nTSuo+GcfhXsm
 1cZvSG+n38CrGQoHuie8z2SCUo/tjYVJIOVLeq8DcP3LIYM44ceAx0eGZG9x/oD4rtoz
 ItQ4f9++NwnVr4KuY7X6smlwQ6w7hFnF5Y4MzHFjosdFABiUBLSdYFrO9h+EU171MAj2
 9ZXpfXVR9nU5wNWyJrAl36rcKqv6+mWXg2+T6yl2a6qVJSAlPZ/gUF/BVi9QQHCeJgji
 HWEw==
X-Gm-Message-State: AJcUukeHHlJ/gKuedKvzPLAlf6VYc1xGInMKxFlZec2geEwXflVVIxXf
 lPlL6HMfkbHMDWeMBnIqLiy9gy0A9726Cm9Ppw2P3g==
X-Google-Smtp-Source: ALg8bN5lcoLI+IT16sWF+XNGvCR5lrV8HdBcXvdZfYHydXGJMT1G5VbheWLsQ3Sje4bS0pEMlXzLv8I/cL7VmtbJuJ0=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8093148ljc.97.1547199542027; 
 Fri, 11 Jan 2019 01:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20190103151104.11839-1-brgl@bgdev.pl>
 <20190103151104.11839-2-brgl@bgdev.pl>
In-Reply-To: <20190103151104.11839-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 10:38:50 +0100
Message-ID: <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO
 lookup entries
To: Bartosz Golaszewski <brgl@bgdev.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_013903_928398_8092807F 
X-CRM114-Status: UNSURE (   9.17  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> automatic base selection") the gpiochip label no longer has an ID
> suffix. Update the GPIO lookup entries.
>
> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose you will push this upstream through ARM SoC.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
