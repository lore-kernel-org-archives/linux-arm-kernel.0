Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC422C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:03:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C8B21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="esG+HM95";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DBYTZsgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C8B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bU6M/AuPpZchxKBjn61stmh8bJ2Apdqq8iHB8U7FAtA=; b=esG+HM95e3yGcG
	PjqehcoVPk1vFJLNpI0DbO9CAKMoZMw/pZa85p2lWdSL+nZcn3tu3iuy4xuIReapOM957TCnWfiOr
	0uz4C9onjk6ogWSUamZ90h0Jbda9nWY/DrLEodqe+4T5QWit3A7HWnglKAf91CfuLb5e5Klz/kvVm
	8xtMcCDCdhZLNE5YaF0UY2zm3fF1eAiZMq0kTpIRnLw4YHzZzZ9XLA77UDAcQK5yRWky4E5y7Ta2z
	DYS52j4ZzwjX0pFkSiAFcirmnIjV6OMlQPvmTVGzKsL/yuXIgGJ7fump1CTYsSAEhAXh+DNVbtHfo
	mYoRcjQxTr/Bt38j59yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdvLt-0006WG-7h; Mon, 31 Dec 2018 11:03:21 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdvLp-0006V8-50; Mon, 31 Dec 2018 11:03:18 +0000
Received: by mail-oi1-x243.google.com with SMTP id w13so21680412oiw.9;
 Mon, 31 Dec 2018 03:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rak2wfNDO84QeXnOlJ08jzJBrSTyZVxgQfN5/5p4nQQ=;
 b=DBYTZsgyUGnYosNP3eP1AxZBWHuMX39H4BHsQzu41M45khRFWk3Ld5PVMJZW61wkLR
 cva+QYrhKsytrZBY26VZ5kO1JQgqkp4JhYaXXlJ8GX0MCLTyDDVcivhsfbUNgCYyld7O
 7hZFAEudv9g8h/mu967Ftqcge/+h2STvkBTFa3vs48fSK+u2lngLpzp9efc0LNBeU3Iq
 DHrdHfMYbtDYVNhgs45pNr6ywbCPUOtWp5GywR9Gv2gSZYCZiL2mR09tpfqiVyG9zUyn
 NJnXskaY7WCSWAO8kTz2i9Aa4cczJ01M2gVMXNEFKhR4+Bv2UZToE2LRvRQrOCSiAu4Z
 a/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rak2wfNDO84QeXnOlJ08jzJBrSTyZVxgQfN5/5p4nQQ=;
 b=jg8kVxoqekCI9ikqqoBi9IgtDzFB2FWnIU0pWs01/R1wbQvKK8wmRtWzOG8Y/MzidE
 lHE88KvyYpIVwk9s+mrBF5aPHgMVADKbJimmoDst1aYme1c7xmDDS8LDoZRs8gNNuSLm
 dOUa+3712QzyMkb5V6l70orbN2F8uTn93t814rP1U7A2uM04urmUiqWYIbqJAyb8Bs1h
 n2qpvV//6aeKVebdxn1soYbO5GUwYVn0V7rEuGXhKUIX30C+8EOBQy1A/TnH8QjB103S
 Cu0zO/6FHTXIxyL5/4CfMX+7/YlEjdYZx0HWuGffWmMkMRKsP/nYISHO9wrpt9dqkvPv
 FN2w==
X-Gm-Message-State: AA+aEWbAvX1dH9upoq1O1kcjL6ujv9R2OKk0qcgnkjfzQTpUkgjH38Y/
 UJ0RT61wn1Q6sRVRnIyE8+BzkpLYPFZwacOkl8w=
X-Google-Smtp-Source: AFSGD/XyV5mcXpVEZ4BSwXqtjj+g7tALllnBjrQyXHyAVViJu7W0szTl1hBuPmaYgDTYEZeVV03bLbAvFonufZtARDs=
X-Received: by 2002:aca:3586:: with SMTP id c128mr25505245oia.47.1546254195995; 
 Mon, 31 Dec 2018 03:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <CACRpkdZ4bex+wm4vGWhDLSAsXnaVeHWEp6Rf4g8NQZmXnFfneQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ4bex+wm4vGWhDLSAsXnaVeHWEp6Rf4g8NQZmXnFfneQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 31 Dec 2018 12:03:05 +0100
Message-ID: <CAFBinCBG-==df7swBsWvg9banuxH5JFyHRAwv2poZUMa3h3MVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_030317_196263_D83F15C0 
X-CRM114-Status: GOOD (  16.76  )
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

Hi Linus,

On Sun, Dec 30, 2018 at 8:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
> > However, while reviewing the .dts files for the 32-bit Amlogic Meson
> > boards I found that the cd-gpios are specified incorrectly in the .dts.
> > Documentation/devicetree/bindings/mmc/mmc.txt states: "[...] using the
> > "cd-inverted" property means, that the CD line is active high, i.e. it
> > is high, when a card is inserted".
> > This is not the case on all currently supported 32-bit Meson boards, so
> > this switches the cd-gpios
> > - from GPIO_ACTIVE_HIGH with the "cd-inverted" property being set
> > - to GPIO_ACTIVE_LOW with the "cd-inverted" property being absent
> >
> > This fix also works even if the following two commits are reverted:
> > - 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> > - 81c85ec15a1946 ("gpio: OF: Parse MMC-specific CD and WP properties")
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
thank you for reviewing my series!

> Thanks for looking into this, I think fixing the device trees is
> orthogonal to fixing the issue I created, let's fix both!
I fully agree. if I still have time I'll look into a patch for the MMC
core later today, otherwise I'll try to do it tomorrow


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
