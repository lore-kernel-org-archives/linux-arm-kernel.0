Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB45C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C5020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BUPAXxWa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIifzmPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C5020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tEZ2N2cS4GW0QKHfnok/l5fMt8LwPzlzyJ03cLS8W48=; b=BUPAXxWaDEpE/0
	aJlsL04tu7jm8cuqtzCgFhy5vTWwxNLsnHn5YeJyvrtwycGrvAy91Tb4eMbRw7ubBQspry1PCVYkv
	K7Uo5Z7IpnUcat/TTOtwg1D7ZXo95iRcENPSqlDj1EmrbnaSOlXaOAKK2AD25gIkCb1cc8kEZDUw7
	koIoW1e1fM3IX7XPj35cClwt9LZ+DSaa/49Ov39Hkid0oOiOFiB2tIqkhdIP6VDq1TrABw5blWHhF
	E5AiLO5yc+SBzRQgCnHI/G1HAkc/4MTHiJ37VU4QrAfW4+xpXQFAyKwFSVXTNB7aO96QGcJ/3Rdny
	4mxKvwtCL9x3T1KDQnEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd9T-0001u6-3L; Thu, 24 Jan 2019 11:26:31 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd9P-0001th-OC
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:26:29 +0000
Received: by mail-it1-x144.google.com with SMTP id m62so4355827ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wYYDIZC0ZN9AMXQL3vOyxwdVx9TvTCIi6QQpdmvhI+4=;
 b=YIifzmPEIpkCk/CFNx0FQasSOzULmpRwmmbHtG9bdFFTqd7hPxDKOAhkYWOshfMG9U
 5iLJVXV/qbSb6l2jK7MhsghJsMJVvHTcGUktnsFJQIF/+/10c8vRnsRzCAKZHHDqsF1N
 6GjY2eEtXbAew9VwFbewbQms/uGqSHoDtQQmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wYYDIZC0ZN9AMXQL3vOyxwdVx9TvTCIi6QQpdmvhI+4=;
 b=ZZgjAoAlYUmvrIifKGMlJl3ZR687O2wPU4tpNUutW/dogyMeise9sNaR1MPkMx5Gig
 t/8naSGCSwT1b4AKPxqSdnLcB/poEIDKyA9ZnBaRvf/7gnEi3tIVLICfOrfU+FeHhbFg
 KG/iVj3Zhqs/wyi8i9nLqHD8Is0lXWx3WJOHnFMWPXMHpkGrb0li6QLrbWNkDcOdrvlI
 68JUqbvLqs3QzfO7IqnKuKXLOMnHJZL3mqv3LLu67/4dZxPW2PBS3pmBgj8j6rQOKQhm
 1OSXkmMQm+zGF6bJNxNT1Bso1gzwkEHF10AqvOVKhvZ5pMb5njS7kB7ohwh1YTeyteqr
 CRkQ==
X-Gm-Message-State: AJcUukeT+hajFBCbKQm/Yp/M7vwo0LBgw7sbsMe5j2lbo0GdGF/764px
 FWTZNfSs/hZiURj1GTv0tp83RHalPxAMJo+MuKv3/w==
X-Google-Smtp-Source: ALg8bN5Qirvee4cj0+G+OHBW4ZJWfWnzhIaOdLarAZ+wKU1LOI4NQw6yzf2KnVatfnJc5KOYvnIO+D4XRuts4eo59E8=
X-Received: by 2002:a02:183:: with SMTP id 3mr4017791jak.130.1548329185953;
 Thu, 24 Jan 2019 03:26:25 -0800 (PST)
MIME-Version: 1.0
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
In-Reply-To: <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 12:26:14 +0100
Message-ID: <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_032627_790477_330D458C 
X-CRM114-Status: GOOD (  20.82  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 12:23, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 10:59 schrieb Ard Biesheuvel:
> > [SNIP]
> > This is *exactly* my point the whole time.
> >
> > The current code has
> >
> > static inline bool drm_arch_can_wc_memory(void)
> > {
> > #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
> >     return false;
> >
> > which means the optimization is disabled *unless the system is
> > non-cache coherent*
> >
> > So if you have reports that the optimization works on some PowerPC, it
> > must be non-cache coherent PowerPC, because that is the only place
> > where it is enabled in the first place.
> >
> >> The only problematic here actually seems to be ARM, so you should
> >> probably just add an "#ifdef .._ARM return false;".
> >>
> > ARM/arm64 does not have a Kconfig symbol like
> > CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
> > there are non-coherent ARM systems that are currently working in the
> > same way as those non-coherent PowerPC systems, we will break them by
> > doing this.
>
> Summing the things I've read so far for ARM up I actually think it
> depends on a runtime configuration and not on compile time one.
>
> So the whole idea of providing the device to the drm_*_can_wc_memory()
> function isn't so far fetched.
>

Thank you.

> But for now I do prefer working and slightly slower system over broken
> one, so I think we should just disable this on ARM for now.
>

Again, this is not about non-cache coherent being slower without the
optimization, it is about non-cache coherent likely not working *at
all* unless the optimization is enabled.

Otherwise, the driver will vmap() DMA pages with cacheable attributes,
while the non-cache coherent device uses uncached attributes, breaking
coherency.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
