Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:30:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81346206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YFNvGvsG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xr55jgAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81346206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PPHVHJF51TenrD0g8rLRvg7mO09hfPWhgSTc/ZY0jvU=; b=YFNvGvsGVDD6XX
	noM3zPbl753VKJK8iZnsiAm2QdPvuTMAFGv6XioUfAmshOIdaYnCavxu8sQpHooCdTRrexKoNaMGv
	5PshOedig8KquTejuvCr+bL9U5TgVIx0lr95pxmEqxLhSM9iH769hPR4x7iG9lO+/Jw2WVJBaHNlQ
	I0SKxE/NduUPsapyhpIcgak1Z+G1Lx7CRr1rGuRRSDzQwF8bfhq8nZaZa0vg/Hy/L8sqgrpDFqPaq
	rSMY3c1y0XMQ1B2oYV6b5ct/ZyzZwLS48cGKzfxfLNc1Gd/7fEmej8CpWX1tRGP/qm1Pt0fee2bqh
	ht79UIqeNjZu9K5vkdGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghMMy-0002Zv-3f; Wed, 09 Jan 2019 22:30:40 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghMMu-0002ZJ-Ro
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 22:30:38 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so8209614otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xLWY6Pk/ualqBVtv+OfnoGEuQRZ9pIAPaVj1nvw9h/c=;
 b=Xr55jgAiVrMt/SKUOwSy3JhjfieyRHJqOlLNx2YsJNzJnSp2VhGrPYkgzAPVCIn5C0
 VQXiKH9ENIoNzIl6cJR79y3bAGIEfht2JNNjs34kFFt74W6DZNDlUcly/QvAQu0ePLph
 CdgAQWXOunKtbJJkKwK52Geifug7VMp5h/WcNloOxGNnvlYW8Rm4M++kd4bnsiLbD9Zh
 Vzk0PZRmjRul9bGQxXxHYP1lIdyDW/oFJ40u4b8P5mx0IkuUVZgXUDnmALz32WrOK0+f
 YKaEkqfPNwwBENbAsc0aTqTtMtJGuJ+oqWHkj+tVzAV+QDAy3rrvD0IXBLkXjXTTWVUb
 UqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xLWY6Pk/ualqBVtv+OfnoGEuQRZ9pIAPaVj1nvw9h/c=;
 b=DwnBY0OGr6pzuG1502wQvsyUJKXRIoC463CYJJAfLyqUKgZ4uJIkWEX+SYui/Nzmv6
 0t8gMdyQGkIG/HrhgsD2bqcgtKg1+NdvEgih6S0AoT6zSGi+Ak7KCBMI4McdxKAPTiG1
 qaBzll3OL5xdemcX0khzHkTPPVdvZDXri7KpKhxsWSgvkLVyH9okH5jIOkx2LZn2lri/
 Mwy3JBWwWvQrcfVLcRmQ7yqAfUUMngk+HeLwdaAaK8MEfosba2mpR/kIwAl3DfH5geNy
 qt4xE/1jH7J4SwuSKnUSgFxbRKY8gweeW2KSJAI6fuV+r+m9h6evUYFOzM65PCeS23TD
 R91Q==
X-Gm-Message-State: AJcUukeb2svBfqay1bboNdfmDU7/j+oLJnRlv76Bm6Y92wmvMfMYrGIj
 ePc8RVnFa/vzgiDhJBjJsUIW+pIb956+dUjxlag=
X-Google-Smtp-Source: ALg8bN4KMr5LYE/CvqC1gBMKCYEb9cuejjk3Bnd9kCO9zHMbKGdbgZRVUjLdyxZCqMkoSCdWBdOsdqY4NXAtnNmr458=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr5331851otj.148.1547073035745; 
 Wed, 09 Jan 2019 14:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
 <20181223235836.12466-2-martin.blumenstingl@googlemail.com>
 <154705938114.15366.1098954164811397084@swboyd.mtv.corp.google.com>
In-Reply-To: <154705938114.15366.1098954164811397084@swboyd.mtv.corp.google.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 9 Jan 2019 23:30:24 +0100
Message-ID: <CAFBinCAginPSuBObJE52puvbay-S698OjAj6aLEm5kfn0SdU0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: meson: meson8b: fix naming of the APB clocks
To: Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_143036_920803_C0FF4736 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen, Hi Neil,

On Wed, Jan 9, 2019 at 7:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Martin Blumenstingl (2018-12-23 15:58:36)
> > Fix a typo in the APB clock names by renaming them from "abp" to "apb".
> > No functional changes.
> >
> > Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
> > Fixes: a7d19b05ce817d ("clk: meson: meson8b: add the CPU clock post divider clocks")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
>
> Can I apply this directly to fixes? Or it's not critical so we can punt
> until next merge window?
actually it's not critical:
I'm not aware of any IP block that I needs the APB clock as input (I'm
pretty sure there is some, but I'm not aware of it so it can wait).

Neil already applied another patch for -next which conflicts with this.
we can choose now:
1. Stephen takes this patch, Neil drops the (conflicting) GPU clock
patches from -next and I re-send the GPU clock patches
2. Stephen and Neil don't do anything, I re-send this patch on top of
the GPU clock patches

I'm fine either way, but #2 is less work for you guys.
if I don't hear back from you then I'll go with option #2


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
