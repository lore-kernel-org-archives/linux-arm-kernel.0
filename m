Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3A220665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U65ISdL7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IY8xSVKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3A220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gQ6W8gSPD6RqEZyJM9ntHiAeExohv32y7v2mF76+Lnk=; b=U65ISdL7Pi0bgY
	6LLuhuYJrY3HoQ3yFN/bljdExGloSuph6aFwOJpFDFdchQ7YbfXssHSiyFtklvv9zixE3Onso2yLJ
	Y4gox1RtSzC7/fDkVbR+f29ONqCtiATm5aoU4vagB2LqYIAip12aXx/Slu9NzgWEUTlOvzetcTs+m
	O24nHj3J+707N3os5jbZMkxqj/Y17GZg/xR1R/1zRI68Y7VwtctWth0SWlQhCCF+gujAS8NubxhvU
	IOziJozfpB4N2wHNU1UXVRHRyS91PkJgMVVxcmBwK9HJieKRNJhOLU+hHJPTCejnPbsE2J2SxS910
	NlauLSkQy2jwxol41XYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIdD-0001GP-2H; Wed, 09 Jan 2019 18:31:11 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghId9-0001Fj-Bc
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:31:09 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so7380991ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ce/DODD26yFEvlMGuasUOyI+VFOgUCm+7GsCPyVgRv4=;
 b=IY8xSVKBxUihEieMmiVeZWlluuxX+wotnXcvpzcCJW3eo+hdTOHWSsR5o5pDJCjBJk
 zPf/Mo9wlkwaAk1Pp8GgB91IMTBD1/17RbQ0tNVp/pLSlIEkaN5PAeS0715SXGIaTeNl
 1OHEzC1fC1LYVzESSkOwI9KWg09cg9PZa7uH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ce/DODD26yFEvlMGuasUOyI+VFOgUCm+7GsCPyVgRv4=;
 b=JgPMeBKjRCXxoEVPWK3MUDmIHnfuAX+NzZAk2JeXLi3hpBwGEXm8fozUkGfkGeneLE
 s2PRrsA2JQtHEFSd+NmRR1HFJguqh4CtGEtcZCaFM9eLMzFmZW/PWM4tHYLMyfX0R1KU
 PXBND/vzeYoWh6xgUD/qYhDGy6uJAPjulji1Q7P7VcwS9UApN51iDKhmjRJLziljf+6A
 ODi4juDqkiIaYxCQqfG+bDZxcUevrCJAy+e8o/fZ5AAiDW3pKXDCBWLDZ+aiG++BcY6+
 /yZoHcvFYp1pQFTO/ktcyKafF2MaST0Z2M2qSz+DnzWzBNHK+wD0eXzkXxLGXx2iIvFE
 Ds/g==
X-Gm-Message-State: AJcUukfHU0ZkVe5VngZHTO6C/xh0mJa2Os59Zb0qJN/1iyVYpMuLZMMq
 YLvT/F4naDjOpYRU2EVyq41U7jBez7ShnRxlX2bJzA==
X-Google-Smtp-Source: ALg8bN4jIAccrE+Ui7PhA4BsjD7tt+eW6OjQ7jBZdVPqs7ct/u0Ni8dEYUBnmp98bWowikeVQrE1VRw11OmNeCaQhlg=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr4088776ljj.9.1547058665214; 
 Wed, 09 Jan 2019 10:31:05 -0800 (PST)
MIME-Version: 1.0
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
In-Reply-To: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Jan 2019 19:30:52 +0100
Message-ID: <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
To: Loys Ollivier <lollivier@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_103107_399452_AA74E9D9 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ollivier!

On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> wrote:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "acitve high".
>
> Fix the SD card for meson by setting the cd-gpio as "active low" according
> to the boards specifications.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>
> v2: fix more occurences, also in other meson boards.

This is a good change in itself since it gets rid of some occasions
of the dreaded "cd-inverted" property. I think Martin Blumenstingl
already sent patches like these though (I might be confused).

But we should keep the old device trees working as well.
Can you test if Martins patch:
https://marc.info/?l=linux-mmc&m=154637189021211&w=2

Also makes your boards work?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
