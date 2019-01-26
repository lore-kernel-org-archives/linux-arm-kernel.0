Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77055C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C28218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBmdAcEh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIUPB6JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C28218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rQwSewm5xp6B7H3h25lfYHwWgb5VJRj9xek7V27AND8=; b=TBmdAcEh/hxxLk
	13R/PDM8GtYiyUCA8cIkeLnyklrKbyJ6TvAuaEvOMir8ccg5gFrxlPbkqVv8WFekivzdUumg1hC00
	iGkyaH1IpjZnActEd8u1LYob1GQSDKzplDLNkbzh4Vi2pdkx2CWhkueX/mQ4ALJfkBFjWDLvcgmgB
	w0A5LvS0xJdMYl43i4DH8UTU2Cu9DWwC8T3obgmbw/iGHENYlMKU/vcLGvZdz0P/UEbjF/scFXLxA
	JFwG9VQqhxoiUuiXzCNSMJPDoDmD6tq7OkMXDPKqtqThXhYkZmSryxhhxIlkvyXQbKNt4DaykVaiJ
	ReEwhbADLh4fPz0I3T/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnR9a-0005jP-T3; Sat, 26 Jan 2019 16:49:58 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnR9X-0005j4-4n
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 16:49:56 +0000
Received: by mail-io1-xd44.google.com with SMTP id m19so10187235ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8LT0f8WyOGXh8kglWV2U+nQROiqObE8VsJv8feION5o=;
 b=fIUPB6JFH7bvSi1b5iErS833UUXUoUZpVT3v0tOx4Tx9F4fiCQaNmmumctOE05WPqz
 AtAYPBO9Lpo6O9ACr+iGyWqG0C2OLJSIo6yZCJGsmzszM/evejn/F3u1Xhekpqn6aFxC
 EyNfsAVEl9lXNDY+xdR44B+6aJn+Osg6sAJeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8LT0f8WyOGXh8kglWV2U+nQROiqObE8VsJv8feION5o=;
 b=P/lmAZ8za1mnxo2EJZjRJvcengeNTpJBuR5A5x8bCtAQLsUodbemPYNyXiihmsg8Ga
 lQlWaM4m45TTDNUxxseRK2Xze9BUU/hkiQf3n9yHkoVbDanfmAyqLR88Tl6LRmQRTHuJ
 6uHtgbcb1cTPFiWrdc6QRGwCjcS3HW31zislOBFyoa7rOCqNEh1pPFam9fX9Kd65eMkS
 RiN4AnV5s+9uflugVdiWGrhpeSYWCD1S+/H+ZLVXPygtORXHli0/lrJlIIvXXbyTdoSx
 lSCLxV/BuD004TCKCVMAtCI2h+stOql8YPLg4bDAuay04Vpb4kqvSJQliGALreA4A2zz
 De8A==
X-Gm-Message-State: AHQUAubcrlLnMjeYK8y4w0L4Zm0FsX9nErNyPa1aLmgGjo9nNplz9iqc
 +MUPytkCdHPUk2EEl5/4Mlu7FuTaJHfBd7WdBKX+XQ==
X-Google-Smtp-Source: AHgI3IYCelimT7B/5ZAUUzelo17/9p0K535rk8Xkx7XLeh0W3bG4ttDSk9uBEikPaxmY7mlsVN1MJzhlyk4N+h3mvOE=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr4832541iop.60.1548521394030;
 Sat, 26 Jan 2019 08:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <496259a6-f277-77b3-e5d2-7d45b4f515c7@gmx.de>
 <CAKv+Gu9Cz5AW6o_FWxaGOeWsTN_AveiuNQkMhiDT5U-mZ1r91g@mail.gmail.com>
 <47E85138-58E2-434B-8D78-525DF5A2E7E0@suse.de>
 <9f44bf5c-49ce-48ef-7857-74ce9fd87f17@gmx.de>
 <CAKv+Gu-0r=8uxtKM4WzumVYnNQj6AbUhrx_ct_MOqnymgeRwAg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-0r=8uxtKM4WzumVYnNQj6AbUhrx_ct_MOqnymgeRwAg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 26 Jan 2019 17:49:42 +0100
