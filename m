Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503612082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQhxVlDH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5qlKNHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503612082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wbah5K75bcyxmNoOsSKtqZBOGbB/EN4z8eOpGiXhSWA=; b=lQhxVlDHHQzZnQ
	ulokAgGfQ+jWA3yAEVeLcWHAJ826bwELNIlttZo6jIulWIor5MtzySwOpPfbQkkX6w8jO/rmL9Rpq
	YQw7oV8xYeIYFSuF3a0dURgCOC5m2gX1scO/i4vYGl8/ViNHQFBznVrZB0ggWiO4cubtHBa5oEELt
	zTuvFYf7OEgB3zJpwwc1OsI9D6y2+NEWglQfVJ44C7dSb4ChTMyabfufQdAfqrQpJdUhLXYfDkcPd
	WDUK226fW/VTp4TtReTgJDJbSjj5UpftJzwsYuCfBjsioG85XGbdyPYNaIPmNhtCI+0cyjFqhDiih
	MSLPE07/ivoyC8FApg/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQks-0000qY-Ha; Thu, 29 Nov 2018 18:09:38 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQko-0000pk-Rj
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:09:36 +0000
Received: by mail-it1-x142.google.com with SMTP id o19so5050705itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3VvKlloFZLEkPTpB6IANQFaVBZdX67Sa3i8aIF1wOTQ=;
 b=h5qlKNHfshis0rHPjp3z+qGXRaWeD4X71aItWnONcBZWAD9pkGjPnjT9pw74pFBNhZ
 O/yidcvwqFz76AsvHVV/R6Gx5+LBZPmDiAKSEp0sN+5H0Hnvo3+fzPe0ZgOBVGKPOKVF
 OoN+77EdFPwSu8uWYtccEsvyVqWksmoiEBUKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3VvKlloFZLEkPTpB6IANQFaVBZdX67Sa3i8aIF1wOTQ=;
 b=f0q2Dz85h9OFC8Rhi7Ae6SvNJ9y0ATIZAX9lk8ixXeZ4jhuOqxLIAcsDCO20jpyNqx
 MNVud836KJsv1a+47OudkYB7yyjWq1UcCwk3kLYRijmFJwNRaZCikM4wqw9hYGef/8TI
 UMTESmlHOZ7AnhOFAq4ZQykyreikdOtppIkqQxzWD3c9sCAAuI6+5Qkov4o8PfK9djaL
 uvFbqjqAFijLB1Pht4dk+vhslLVSZpbCQ//5bZaQaxYbHyEBx09FzUWimrJaKwu/bJdE
 dt+wzSZLaLSgXGaTM92TJ/03IZ/mc6mC0tEV+8OkKSqrQaJEDseD8gH9aZm1XtHNB1ep
 uHYw==
X-Gm-Message-State: AA+aEWbbKckCr6xh+oC/34DbuYmVVAzYt6nmnhPTsAPSaZgcCNUfhI8h
 oIaSxp2WElqzanGOCLyD/ECn/ekSWX41KlvHF73CS3zb
X-Google-Smtp-Source: AFSGD/Ve07yvxbqRZgwtriQ/JDAHw0ByIxNEi8hwrXkZNoBnm4HEVPvCvQFK+GIawLrHtQ6fKuefSN2mDp80s+vy9Og=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr2687617ith.158.1543514963110; 
 Thu, 29 Nov 2018 10:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
In-Reply-To: <20181129170048.GQ3505@e103592.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 29 Nov 2018 19:09:10 +0100
Message-ID: <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_100934_914392_6F804757 
X-CRM114-Status: GOOD (  25.88  )
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
Cc: linux-block@vger.kernel.org, liuyun01 <liuyun01@kylinos.cn>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:
> > This is a NEON acceleration method that can improve
> > performance by approximately 20%. I got the following
> > data from the centos 7.5 on Huawei's HISI1616 chip:
> >
> > [ 93.837726] xor: measuring software checksum speed
> > [ 93.874039]   8regs  : 7123.200 MB/sec
> > [ 93.914038]   32regs : 7180.300 MB/sec
> > [ 93.954043]   arm64_neon: 9856.000 MB/sec
> > [ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)
> >
> > I believe this code can bring some optimization for
> > all arm64 platform.
> >
> > That is patch version 3. Thanks for Ard Biesheuvel's
> > suggestions.
> >
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  arch/arm64/include/asm/Kbuild |   1 -
> >  arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
> >  arch/arm64/lib/Makefile       |   6 ++
> >  arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 263 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/xor.h
> >  create mode 100644 arch/arm64/lib/xor-neon.c
> >
> > diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> > index 6cd5d77..1877f29 100644
> > --- a/arch/arm64/include/asm/Kbuild
> > +++ b/arch/arm64/include/asm/Kbuild
> > @@ -27,4 +27,3 @@ generic-y += trace_clock.h
> >  generic-y += unaligned.h
> >  generic-y += user.h
> >  generic-y += vga.h
> > -generic-y += xor.h
> > diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> > new file mode 100644
> > index 0000000..856386a
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/xor.h
> > @@ -0,0 +1,73 @@
> > +/*
> > + * arch/arm64/include/asm/xor.h
> > + *
> > + * Authors: Jackie Liu <liuyun01@kylinos.cn>
> > + * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/hardirq.h>
> > +#include <asm-generic/xor.h>
> > +#include <asm/hwcap.h>
> > +#include <asm/neon.h>
> > +
> > +#ifdef CONFIG_KERNEL_MODE_NEON
> > +
> > +extern struct xor_block_template const xor_block_inner_neon;
> > +
> > +static void
> > +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_2(bytes, p1, p2);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3, unsigned long *p4)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> > +     kernel_neon_end();
> > +}
> > +
> > +static void
> > +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> > +             unsigned long *p3, unsigned long *p4, unsigned long *p5)
> > +{
> > +     kernel_neon_begin();
> > +     xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> > +     kernel_neon_end();
> > +}
> > +
> > +static struct xor_block_template xor_block_arm64 = {
> > +     .name   = "arm64_neon",
> > +     .do_2   = xor_neon_2,
> > +     .do_3   = xor_neon_3,
> > +     .do_4   = xor_neon_4,
> > +     .do_5   = xor_neon_5
> > +};
> > +#undef XOR_TRY_TEMPLATES
> > +#define XOR_TRY_TEMPLATES           \
> > +     do {        \
> > +             xor_speed(&xor_block_8regs);    \
> > +             xor_speed(&xor_block_32regs);    \
> > +             if (cpu_has_neon()) { \
> > +                     xor_speed(&xor_block_arm64);\
> > +             } \
> > +     } while (0)
>
> Should there be a may_use_simd() check somewhere?
>
> If we invoke this in a softirq I don't see what prevents us from
> corrupting the task's NEON state.
>
> (The check might be in some surrounding glue code that I missed...)
>

There is no check. This code should simply not be called from
non-process context, same as the RAID56 code.

This is not terribly robust, obviously, but appears to be common
practice in this realm of the kernel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
