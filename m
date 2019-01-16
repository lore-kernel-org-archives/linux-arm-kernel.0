Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286E02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hikK1z/0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTUPsbML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286E02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JjJHCzZOt2Sg2my8wQfg84N1jaiJV4ExlLca+DyWSqs=; b=hikK1z/0TEBUEY
	qr50vfAjLmfvdk5l6krvsmDV93xA8azhjj5AijRphsyvzbTNbtKUZEfqlns2o4mM8hdq2u8N3sq1e
	2el70xgECnpvn29rGaHwrZmcqaV6M/AqV61mtORHcwNryGKWmYgjZ4zXLgbtL3o7pO2v/kUsaA50H
	nVVgf25cSVF5C7ynXKgpUL2eKPepzyjOmCdIOGhI1RV9QDS9Ku1n+C83iIiLb46mlVK6E3Bip9EKK
	Gr+rnCPcNbx965xqWu7n/8Y96SE/h17MUZRu4SuJHWCKGuFEwALziG07pfI0V9kZ708EKra8HfPpp
	Rimv9lGosiNcBVJ0M17Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjfva-0002m7-QU; Wed, 16 Jan 2019 07:47:58 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjfvX-0002lL-Fn
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 07:47:57 +0000
Received: by mail-io1-xd43.google.com with SMTP id k2so4181746iog.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7mEUMRRlUi2pZohKna/C1HxAnZ2ybcIeGI4SY2Mk+gA=;
 b=hTUPsbML0ukR5dIPafvw+6K+BfPvAKpEWrvgfRl6Lv870z/Ju5YHi5xcC6mdqXGkqP
 mLMkeGbBxGmdT945de0fjJl+JkigUNS1x5aeMax2W9M3IydKLQNL+gPiyiRTW0NfVFxU
 31ZxDvVHJN9HWl+9iBqxcTAbPrdL2b40qzM74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7mEUMRRlUi2pZohKna/C1HxAnZ2ybcIeGI4SY2Mk+gA=;
 b=Pkqo+FL6lQ3t3up6/TrbCR+thCGmh9JRVqW891YW3jYzK8mOXH16dxQF12OK+D/jM1
 YrrOT7FOhJ42qDJMPRRavGbLyKO9XClBts5A9FukLgP1W40pVTm8WMJTmBOLxNjvvvLw
 zAKf91lcI4moo9j8zxFvHNMsJcHhDuLN+C/AccXkycvbT1MOQlM+VgAeUeQGcyqPlZDY
 MpOA27mzMQq1tYsCqE2i6O/+Lr6XbxzUdulsgdEmhKiS6m7zxHbNwo9aOo2bqsCFjN/P
 crpouVG0SHlAgApGy9y8Hv8C/NHPXvx2tPLVPIZS2NRKDsBZu2XX7kPBbd4vtiS3IYaP
 rGjw==
X-Gm-Message-State: AJcUuke2PdPLpSfjBaB7J0nNENYNfl/XPRZMdNx+Z95aK9NFF+ZP0pB0
 BpMe0+g9817oG4udsf82zSYQC3MtSBCbKFZD1iaODA==
X-Google-Smtp-Source: ALg8bN4LIbm3/m7VL/ZdwolPRIEFlWj8fWTKy1FlTUUjIbFOzDbYjm2Pl4gUs8LVt9PKPzqz4Ra3FcA7u16SZXw7mwA=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr4432621iop.60.1547624872328;
 Tue, 15 Jan 2019 23:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
 <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au>
 <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
 <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
In-Reply-To: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 16 Jan 2019 08:47:41 +0100
Message-ID: <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_234755_530007_8373A1B6 
X-CRM114-Status: GOOD (  24.04  )
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
Cc: Carsten Haitzler <Carsten.Haitzler@arm.com>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 08:36, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 16.01.19 um 01:33 schrieb Benjamin Herrenschmidt:
> > On Tue, 2019-01-15 at 22:31 +1100, Michael Ellerman wrote:
> >>>> As far as I know Power doesn't really supports un-cached memory at all,
> >>>> except for a very very old and odd configuration with AGP.
> >>> Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> >>> mistaken) impression that mismatched attributes could cause a machine-check
> >>> on Power.
> >> That's what I've always been told, but I can't actually find where it's
> >> documented, I'll keep searching.
> >>
> >> But you're right that mixing cached / uncached is not really supported,
> >> and probably results in a machine check or worse.
> >   .. or worse :) It could checkstop.
>
> Not sure if that would be so bad, it would at least give us a clear
> indicator that something is wrong instead of silently corrupting data.
>
> > It's also my understanding that on ARM v7 and above, it's technically
> > forbidden to map the same physical page with both cached and non-cached
> > mappings, since the cached one could prefetch (or speculatively load),
> > thus creating collisions and inconsistencies. Am I wrong here ?
>
> No, but you answer the wrong question.
>
> See we don't want to have different mappings of cached and non-cached on
> the CPU, but rather want to know if a snooped DMA from the PCIe counts
> as cached access as well.
>
> As far as I know on x86 it doesn't, so when you have an un-cached page
> you can still access it with a snooping DMA read/write operation and
> don't cause trouble.
>

I think it is the other way around. The question is, on an otherwise
cache coherent device, whether the NoSnoop attribute set by the GPU
propagates all the way to the bus so that it bypasses the caches.

On x86, we can tolerate if this is not the case, since uncached memory
accesses by the CPU snoop the caches as well.

On other architectures, uncached accesses go straight to main memory,
so if the device wrote anything to the caches we won't see it.

So to use this optimization, you have to either be 100% sure that
NoSnoop is implemented correctly, or have a x86 CPU.

> > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > others is just that ... an ugly and horrible hacks that should have
> > never eventuated, when the search for performance pushes HW people into
> > utter insanity :)
>
> Well I agree that un-cached system memory makes things much more
> complicated for a questionable gain.
>
> But fact is we now have to deal with the mess, so no point in
> complaining about it to much :)
>

Indeed. I wonder if we should just disable it altogether unless CONFIG_X86=y

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