Message-ID: <CAKv+Gu-vmXiz4NF8ecNR_nb2r6_pikaspBjMuDesxaSNvofQ-w@mail.gmail.com>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_084955_185586_3C025FCC 
X-CRM114-Status: GOOD (  25.42  )
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
 Will Deacon <will.deacon@arm.com>, Alexander Graf <agraf@suse.de>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 26 Jan 2019 at 16:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 26 Jan 2019 at 15:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 1/26/19 1:34 PM, Alexander Graf wrote:
> > >
> > >
> > >> Am 26.01.2019 um 13:28 schrieb Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> > >>
> > >>> On Sat, 26 Jan 2019 at 13:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>>
> > >>>> On 1/26/19 11:22 AM, Ard Biesheuvel wrote:
> > >>>> The UEFI spec revision 2.7 errata A section 8.4 has the following to
> > >>>> say about the virtual memory runtime services:
> > >>>>
> > >>>>  "This section contains function definitions for the virtual memory
> > >>>>  support that may be optionally used by an operating system at runtime.
> > >>>>  If an operating system chooses to make EFI runtime service calls in a
> > >>>>  virtual addressing mode instead of the flat physical mode, then the
> > >>>>  operating system must use the services in this section to switch the
> > >>>>  EFI runtime services from flat physical addressing to virtual
> > >>>>  addressing."
> > >>>>
> > >>>> So it is pretty clear that calling SetVirtualAddressMap() is entirely
> > >>>> optional, and so there is no point in doing so unless it achieves
> > >>>> anything useful for us.
> > >>>>
> > >>>> This is not the case for 64-bit ARM. The native mapping used by the OS
> > >>>> is arbitrarily converted into another permutation of userland addresses
> > >>>> (i.e., bits [63:48] cleared), and the runtime code could easily deal
> > >>>> with the original layout in exactly the same way as it deals with the
> > >>>> converted layout. However, due to constraints related to page size
> > >>>> differences if the OS is not running with 4k pages, and related to
> > >>>> systems that may expose the individual sections of PE/COFF runtime
> > >>>> modules as different memory regions, creating the virtual layout is a
> > >>>> bit fiddly, and requires us to sort the memory map and reason about
> > >>>> adjacent regions with identical memory types etc etc.
> > >>>>
> > >>>> So the obvious fix is to stop calling SetVirtualAddressMap() altogether
> > >>>> on arm64 systems. However, to avoid surprises, which are notoriously
> > >>>> hard to diagnose when it comes to OS<->firmware interactions, let's
> > >>>> start by making it an opt-out feature, and implement support for the
> > >>>> 'efi=novamap' kernel command line parameter on ARM and arm64 systems.
> > >>>>
> > >>>> (Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
> > >>>> used, given that the physical memory map and the kernel virtual address
> > >>>> map are not guaranteed to be non-overlapping like on arm64. However,
> > >>>> having support for efi=novamap,noruntime on 32-bit ARM, combined with
> > >>>> the recently proposed support for earlycon=efi, is likely to be useful
> > >>>> to diagnose boot issues on such systems if they have no accessible serial
> > >>>> port)
> > >>>>
> > >>>
> > >>> NAK
> > >>>
> > >>
> > >> Excuse me?
> > >>
> > >>> This patch breaks EFI booting with any known U-Boot release.
> > >>>
> > >>
> > >> It does if you pass 'efi=novmap'. Otherwise, it works fine.
> >
> > It think it would be helpful to add this information to the commit message.
> >
>
> Did you read the commit message?
>
> > If it is strictly opt-in, I have no concern.
> >
>
> Thanks.

Below is the boot log of a EDK2 based SynQuacer UEFI/ACPI machine
running with this change enabled. The dump of the memory map has been
modified to show the virtual address between ()

https://storage.kernelci.org/ardb/for-kernelci/v5.0-rc2-3-g4f78f37fc6eb/arm64/defconfig/lab-mhart/boot-synquacer-acpi.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
