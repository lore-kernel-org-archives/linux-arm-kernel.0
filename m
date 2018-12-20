Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:54:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED63F218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVWlaszc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnbPkDPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED63F218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kqLD529OfdE/mlVapj1C75WNS96hc1xeCSvU3dwL78E=; b=tVWlaszcpSp2Jd
	baOlkX4tMmxVdQVVZP9GJBqg+ydPsL3Yyxg6ZFFDDx4g1ZDYP+/iEETYADw9Le2aex1CvQPyIM+xw
	DCbpMzNPetPfj9OUHzhGfJAW+oODyxEgz5barKbiHTYg5AfhwhK/dKsbC6KYpisiF38uv8w5zfkDU
	JE57da6Qh+lMBOmGWtvDFRasL4AWzbdGki9XLRQj01pOUeSD1XaVY+A+7JkDWYt9yaledXsHqVh3l
	Y3YorYKBa+eJTJ1VQCZmueetUKdVH/nwbt8k+5B8nt2KGSTsuuM3W4C/dkIC1I5EklrKesaOPeRou
	A4jpAe28OxQI4LUhtYVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga2WY-00046K-4H; Thu, 20 Dec 2018 17:54:18 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga2WV-00044Y-Aj
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 17:54:16 +0000
Received: by mail-io1-xd42.google.com with SMTP id t24so1530684ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+w81jMbb1o2ygo2dFZKor/RnHjUNYim0qXEYOaVTDLc=;
 b=FnbPkDPLEuqKdeWe1yEFJJZBekH1QO+pKfgDgKGFEwq8gAd4uvTADH9/BuvWR9V1f+
 6kAR2citfpmJctvSKlLZwenOiV9M9Oc7tg7QvUtAWiN48ciAl0JQfXwb/vp/zU+C7IMf
 x4IV6Ym0i0JaTtiu8z4PulYcpLT/n0qulLFLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+w81jMbb1o2ygo2dFZKor/RnHjUNYim0qXEYOaVTDLc=;
 b=oxLaw5sRnZbAKQwNTw9FksOl4wcweBRIQ4tbaEZntNoIizRKVaBvdSpZIecaNGOIsL
 iSzycEoPNl7bcv90wnNvcGEJHKXIGJR6rHvQI9BumenuOnZLnNyL9hae18la9IrDAU5l
 8fKUb1l+3AKIkzULqi7XBsAmOkmBw1UdorXdNB441lELVPPsa5jV1smz7n+iC6uV3WRb
 DKYzkjZPTCPOKIoyBRg8DsOXDhl4Qq0mHoj1dIBiKHV0RpV/QXjoBZ6cnKHZqe6QV6Yg
 NhDSi6G0s+2L29W9an6Eco+nW+AbaisCKPtacWkkmqbRxP/IwwSA1pnF+qcLdjJpW+Pu
 7CeA==
X-Gm-Message-State: AA+aEWbypawqbPZM/+fYfw60ri1lm9SaV31RifUPtpVWSPe0oatmju12
 cFt34dMGIa6//OMujYw6+FuNlDCYIETiaxUb3cOD5g==
X-Google-Smtp-Source: AFSGD/Vp+zhHyHp1nKMdtFw4tma8WbKDd6zssG67ODBx/MRA4s6TcuYWmfeK3vKs6cMQBA1XTO1HTT1ZnDOBJTq64So=
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr22959730iom.60.1545328444007; 
 Thu, 20 Dec 2018 09:54:04 -0800 (PST)
MIME-Version: 1.0
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
 <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
 <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
 <bc27fb6d-1adf-d7e9-ded2-2cbed81b6e03@arm.com>
 <e0ecdb24-ef52-2c31-565d-66f7a2770f4a@arm.com>
 <7d42f570-541a-59a3-79fc-f00dc0b51689@arm.com>
 <CAKv+Gu8CNmL8v=ePXSvQ0vEAzD2O2YAKutQW-b+E6JmyYBPTnA@mail.gmail.com>
 <9c64a977-fdee-b2b2-d726-1e9744d229a7@arm.com>
 <0e6edb8d-dd41-fd3d-0598-7f02ce4ee9ef@arm.com>
In-Reply-To: <0e6edb8d-dd41-fd3d-0598-7f02ce4ee9ef@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 20 Dec 2018 18:53:51 +0100
Message-ID: <CAKv+Gu-joM6GivoTqF1t8UKUwtfXkVZ5gTKL6JzMh3uCUJeWog@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_095415_366267_4F532AB2 
X-CRM114-Status: GOOD (  20.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 oleg@redhat.com, joel@joelfernandes.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 19 Dec 2018 at 18:01, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Hi Ard,
>
> On 14/12/2018 16:40, Julien Thierry wrote:
> >
> >
> > On 14/12/2018 15:49, Ard Biesheuvel wrote:
> >> On Fri, 14 Dec 2018 at 16:23, Julien Thierry <julien.thierry@arm.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 13/12/2018 15:03, Julien Thierry wrote:
> >>>>
> >>>> Argh, not as simple as I had expected.
> >>>>
> >>>> Turns out include/linux/efi.h does not include asm/efi.h (including it
> >>>> at the beginning of the file breaks the build because asm/efi.h misses
> >>>> the efi type definitions.
> >>>>
> >>>> So a thing like:
> >>>>
> >>>> #ifndef efi_get_irqflags
> >>>> #define efi_get_irqflags(flags) local_save_flags(flags)
> >>>> #endif
> >>>>
> >>>> in include/linux/efi.h cannot be overridden.
> >>>>
> >>>> Either I would need to introduce the definitions arm, arm64 and x86 (I
> >>>> don't think there are other arch supporting EFI right now) or I'll need
> >>>> to come up with another solution.
> >>>>
> >>>
> >>
> >> It might be a bit nasty, but can we put the #ifndef above in
> >> runtime-wrappers.c directly? The only reference in linux/efi.h is a
> >> macro, so that shouldn't matter afaict.
> >>
> >
> > Sadly, in arch/x86/platform/uv/bios_uv.c, uv_bios_call() has a reference
> > to the macro efi_call_virt_pointer() which wouldn't be able to see the
> > definition in runtime-wrappers.c
> >
> > Otherwise, we could've moved efi_call_virt_pointer() and
> > __efi_call_virt_pointer in runtime-wrappers.c and things would not have
> > been as nasty.
> >
> > But no, I don't think we can do that without breaking some x86 build :( .
> >
>
> Since the above does not work, would the solution with the
> HAVE_GENERIC_EFI_FLAGS below be acceptable to you? Or would you rather I
> defined helpers in <asm/efi.h> for all arm/arm64/x86?
>
> Or neither and I shall find another way?
>

Would it be possible to introduce a function

efi_call_virt_save_flags()

[as a counterpart to efi_call_virt_check_flags()], and put the
implementation in runtime-wrappers.c (which already includes
asm/efi.h)?

That should allow you to put arch-specific hooks in asm/efi.h, and use
them in the implementation of efi_call_virt_save_flags(). AFAICT, that
removes the need for Kconfig glue.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
