Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5CD20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rqNaNXw2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEUAU3Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5CD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IVuACryrUM76NccYZo0HskFvaf49OZEp3gnYRfVD9jQ=; b=rqNaNXw2BdHyer
	Ok+TOma3hyz6gmVf4pGKEmt+8ds9TFTHFmj8xk9iphehQMF5iBkJ/A+sCW4pcn87k8HmfRYsUE2UU
	m7H9KeOVRzoAqg7J0dCNJjpflXWjOsb7guFHKEEn59cYFlx+18oyodO0zzzcwVmvDTFeFNz5YKe0V
	b1vRC7z46hDwkt8FghDQMcQws8OfVzakYx/duHGZNw0nM1DrQmwMJEhIPqbNJivA5SwiTSoLdT5zL
	j+VtM6W/fUg1gKEX4wIFFlxRCSq6nftC9QbOKVwpu0G30FKqWY0wjnMiEoH6uEx0Vo9b0kjK59S6D
	5ueJbjoXmMSIP/86Z33g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrqf-0005AS-2V; Mon, 03 Dec 2018 17:17:33 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrqa-00055s-Uu
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:17:30 +0000
Received: by mail-wm1-x343.google.com with SMTP id f81so4096930wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z2i3jcJZaXkayVjCzLsZZPQEVb08eUymNI518oWSbDg=;
 b=AEUAU3Zq1L/MMXUID2RJbQSS+pSaRKStetAkQvxKX1s4k8jXv0ohrkFWFmSWFiGnF4
 RzdT3mp3P+DQggZ7kRMkVR1q0JTzuZ9Uy1sOYpQafg14RtpMcr3f/o17bwdTnwnu9Ywg
 qByIAaUNZYCJRIrY5Bm0yx0UAzI/obxjuP4LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z2i3jcJZaXkayVjCzLsZZPQEVb08eUymNI518oWSbDg=;
 b=iqqCKmMnSON9CATtill/k0o59tj5UZnVVMGmN4UMD/ButHoMXsak6mueIZoZdETa8i
 pIgG3t1q6A0DyIX/xi/k0BmTrYb1kkDmj4s3Wnsfq2NH4ppK4324dwk5P2M0MRgwcVAR
 HNrDpBh/yZEBpCBJ2PJ3dlvppSmzZOOyZgedFEOPQ6RijUcsjA9IRx/Y2DIZmNnAIw8/
 WainGzMWGKzV86dlLKnShe5zW/80Kd4zDTzkMGymZfd0qwNYrK8AiGe6f16Ab0EngWDt
 1nLTJtqnjaNu5A9hUdqE0GufvYylBAZCILG84PZAquSObMNqEu1K+8IR6WVvdC6WAaF5
 ZOpg==
X-Gm-Message-State: AA+aEWZ/TEe3EbClew5EwzzYalnRgxo/NfjiizIzyudu5azpBJVyC+bA
 xQUeGrVOabvpvsP9yY1ziSgWr+bA+Cwh++nw5deNEw==
X-Google-Smtp-Source: AFSGD/VCLNDy9UhVALfAs9gzszdWa6HOWZtxr2k7d5omSaAOPpdt+V7gE6HfPW32kp4ZeT9hdc2biYH8376AKZSCGZw=
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr9196952wmf.11.1543857437509; 
 Mon, 03 Dec 2018 09:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
 <20181203170854.GA28218@arm.com>
In-Reply-To: <20181203170854.GA28218@arm.com>
From: Peter Smith <peter.smith@linaro.org>
Date: Mon, 3 Dec 2018 17:17:06 +0000
Message-ID: <CAEt-8LBQ1CfwNAYXcnHVPC+6CLdgL+cnB3z5eR9-98yA8A4aCQ@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
To: will.deacon@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_091728_999769_6644894A 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: catalin.marinas@arm.com, ndesaulniers@google.com,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 17:08, Will Deacon <will.deacon@arm.com> wrote:
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
> Will

Hello Will,

LLD currently doesn't permit the .dynamic, .dynstr and .hash sections
from being removed. At the moment the Linaro kernel CI job doesn't
have a LLD configuration. We are planning to rectify this shortly,
hopefully next week and if not then straight after Christmas.

If you do need support for removal of .dynamic etc. to happen it would
be great if you could comment on the LLD PR
https://bugs.llvm.org/show_bug.cgi?id=39810 . There is some pushback
over whether LLD needs to do this if it has already been worked
around.

Peter

p.s. apologies to the people that got this twice, the message bounced
first time.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
