Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2C5218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GJFM0yod";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUY3hEdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2C5218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xyhPAIiiZC8qKDLexozIhRyM4B8Rd2edMcHswy4fX9U=; b=GJFM0yodLs4kZ8
	/KJqTKsT8Nqd6ttjsR/RxS/LUNW5BzK5ID1g76BJ5PrmpJxnZ3rZsShIe8wvhHwyeNDlYkUTtTwu3
	QdGeinMcyztPM/MseFG6vfI4cXxCf1BebzLIpjuOlu8LHYEY99FIt566Z3fyRnW/41/bJo3ls2mdh
	TaLdyVmlwm3zxrOnmDxdj4mjKsJ53IBZnF6w2s0dOHQ+XXhtq4jC8Tir1/rVJil04hYi9wbjgTQNe
	Dmh0znA3iOs19nbHGJRTSb70IUiJ57TZiBFfn84WnhJ0Zm34oaEjn/S802hQJqYm/1NblEZgu4J5/
	+EHjeNYP2kEQUH/p0z5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwFM-0004UT-Uf; Fri, 25 Jan 2019 07:49:52 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwFJ-0004U7-Nz
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:49:51 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so8459945itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 23:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/pADXBfQMBB0ZhOXN56Df7WzUKfxqN8DN7uguFJDGBI=;
 b=LUY3hEdbRMUIs72HUlLQ4Z45esUjzJ7KuDxlRqy1cGqcci5WEcLlr4pGxl7HXTV6oN
 PHJRzu/8bpkfjD1laSn4x6AHJXjXq9P5/N0XZYeJZx+Cp042TlBVns3e0wpvecWqz+2W
 rpkd5JjTLB8BAzpNvFFtgcWcXolFDHwjFOsig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/pADXBfQMBB0ZhOXN56Df7WzUKfxqN8DN7uguFJDGBI=;
 b=WFywL5VUA3TKFKQBqTW+bnfljTVOV0okZFsLuk16163C71rhYDU1GPvUUWals5kkiq
 DPNQni4+5ukLAaBFHrGNz+EMM7IUVjjl0hZsvS5OxAPsDZbCw8nKF8mcZwTC0sGcblJu
 z2DJviZgX1z1LWDVBdgOcxL29PyrSvfzpLUrTLB61wIQxqsmkKGAT4kQXdsAv3rtji1H
 72xOicZAbhdbcSVdeRxR7DWQF55k1IhUxuViVn3Vs++vAeSM0PxFqhj78q3LlclTDx7c
 D+ZTUUmUdfhZHXcO/jglmgXIQ03fExJY6VthLOEHlrOZ/cNEn+NmCw8ZglzQmzmX6cV0
 /TEQ==
X-Gm-Message-State: AJcUukeL8zlo3hGvqfcMLe42JuQDdMZdUA+00V5UZfT+Q2fpt4XwSCT0
 pe1p57JvHAd+tcQtvqVU8GoKaovr8PMUroJ0tqTUOw==
X-Google-Smtp-Source: ALg8bN4dFevJSD2Sh54TewH77Sv/BehSnrO6i++8XF/4am8+FiTXqOneIsnFhuW3fZmPA5wKBpClJXk6aPJbxu2UkZE=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr3875676ith.158.1548402587357; 
 Thu, 24 Jan 2019 23:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
 <20190124182712.7142-3-ard.biesheuvel@linaro.org>
 <20190125072948.GC700@sol.localdomain>
In-Reply-To: <20190125072948.GC700@sol.localdomain>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 25 Jan 2019 08:49:36 +0100
Message-ID: <CAKv+Gu_=NOiATKH1LgWYggBsfAUBU3DkDyFPv8NG=DgtA+sQyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: arm64/crct10dif - revert to C code for short
 inputs
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_234949_792720_33794E77 
X-CRM114-Status: GOOD (  23.97  )
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
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 at 08:29, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Jan 24, 2019 at 07:27:12PM +0100, Ard Biesheuvel wrote:
> > The SIMD routine ported from x86 used to have a special code path
> > for inputs < 16 bytes, which got lost somewhere along the way.
> > Instead, the current glue code aligns the input pointer to permit
> > the NEON routine to use special versions of the vld1 instructions
> > that assume 16 byte alignment, but this could result in inputs of
> > less than 16 bytes to be passed in.
>
> This description doesn't quite match the patch since the arm64 version of the
> assembly doesn't use any alignment specifiers.  I take it that actually means
> the alignment in the glue code wasn't necessary in the first place?
>

Not for correctness, but it could affect performance.

> > This not only fails the new
> > extended tests that Eric has implemented, it also results in the
> > code reading before the input pointer, which could potentially
> > result in crashes when dealing with less than 16 bytes of input
> > at the start of a page which is preceded by an unmapped page.
> >
> > So update the glue code to only invoke the NEON routine if the
> > input is more than 16 bytes.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Can you add:
>
> Fixes: 6ef5737f3931 ("crypto: arm64/crct10dif - port x86 SSE implementation to arm64")
> Cc: stable@vger.kernel.org
>

Will do

> > ---
> >  arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++---------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
> > index b461d62023f2..567c24f3d224 100644
> > --- a/arch/arm64/crypto/crct10dif-ce-glue.c
> > +++ b/arch/arm64/crypto/crct10dif-ce-glue.c
> > @@ -39,26 +39,13 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
> >                           unsigned int length)
> >  {
> >       u16 *crc = shash_desc_ctx(desc);
> > -     unsigned int l;
> >
> > -     if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
> > -             l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
> > -                       ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
> > -
> > -             *crc = crc_t10dif_generic(*crc, data, l);
> > -
> > -             length -= l;
> > -             data += l;
> > -     }
> > -
> > -     if (length > 0) {
> > -             if (may_use_simd()) {
> > -                     kernel_neon_begin();
> > -                     *crc = crc_t10dif_pmull(*crc, data, length);
> > -                     kernel_neon_end();
> > -             } else {
> > -                     *crc = crc_t10dif_generic(*crc, data, length);
> > -             }
> > +     if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
> > +             kernel_neon_begin();
> > +             *crc = crc_t10dif_pmull(*crc, data, length);
> > +             kernel_neon_end();
> > +     } else {
> > +             *crc = crc_t10dif_generic(*crc, data, length);
> >       }
> >
> >       return 0;
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
