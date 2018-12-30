Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED212070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z8SFvp+I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsQj5an/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED212070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6OUWWDsILpZD+2o1CVv3tX6YeqAYJJYkQKRgz5vH4k=; b=Z8SFvp+IRhZs3b
	F0cINrp8HebMvgeKnl/hgBUs3AH9lq/4wsalD/GzCUSDGxT8F7IH8ExMuqjn/yQwxcPWgqkX8Y/dg
	z/IQdpvJA6eBqfIpADFyjbkQpSXJFH3IgZLnUCuUtLxOzwMlDkfhkjJ4oYG0UX+WveEHB/NNGa9u9
	R+5Pyw35CU5Pwcwb82QRGfFJvh0yvY5nttyr89FIMWmCcfQ5Gc1AW5H74Os08UWGCKyf8hd0HgDfx
	lo66mLjqFW8MHK5KGQpa3TjwuLPSRPV4AgphuooyQBB130bYF2ufbPGtID+2GGZnbwUT8FmlOsKqR
	LnKXEl3P8BBYemxMMuiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdhBH-0000eN-7H; Sun, 30 Dec 2018 19:55:27 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdhBD-00085I-7j
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 19:55:24 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so22451900lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yIn4U0qW3N/sR2rJp1t1BrNn2uTxmVDd5xkS5R3pMd0=;
 b=BsQj5an/X8xEClqipG3lN1DCbdnlefcgddiKNKUgDPeD1lZIeA67NZVjSVUeuNbcCQ
 YkZIQ+6u+o58MZOHxx6iSLyf4FanDnQmgeakBCWu53X71UtGKbCQDPFdNvuYYfHVst7h
 t2ATh+wE4y23iVyFB9yEEzafBNUlH9F2kNJ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yIn4U0qW3N/sR2rJp1t1BrNn2uTxmVDd5xkS5R3pMd0=;
 b=Wz3BacTh58RrPmL5mzpRimaAXZrXUcecOcgpLgNtjhUKzNecpGofyHLYc0pIuZYd2b
 fTtqiIpHYxuqyUYMf+dQ3oxQTy3mIvIXmvL0Rfayr18fJDEpYUaplpvzTHvbmG57VbeB
 hBacNuT5xU5J+5CEE0kXfbVYmVdiRon8gGeOD+PgnPkAIsAjPT/w9Xefev9O/yI5MEHA
 C1n6jYH2N2T8s4wMUS4KBcFMdsBiqleucj82u9KUZrGKWz18h9gGWvC8G0zJDfDcBMor
 i9EFoFxNfWTsfxXGS9jLHEbhbz96+1lewn9+jl3Ex54pXi+3pVZU7WkJGxRsXsyhk6va
 RD/A==
X-Gm-Message-State: AJcUukfsJz5njO0fEDGTqP+jZBONA+/JS97PQFODXZ/HqVA12FcbU47k
 CBOZ4fCEVb1dKMUxC02hXMQfobZiv+uJ9gegTk74NA==
X-Google-Smtp-Source: ALg8bN5sdDP3ht0Q+3dpNs8F0AW5GNK00neISF9JIf5Tsy/rBBEp+pnWQiMVHO6fuPR/yh5LJP3x7ljjX3aazzgLwdw=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr19907373ljp.12.1546199711415; 
 Sun, 30 Dec 2018 11:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181229125711.5205-4-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 30 Dec 2018 20:54:59 +0100
Message-ID: <CACRpkdZ95J8LmVbBDJ=ms0sJwV+T4jvQeN-huXOE_pmtB+Ykwg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: meson8m2: mxiii-plus: mark the SD card
 detection GPIO active-low
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_115523_297324_3CD6CF10 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: linus.luessing@c0d3.blue, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 balbes-150@yandex.ru, Kevin Hilman <khilman@baylibre.com>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") SD cards are not detected anymore.
>
> The CD GPIO is "active low" on the MXIII-Plus. The MMC dt-bindings
> specify: "[...] using the "cd-inverted" property means, that the CD line
> is active high, i.e. it is high, when a card is inserted".
>
> Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> drop the "cd-inverted" property. This makes the definition consistent
> with the existing dt-bindings and fixes the check whether an SD card is
> inserted.
>
> Fixes: 35ee52bea66c74 ("ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
