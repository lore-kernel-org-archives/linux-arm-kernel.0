Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FABC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:29:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948A5218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jrDdonIR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="It92gtXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948A5218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wH7cbka6jC3vwB66Y80HWWguPETUaaIiIicZRFsCCqU=; b=jrDdonIRTmceTa
	cKU1qocoAmq9PbMK8YEVkDkT3Aefhp68kTpF2DvWoUwmByj3tfLOXSNjUKEjYkRw+mZPG35kMToQ3
	re9IdSD06jrp4eb1G3ryYP46hGPVCZaJ9l+KlStQHiR53po9QLBKYem7qBbnNjgHwF/rfJsAZzmQU
	QrZFbF1oNP3lvTFbxvwkrt/vaQZ8pY9OSiGTKezvb/Kl+ZQrEzlA2wXC8jHB+eON9qrS85JjnSmXP
	v6kDTFzMqkzjRtoHAK+dKjKHgRXjbPao+TTYjHTUJeBGHCh0BbJJ1DiYN+QlzZNBGG0pJPo/Uk15v
	6uKDvHivE6MKzrBFFGJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnN57-0005a6-0Y; Sat, 26 Jan 2019 12:29:05 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnN53-0005Za-GX
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 12:29:02 +0000
Received: by mail-io1-xd44.google.com with SMTP id b16so9904507ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O3Ke+EKI/VXgZrYlRhd8vo1ZeoFwmulpgppnTmjwa+0=;
 b=It92gtXZ0Sx+i/+lcICIxcbIIowY5ZTzTV9qYJiSbKWakuYmBtDR/j+5JbLxKWZKQr
 r3usbpVMdIi0/tldD1/wegRY7xaj3Zkm5wzMRd+/Odtk+U7gGL2TQQtZ2DN/RPP6CwuF
 xN6YzzwQJPWpIk4+0AvgeKM1m0cPmOIQDnkFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O3Ke+EKI/VXgZrYlRhd8vo1ZeoFwmulpgppnTmjwa+0=;
 b=n0u0XvMm+1e2E/skVs7YqUP63cSd/VBfBIzxFmwKiaoDdkMFlQWJV1U42QdqHM5Oiz
 /aUsER2TLKwX9jM5V3yM/VBg+zuzqFRvLfqwqRRMERS1CbrYU8mBI4exgLqqVjfck7IB
 aYDfhYhMcWx2xa17Vy9c9nUEru5w4X3XC7sx4UovFJwxQkJIwSf2WiEXVXGqi7WdpkuA
 50HVMT+HtU4uIoyKUPgJqEQSbr30PNDRnmfKp4DuoJmbDtK5G6nnkRDv1bivxkWXFv6X
 kKn0+JCBP2VAjgnxkPeC/uzGbRTIdSZYG4b32qfuUpQGTxDL8WPJ+kCchLO5r+j+Vd5p
 eZhg==
X-Gm-Message-State: AHQUAubWSXrV+9Uk2FvrX8UpD3MwD6xYPWD7GdydJ4fbGenNSrbV2d/n
 l6Gy/0oc68maDL72JqBffxci+MMgsaBZlOgMPHuR6w==
X-Google-Smtp-Source: ALg8bN7COlSqVNOJBjt82Iaf+egsOwSLOduezfIhonjX82d7JoPXnhKdNJRb9S2FAXF1MV4JmOTXC+y1D9KvAhW9pTE=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr8766891ion.173.1548505740438; 
 Sat, 26 Jan 2019 04:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <496259a6-f277-77b3-e5d2-7d45b4f515c7@gmx.de>
In-Reply-To: <496259a6-f277-77b3-e5d2-7d45b4f515c7@gmx.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 26 Jan 2019 13:28:49 +0100
Message-ID: <CAKv+Gu9Cz5AW6o_FWxaGOeWsTN_AveiuNQkMhiDT5U-mZ1r91g@mail.gmail.com>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_042901_568701_180B1E7B 
X-CRM114-Status: GOOD (  21.88  )
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

On Sat, 26 Jan 2019 at 13:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/26/19 11:22 AM, Ard Biesheuvel wrote:
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
>
> NAK
>

Excuse me?

> This patch breaks EFI booting with any known U-Boot release.
>

It does if you pass 'efi=novmap'. Otherwise, it works fine.

> You are a contributor to an alternative open source firmware (EDK2).
> Could you, please, share test results for EDK2.
>

It works fine with EDK2.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
