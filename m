Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E12217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KXWyuAG5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3tRzfQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E12217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KDe0eyVYRqolMOxOkDJAP6y2rpHiX8ldu5Yodg8Hg8o=; b=KXWyuAG5y0a7Py
	+Cs6xG6CjdYi10cTEpSHQAyRVI5zlb6HebTrBmLpXes4uFhQkO4+pme0XuZ0qCpr3/pePSEa1fuv/
	QqIEoz1+4mydoGJr7k722KzrB37VwqLJCKNIhNRK2C47tDAIr1D4ikEFQnLobe8qPw5hHpwf392PD
	U06lRkR0CJbxAKdo1N/c+Ze+fF9B5wl3E5DqwP9q+1L/fQBm4FH/k9q4FZEKRECKsz7HuLoeks6IW
	d2foe71aMf84ulNdzy1Hsx9T48GTsgYgDp4U2sF658OdSXwr8TuKFwg7s+4z+XMylBpqMNYs1gLue
	ydJaVkC2QxN4XvJ7MnoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwEI-0004Da-LE; Fri, 25 Jan 2019 07:48:46 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwEF-0004DD-KJ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:48:45 +0000
Received: by mail-io1-xd43.google.com with SMTP id g8so7034124iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9KQ4D/VMCjgV8L/LGDfb0EIfdVa2OsRhqD76smr04P0=;
 b=A3tRzfQUTuFxnAHGQPsDKw0+HglXq/lR1zbdU1g7AoqmGeRDR9Iz9Y6e+mXw06cHKs
 fEnK9JDPm9nQwjj7rWqaDvQ9Xyang2jad8oQlc/cDFncpxlEYku//N+CwXo4Gc3PAe4Y
 1hMyqjd+wa/Soj94IpsvGJM2jD3MqHLWEp90c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9KQ4D/VMCjgV8L/LGDfb0EIfdVa2OsRhqD76smr04P0=;
 b=YUyGMWsx+ABPDqnrGKrybzbLAAVKultUiivxRbOoWpQn7seXOl99+lx8wAgiI2QwRa
 oZHVdIdnUhnIcXxc37GR4Y05VNvw9DFEZDhLdXWSpZGwb63+8nP3vjY4tN46mpvvQy9R
 q6Rhh8xIZhU0Mohhs4BlqbstGLmgdAV/pvql4rQiRK37hXEUhI4NbKp2bWos9CO0RLDI
 rHb52RuGYqj2RHVQ7L5GXPG//qaKgIeUPP6JAr6F9UnzNxTD1F98IIVYlfTiu/eONAQe
 fL8ry8hYbBwlTh+8o/d0k2Vbtb5hV4JIWSyci3UrJyxopwgrNUKBr8P0UWejtBK5w1Jp
 sffw==
X-Gm-Message-State: AHQUAuaSq2p01gI9hVxOToDbpYg5z5lhv+KoEUm2BVx9c8K6g7jX+qRl
 2/qlX43L9RUS/Gs3AcXzPPG9aV43GDtlbJ0ikR5hYQ==
X-Google-Smtp-Source: AHgI3IY+kZoHX9DZ7Fw7qYZOH9lZyvWWBOtFh7Lbyv7uhycPI5thUuA9BgXirJOTyFLVHSDwDee3Og++OEhaFLAOjxg=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr5631292iob.170.1548402522526; 
 Thu, 24 Jan 2019 23:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
 <20190124182712.7142-2-ard.biesheuvel@linaro.org>
 <20190125072234.GB700@sol.localdomain>
In-Reply-To: <20190125072234.GB700@sol.localdomain>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 25 Jan 2019 08:48:31 +0100
Message-ID: <CAKv+Gu864GTrA36dTTmNsriCpbj-eghS-9fRSA=DMGvFUW8nxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: arm/crct10dif - revert to C code for short
 inputs
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_234843_677344_7218463E 
X-CRM114-Status: GOOD (  25.43  )
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

On Fri, 25 Jan 2019 at 08:22, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Jan 24, 2019 at 07:27:11PM +0100, Ard Biesheuvel wrote:
> > The SIMD routine ported from x86 used to have a special code path
> > for inputs < 16 bytes, which got lost somewhere along the way.
> > Instead, the current glue code aligns the input pointer to permit
> > the NEON routine to use special versions of the vld1 instructions
> > that assume 16 byte alignment, but this could result in inputs of
> > less than 16 bytes to be passed in. This not only fails the new
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
> Can you add proper tags?
>
> Fixes: 1d481f1cd892 ("crypto: arm/crct10dif - port x86 SSE implementation to ARM")
> Cc: <stable@vger.kernel.org> # v4.10+
>

Ah yes, thanks for digging that up.

> Just double checking as I don't have a system immediately available to run this
> one on -- I assume it passes with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y now?
>

Yes.

