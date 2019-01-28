Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA44C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3392147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OznGgeDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEV79igJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3392147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aXgZv+4cAlWV2siCIB2Cv5i86I3OOt961VVHb0zOWTc=; b=OznGgeDcJOBbVt
	YalwT5mhJ/XjyhmJS4Qn7QFrekJ/AxPm00lJOgIk/CCTWE6k2xIvJCcig1RGYGI3EB7WRxAKuoXzZ
	ZzLhIv3QLbTuI5mO75u/1SzOcS+hiwZXUO0Urr/f9QqZEyqYXYNXWAws6U7QNP/yFmAAfkV1ic9Ia
	EX4vr3X6fq/nRm4cHjk58QVxPUI96G5TFQJTl5JTUycL7xVU0oizgfDdzUMbPswx1PI6FOPFiCpw/
	rn6tEV9DjjJDyDZiP1VRJMDkORBEvj1g8Syo+a6uc2Vg/bVNZJD4phD+IaBdWPUBKtM88WNX8WWif
	g7+1wAOnxgdjCbvaHjFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBbf-0003F0-RF; Mon, 28 Jan 2019 18:26:03 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBao-0001dw-GN
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:25:41 +0000
Received: by mail-io1-xd42.google.com with SMTP id g8so14330951iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cDXtTN7co9CVtOC4cJfSnE27asvgyKK/qJgeyPXeZAs=;
 b=cEV79igJIJ/AgX0bSi5cvEuMpPoAyzNAUBd8KrCy3kjv7j96iUj4DQ+F+4A5I9GX6S
 xoOR8ajugZ736ypsGyiTLWh5Qj6xS/HkrLpkYOqHNyLqd1TS58ASZyoUiygSWCVUgX5y
 UQenzBRf8RBmPjgIBuHAfDzAypZAwocieyl6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDXtTN7co9CVtOC4cJfSnE27asvgyKK/qJgeyPXeZAs=;
 b=Y9mG3xuWRHFyPBaoqXwc4jw3K0N/eGuybay8MJux0X6QmQMLYd7Tn34xD9QkBmLR8e
 kNY5aHDmLnpKb7Rl7DDq3D1IQC8Fk/aGyp/IwNjQmlKm5T91OXm24UeEbxH82t8RFdms
 6o11q1VHa6ty49VqWHpfXMK+QDao3YRD8aQjhh+do2oLakVlDyiqju05eDhHNfck7B/J
 FgcV4c1fODyWARlRoV17m+sqhOjYskEZmll3GUB0rlBE2e2baZWw5T/289Bodbe3B3AW
 +JXowI05SIAU66aAgaNnnMYqCMQn3Qh/nv9FlE1IrrAN9NEF7SE3C9dmhnkvgriaviKL
 KO9Q==
X-Gm-Message-State: AHQUAua874ky2m/ywJgiwB8vloht1j5/hIu6Sy+Vx8xvm4Of2s48M3uP
 B9s5h4jeIBuyBaXbbDUuKGhra8AvSffzleB+hCOg4A==
X-Google-Smtp-Source: AHgI3IYNAN8znIkU5pTPx3TMjg5EEFC9sWWQuHu3CQ7X2FVa9k4OJNdtN5k6rbcJ5+uwOzaIdZB0fid4TeMMaES6AR4=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr12824727iob.170.1548699908936; 
 Mon, 28 Jan 2019 10:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <abc36cf9-4fa1-da12-bb94-34d850ae34ec@codeaurora.org>
In-Reply-To: <abc36cf9-4fa1-da12-bb94-34d850ae34ec@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 28 Jan 2019 19:24:56 +0100
Message-ID: <CAKv+Gu-2SwfeZ26zGK_z+VUpAKgtusHn9oKKz396n8M2NDZ04A@mail.gmail.com>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Jeffrey Hugo <jhugo@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_102510_697644_351842E6 
X-CRM114-Status: GOOD (  23.96  )
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

On Mon, 28 Jan 2019 at 19:04, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 1/26/2019 3:22 AM, Ard Biesheuvel wrote:
> > The UEFI spec revision 2.7 errata A section 8.4 has the following to
> > say about the virtual memory runtime services:
> >
> >    "This section contains function definitions for the virtual memory
> >    support that may be optionally used by an operating system at runtime.
> >    If an operating system chooses to make EFI runtime service calls in a
> >    virtual addressing mode instead of the flat physical mode, then the
> >    operating system must use the services in this section to switch the
> >    EFI runtime services from flat physical addressing to virtual
> >    addressing."
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
> > ---
>
> I threw this at msm8998 (arm64), and it seem to work fine as far as I
> can tell.
>
> For what it's worth:
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
>

Thanks a lot.

Unless anyone has any objections, I'll get this queued up for v5.1 by
the end of the week.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
