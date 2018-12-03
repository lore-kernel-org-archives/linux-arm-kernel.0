Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C5EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97ABB20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R1IzShn4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeDg1p0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ABB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C2k8O/0RBQp3ARBylF2Iz//Hsmeex66+XKSVg8NFZd0=; b=R1IzShn4GggQS7
	J1n+2jW+KlwkAWzOGpM9OtTzRbK/Q70lzh7Lfl4O3zZx+eTxSOnukCqoc8v9Yj2zDlQS91i73ma3l
	Z4dIn4Azw8MgBJvvuAqIYJxNtU45E4hmZvGSGOEm6I4ulCwl7rZl+f7QmAR73uF/yo4f8/78VHbGb
	/s2RL9cZ1FxriGEizerY1cQTqLnEHZB7w+Um7T0TizwGBX8nueIBfUbFkdhgvABoiDbPNnaHzVNsB
	injGefVT3v/ocbw32raPLy8JLaIGrZ6aql8+TrB6SRIGEH2DwykkW505yy7HuC0N23aTlEDfZjK9M
	3v6cLDZkywoJkX8YoTSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrlW-0001CS-Nz; Mon, 03 Dec 2018 17:12:14 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrlS-0001AC-Or
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:12:12 +0000
Received: by mail-it1-x143.google.com with SMTP id c9so9713614itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=voeVp++k+RNNuJVWUIxkeXsJITupaKcRuJS4fWM/AjA=;
 b=IeDg1p0R0JlanVgx58LyObRBzRDiVbmDmMROXdGXddyUy0UC5AX6adKXmAIIJYkfcW
 XiAVHIc9jdizWajl/NJYhMEQV2CvuLJNMfxQHeIpDMETa1wFkdVerdO1C6LvDtR1reCZ
 XlWdSsTevNM8C0GXeBiZWh+rskOFuHPn532/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=voeVp++k+RNNuJVWUIxkeXsJITupaKcRuJS4fWM/AjA=;
 b=ftbivg4VD0f+3+RAGAPyNOTD2WM43V0k5xiaPWVSw58mm6mW+zHtzOGS2npXtrnjdC
 S1vdeJAdm5+RSNhiTQMbRRl697Vvk90Xi1KvOc/7kdyqFhYSMrOJDDsv2vsZC8qV8IYz
 a7haxqb3ZV5vqr+ey9tmVmOVrT5++cUFYEqUEEQzqbrGhWLYPAxTeyGoh9mmCBC673VQ
 PWuX57mBaeVaEJuWBp2B2/y3SnWvAJinj0e24w0Vz19kixc+h/Zs3MM0P6Qte2iIq7dL
 fLiJNLlLMZQmIkHWP9vkc0Uuie+LVOKTDWyGLSx+NJWjWB0HM2Uqsnig9KFzBm53u/Os
 eV2g==
X-Gm-Message-State: AA+aEWbZJwOSYfduaogWn02jtHskPF/afptpw2Y8oLEfUj0+NdOpboir
 Gu8WL+MmHoaw68Jz7ubYkaua6EeRZO9GU1iVl1H70A==
X-Google-Smtp-Source: AFSGD/U1nmpRHVLX6LDrCtbDf+cvjo9sOb5gfVUWvrX0GCAUeW2FexY7VfeqbGWkXVH5IWzsqlb91+s5t8klfKDySV8=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr9414515ith.158.1543857119974; 
 Mon, 03 Dec 2018 09:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
 <20181203170854.GA28218@arm.com>
In-Reply-To: <20181203170854.GA28218@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 18:11:47 +0100
Message-ID: <CAKv+Gu9cZ6jMsoMG499g0416J6GW8KxJBmit9=F9ka4AqpZFZg@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_091210_805262_4369C1CC 
X-CRM114-Status: GOOD (  16.39  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Peter Smith <peter.smith@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 18:08, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> On Sat, Dec 01, 2018 at 12:53:24PM +0100, Ard Biesheuvel wrote:
> > readelf complains about the section layout of vmlinux when building
> > with CONFIG_RELOCATABLE=y (for KASLR):
> >
> >   readelf: Warning: [21]: Link field (0) should index a symtab section.
> >   readelf: Warning: [21]: Info field (0) should index a relocatable section.
> >
> > Also, it seems that our use of '-pie -shared' is contradictory, and
> > thus ambiguous. In general, the way KASLR is wired up at the moment
> > is highly tailored to how ld.bfd happens to implement (and conflate)
> > PIE executables and shared libraries, so given the current effort to
> > support other toolchains, let's fix some of these issues as well.
> >
> > - Drop the -pie linker argument and just leave -shared. In ld.bfd,
> >   the differences between them are unclear (except for the ELF type
> >   of the produced image [0]) but lld chokes on seeing both at the
> >   same time.
> >
> > - Rename the .rela output section to .rela.dyn, as is customary for
> >   shared libraries and PIE executables.
> >
> > - Don't discard the .dynamic, .dynsym, .dynstr and .hash sections.
> >   Instead, make sure that they are [mostly] empty by marking all
> >   symbols as local, and emit them into the .init segment.
>
> These second two changes seem fairly arbitrary to me: is lld unhappy without
> them? My concern is that we'll make some other change in the future and run
> into more arbitrary breakage. Is there any build bots hooked up with lld so
> help us catch regressions quickly? (i.e nightly builds of mainline and next)
>

The .rela.dyn change is for readelf actually, not for lld. Discarding
the .dyn* sections is indeed something lld chokes on.

It seems reasonable to make the vmlinux ELF image look as much as an
ordinary shared library as we can, to avoid issues with tooling in
general, not just lld. This is why I separated this patch from the one
that caters for lld in particular.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