> Another comment below:
>
> > ---
> >  arch/arm/crypto/crct10dif-ce-core.S | 20 ++++++++---------
> >  arch/arm/crypto/crct10dif-ce-glue.c | 23 +++++---------------
> >  2 files changed, 16 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm/crypto/crct10dif-ce-core.S b/arch/arm/crypto/crct10dif-ce-core.S
> > index ce45ba0c0687..3fd13d7c842c 100644
> > --- a/arch/arm/crypto/crct10dif-ce-core.S
> > +++ b/arch/arm/crypto/crct10dif-ce-core.S
> > @@ -124,10 +124,10 @@ ENTRY(crc_t10dif_pmull)
> >       vext.8          q10, qzr, q0, #4
> >
> >       // receive the initial 64B data, xor the initial crc value
> > -     vld1.64         {q0-q1}, [arg2, :128]!
> > -     vld1.64         {q2-q3}, [arg2, :128]!
> > -     vld1.64         {q4-q5}, [arg2, :128]!
> > -     vld1.64         {q6-q7}, [arg2, :128]!
> > +     vld1.64         {q0-q1}, [arg2]!
> > +     vld1.64         {q2-q3}, [arg2]!
> > +     vld1.64         {q4-q5}, [arg2]!
> > +     vld1.64         {q6-q7}, [arg2]!
> >  CPU_LE(      vrev64.8        q0, q0                  )
> >  CPU_LE(      vrev64.8        q1, q1                  )
> >  CPU_LE(      vrev64.8        q2, q2                  )
> > @@ -150,7 +150,7 @@ CPU_LE(   vrev64.8        q7, q7                  )
> >       veor.8          q0, q0, q10
> >
> >       adr             ip, rk3
> > -     vld1.64         {q10}, [ip, :128]       // xmm10 has rk3 and rk4
> > +     vld1.64         {q10}, [ip]     // xmm10 has rk3 and rk4
>
> This one is loading static data that is 16 byte aligned, so the :128 can be kept
> here.  Same in the two other places below that load from [ip].
>

OK, will change that back.

> >
> >       //
> >       // we subtract 256 instead of 128 to save one instruction from the loop
> > @@ -167,7 +167,7 @@ CPU_LE(   vrev64.8        q7, q7                  )
> >  _fold_64_B_loop:
> >
> >       .macro          fold64, reg1, reg2
> > -     vld1.64         {q11-q12}, [arg2, :128]!
> > +     vld1.64         {q11-q12}, [arg2]!
> >
> >       vmull.p64       q8, \reg1\()h, d21
> >       vmull.p64       \reg1, \reg1\()l, d20
> > @@ -203,13 +203,13 @@ CPU_LE( vrev64.8        q12, q12                )
> >       // constants
> >
> >       adr             ip, rk9
> > -     vld1.64         {q10}, [ip, :128]!
> > +     vld1.64         {q10}, [ip]!
> >
> >       .macro          fold16, reg, rk
> >       vmull.p64       q8, \reg\()l, d20
> >       vmull.p64       \reg, \reg\()h, d21
> >       .ifnb           \rk
> > -     vld1.64         {q10}, [ip, :128]!
> > +     vld1.64         {q10}, [ip]!
> >       .endif
> >       veor.8          q7, q7, q8
> >       veor.8          q7, q7, \reg
> > @@ -238,7 +238,7 @@ _16B_reduction_loop:
> >       vmull.p64       q7, d15, d21
> >       veor.8          q7, q7, q8
> >
> > -     vld1.64         {q0}, [arg2, :128]!
> > +     vld1.64         {q0}, [arg2]!
> >  CPU_LE(      vrev64.8        q0, q0          )
> >       vswp            d0, d1
> >       veor.8          q7, q7, q0
> > @@ -335,7 +335,7 @@ _less_than_128:
> >       vmov.i8         q0, #0
> >       vmov            s3, arg1_low32          // get the initial crc value
> >
> > -     vld1.64         {q7}, [arg2, :128]!
> > +     vld1.64         {q7}, [arg2]!
> >  CPU_LE(      vrev64.8        q7, q7          )
> >       vswp            d14, d15
> >       veor.8          q7, q7, q0
> > diff --git a/arch/arm/crypto/crct10dif-ce-glue.c b/arch/arm/crypto/crct10dif-ce-glue.c
> > index d428355cf38d..14c19c70a841 100644
> > --- a/arch/arm/crypto/crct10dif-ce-glue.c
> > +++ b/arch/arm/crypto/crct10dif-ce-glue.c
> > @@ -35,26 +35,15 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
> >                           unsigned int length)
> >  {
> >       u16 *crc = shash_desc_ctx(desc);
> > -     unsigned int l;
> >
> > -     if (!may_use_simd()) {
> > -             *crc = crc_t10dif_generic(*crc, data, length);
> > +     if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
> > +             kernel_neon_begin();
> > +             *crc = crc_t10dif_pmull(*crc, data, length);
> > +             kernel_neon_end();
> >       } else {
> > -             if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
> > -                     l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
> > -                               ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
> > -
> > -                     *crc = crc_t10dif_generic(*crc, data, l);
> > -
> > -                     length -= l;
> > -                     data += l;
> > -             }
> > -             if (length > 0) {
> > -                     kernel_neon_begin();
> > -                     *crc = crc_t10dif_pmull(*crc, data, length);
> > -                     kernel_neon_end();
> > -             }
> > +             *crc = crc_t10dif_generic(*crc, data, length);
> >       }
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
