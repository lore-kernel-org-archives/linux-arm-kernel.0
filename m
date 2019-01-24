Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B1C2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvBPTdaU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYsnhKKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B1C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ow+vSqvJ4uSX2IwLTouvpY0z3hkM2ZC/C6SuEmt07n0=; b=gvBPTdaUcBTStJ
	VtoWavoo6AZNlrwRMb3UXKk4wkuUeAOmmVbvT+4nrLfn1lh7N0cFnLPKGzs89yLYYKjSxXwes3BTE
	6aQL9l/CMbkYXmPWpqoff87mdKO9esdep5CFMAbeZtEgsdNQid/tj970PsJkVTysawF9OBgKwkWI3
	A616d5lJjYHB+GNabMp1u5X06klI7nBb0i8sf4bWHeK1JDoDU+riZfU5Z1BGXmlxtaFkQvYOEUtGE
	aSqSui0RWAaW6MmtcqWgJXh04IwLgm0U50pktkt9M26G5LqOpqR+Ycan+J1qouGTP7a21Q0tfc+rK
	v5c5LM0O4Xsg455+ng9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfSo-0007b6-9a; Thu, 24 Jan 2019 13:54:38 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfSl-0007ag-2z
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:54:36 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so3127629wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bu40OftT3CTGlDjiRtL5/LOPt/y8b4/09G80Rl1uSkY=;
 b=rYsnhKKUA1nvgUDWN0tG2WFWVOXTk9x9hKae9SP2Nq/XNd4Lgv5OAuGsDJMOQRpvB3
 dP9QGoZve8fzzW6kNoNvQtPcig1Cvkq0vzIgyf6u7l40WhozJCd4apAGBwUHBaS6tp7c
 K+bOhb+lTANuhOkWJ4y+zvFAi43gyl+kavWvKcyvAiSZ2Vxf6Bs0PkaLSJ+V+gLkZjm9
 YFDwkz0CsrLEdFolOTSRbKpHPTD/0aqSFAsRQYH2qEfX/Z48tPKHJET3E9IfH2jhYWzx
 /8M8+t5Xu+aWgxzHWoumWPgiWA+Rh8AH/Jidghxlq2v6TaQja0G6Ox7xN2J4Sxla/Ju5
 380g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bu40OftT3CTGlDjiRtL5/LOPt/y8b4/09G80Rl1uSkY=;
 b=R3KhWzrxOpnS45+LaXHgwaXBx4ppGahENWKA5kBcLTW2meZjlpKSpm2wu0uVMs02XX
 /U1rE3PRWyhPJRRqOf+4uc+dRxykOMrqIX55jBgP4PxE62/5JqBAaWP8SkSuA7WvWzgp
 1YBSuvbIvkhvTYaEvQy/38uxc+gkDZVWrRBQPypyqMKfwsyQMSx0a/uCZzRSyBAtR+Vx
 s2Ww9XXKbkHSaYTM05iFJ7icHzNpDr3+jBdTfTtQM3xY/qvES9Us3qw7r+YFGz+3zpOd
 uxnQbAA6UiQ4Pjp43ZEGmNGUoQSz7jHqd1RdC8Pf7DQM3lQdeERqtEne89zKyF0DWdAi
 f5lw==
X-Gm-Message-State: AJcUukekX2jvQLEjs2T1kaB7KI4kGgg4SZk7yEL22wDblbb0OAmawsJV
 RO3m53VxhhEHWd7aksI2gf2aLxBpcOLtPIurk6w=
X-Google-Smtp-Source: ALg8bN6V6Y0+Ep9NDCQ3m0Am4Ljzbka0ufu/lhBNt1PfMqtAxLvOYKh+nMDBOH/H205x9extCL8cmYXf5ugghpuYQM8=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr2630510wmm.116.1548338072366; 
 Thu, 24 Jan 2019 05:54:32 -0800 (PST)
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
 <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
 <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
 <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Jan 2019 08:54:19 -0500
Message-ID: <CADnq5_PCCj1dgYTnJoWdFp45X8GMwdT34sMtWH7p6Ms1_SncOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_055435_156557_F682A707 
X-CRM114-Status: GOOD (  26.33  )
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sean Paul <sean@poorly.run>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 6:45 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 12:37, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 24.01.19 um 12:26 schrieb Ard Biesheuvel:
> > > On Thu, 24 Jan 2019 at 12:23, Koenig, Christian
> > > <Christian.Koenig@amd.com> wrote:
> > >> Am 24.01.19 um 10:59 schrieb Ard Biesheuvel:
> > >>> [SNIP]
> > >>> This is *exactly* my point the whole time.
> > >>>
> > >>> The current code has
> > >>>
> > >>> static inline bool drm_arch_can_wc_memory(void)
> > >>> {
> > >>> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
> > >>>      return false;
> > >>>
> > >>> which means the optimization is disabled *unless the system is
> > >>> non-cache coherent*
> > >>>
> > >>> So if you have reports that the optimization works on some PowerPC, it
> > >>> must be non-cache coherent PowerPC, because that is the only place
> > >>> where it is enabled in the first place.
> > >>>
> > >>>> The only problematic here actually seems to be ARM, so you should
> > >>>> probably just add an "#ifdef .._ARM return false;".
> > >>>>
> > >>> ARM/arm64 does not have a Kconfig symbol like
> > >>> CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
> > >>> there are non-coherent ARM systems that are currently working in the
> > >>> same way as those non-coherent PowerPC systems, we will break them by
> > >>> doing this.
> > >> Summing the things I've read so far for ARM up I actually think it
> > >> depends on a runtime configuration and not on compile time one.
> > >>
> > >> So the whole idea of providing the device to the drm_*_can_wc_memory()
> > >> function isn't so far fetched.
> > >>
> > > Thank you.
> > >
> > >> But for now I do prefer working and slightly slower system over broken
> > >> one, so I think we should just disable this on ARM for now.
> > >>
> > > Again, this is not about non-cache coherent being slower without the
> > > optimization, it is about non-cache coherent likely not working *at
> > > all* unless the optimization is enabled.
> >
> > As Michel tried to explain this CAN'T happen. The optimization is a
> > purely optional request from userspace.
> >
>
> Right.
>
> So in that case, we can assume that the following test
>
> static inline bool drm_arch_can_wc_memory(void)
> {
> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>     return false;
>
> is bogus, and it was just unnecessary caution on the part of the
> author to disregard non-cache coherent devices.
> Unfortunately, those commits have no log messages whatsoever, so it is
> difficult to infer the intent retroactively.
>
> > > Otherwise, the driver will vmap() DMA pages with cacheable attributes,
> > > while the non-cache coherent device uses uncached attributes, breaking
> > > coherency.
> >
> > Again this is mandated by the userspace APIs anyway. E.g. we can't
> > vmap() pages in any other way or our userspace APIs would break.
> >
>
> OK,
>
> So let's just disable this for all ARM and arm64 then, given that
> non-cache coherent is not supported in any case

So I think we are back to this patch:
https://patchwork.kernel.org/patch/10739023/

Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
