Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB182C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C02920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nQBNIS42";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnsN1zu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C02920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z8fG67y/1I6fPOmYRQckpupC+oHxsTuzd5jMnIbmBq0=; b=nQBNIS42kG+U/r
	QpV/JGFhIN8wmCjjRQR/nKZN3umDm3wjgATWdvYEYlr4v7Udg0Kg1OAhEd8rPbCwcz2Ri7VG2N4xH
	Q9HxLOGTtC+XYIXW1b06sKLCTkEtQNb8sExCDYBNuF7y5NOuIOUuink7Fc+SdoeJ2Nfc/SyZFwFZK
	2cPbP+b2poyZ6gYhIG7qtMOBOmI3lRMCm1riOKyoCpiUlKcHfgu4VDP/h4AhSOWOB1fRneDutt9Aq
	dWxdhLdLdHCHgQvRnCVTMdhV2t4ydau1kuQWrWoZsED3Iq1rqc9W2MGPWUxW1QkzUefDX8Zoxkxeh
	1Ir0q759KM3Dg1pQqCNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomMc-0005dV-DV; Wed, 30 Jan 2019 09:40:58 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomMW-0005aK-6P
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:40:56 +0000
Received: by mail-it1-x142.google.com with SMTP id b5so9503359iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jA6sxqmdE5xhLUmdWXW4Y0IJWkPEsnB42d4DPy58FV8=;
 b=MnsN1zu4XTBbRAmbSdSyFZonyCUd1BpWHp/uqPC2GrR6AYh+UQfaaavY+IlG59l+S7
 s8BMb7ReLlnYn4cqBus1Wb7nGBrM2XnTEFFIgDZNWv4MDo1hjCsC9Wf1TAvwCuiS9COh
 fbRWcuCwVqg6DvJriMjpXDt5e3ibl6PRLkZEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jA6sxqmdE5xhLUmdWXW4Y0IJWkPEsnB42d4DPy58FV8=;
 b=NY2ak6IVtWAzC8Hrm/T5IsVKCMPLmOaR2qq8YKgvzaerbiAJFxYGi2Gtz3+3N7jogd
 yymNG6rM3ZIV8hwg3JS4NKgG08nYwdEq1DGAozcTOpukewaMnV45FyjqRWKLb9n4y6rt
 Hdf6oKVKdarM7uOWEjsvRPdxYz6xkkFQN10UKeZlNktlUvvV12FBwDi6apNY21zLsU2f
 hY6QcBCFMrxFXMdAtwHbcA+PA0/UjgFXKllY65Nl8GbtBFtf6dWpQshNxMw/eWaLQ6ru
 uc6zi7c3V97tQgKjUf+KL49PAhwM7S588jpKaHswhtQGqfDf7jLS7Mf0Qby70vEcLnk6
 yICQ==
X-Gm-Message-State: AJcUuked1do9an8JDo7KCRd/sC8UC8S/lBhdwPXXx8iHc5dCCu5KPZCR
 cK5mAHLSK2lKczWk8GfIFOCMK1foSsgJgC63KXmRww==
X-Google-Smtp-Source: ALg8bN59vK4dHgHYP2MyJsf213NV1ZXUGMEIwFjAxEc4Gss28+6jH1aXuKX1Alcm0WvtXAcvx/9jKTAsCRs7yy5sw+c=
X-Received: by 2002:a02:183:: with SMTP id 3mr18713951jak.130.1548841250092;
 Wed, 30 Jan 2019 01:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <20190130000618.GM31596@builder>
In-Reply-To: <20190130000618.GM31596@builder>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Jan 2019 10:40:38 +0100
Message-ID: <CAKv+Gu-xt9762Lh3A3qAW3kRYUW+pvQa6piEFwOOi0vTdmQAGw@mail.gmail.com>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Bjorn Andersson <bjorn.andersson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014052_473431_2608958E 
X-CRM114-Status: GOOD (  22.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-efi <linux-efi@vger.kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Will Deacon <will.deacon@arm.com>,
 Alexander Graf <agraf@suse.de>, Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 01:06, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 26 Jan 02:22 PST 2019, Ard Biesheuvel wrote:
>
> > The UEFI spec revision 2.7 errata A section 8.4 has the following to
> > say about the virtual memory runtime services:
> >
> >   "This section contains function definitions for the virtual memory
> >   support that may be optionally used by an operating system at runtime.
> >   If an operating system chooses to make EFI runtime service calls in a
> >   virtual addressing mode instead of the flat physical mode, then the
> >   operating system must use the services in this section to switch the
> >   EFI runtime services from flat physical addressing to virtual
> >   addressing."
> >
> > So it is pretty clear that calling SetVirtualAddressMap() is entirely
> > optional, and so there is no point in doing so unless it achieves
> > anything useful for us.
> >
> > This is not the case for 64-bit ARM. The native mapping used by the OS
> > is arbitrarily converted into another permutation of userland addresses
> > (i.e., bits [63:48] cleared), and the runtime code could easily deal
> > with the original layout in exactly the same way as it deals with the
> > converted layout. However, due to constraints related to page size
> > differences if the OS is not running with 4k pages, and related to
> > systems that may expose the individual sections of PE/COFF runtime
> > modules as different memory regions, creating the virtual layout is a
> > bit fiddly, and requires us to sort the memory map and reason about
> > adjacent regions with identical memory types etc etc.
> >
> > So the obvious fix is to stop calling SetVirtualAddressMap() altogether
> > on arm64 systems. However, to avoid surprises, which are notoriously
> > hard to diagnose when it comes to OS<->firmware interactions, let's
> > start by making it an opt-out feature, and implement support for the
> > 'efi=novamap' kernel command line parameter on ARM and arm64 systems.
> >
> > (Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
> > used, given that the physical memory map and the kernel virtual address
> > map are not guaranteed to be non-overlapping like on arm64. However,
> > having support for efi=novamap,noruntime on 32-bit ARM, combined with
> > the recently proposed support for earlycon=efi, is likely to be useful
> > to diagnose boot issues on such systems if they have no accessible serial
> > port)
> >
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Leif Lindholm <leif.lindholm@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> This makes the SDM850 bootable, thanks.
>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Thanks Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
