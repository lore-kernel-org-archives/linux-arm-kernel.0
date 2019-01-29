Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA70C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA96820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W1mTfaXc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPb/iugS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA96820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h49XwVHXECEZaENeraIhHR5gYiAdYYWmyb5sMXLR8cE=; b=W1mTfaXc0W1S9Y
	hHc32KqlwPf4b8hg5pc1VsYzfjyr8JGIRCVX7FeJNaU4fe3xi7PKbLbaOCNVO2I8+23bvKaDUobWZ
	rfFUBQS6+IbPY3QK1BlnWBga0HxQqJf1IGF3yEFG2ZwzBxJ8OGtzT41rFzTZsRa9qN3DxCHYkChsG
	tY2xit3pAy/6n1hAZZQo0JQzFAwmKDJ7BvYaGvAavTfP7MQBGjUhBMurw7DUl+/wWIOtbcauKhceM
	40C2iY609ziFMy61f6Ln5Q66BvY1RGHpK1lZkrM+UDQ66orV9DwqjeFcvtcw64p4A6RWeiWwsPGhq
	Z/ylN9g7VAH/5JMyujsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUT2-0006FC-69; Tue, 29 Jan 2019 14:34:24 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUSy-0006Em-Fd
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:34:22 +0000
Received: by mail-io1-xd41.google.com with SMTP id k2so16441320iog.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mmotDk+tv7WqQKlIqsD4nkJEwWqiebe3Ae3Mjvh36Vs=;
 b=IPb/iugS2OSQHbTEVpBLTwBipfP5TavWvlo72N10xLbwKpolCjeLEAgPqLMwBeMF4A
 yx+grP4mN/naq3Y08C8Ij2RstG/AuBKPZnFfXRhfZfTx/QYl8HeNWwg2bLCg/+q9dAsL
 y27G79iVKHmdlelat5SwAj1XqK5s0pniFjojQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mmotDk+tv7WqQKlIqsD4nkJEwWqiebe3Ae3Mjvh36Vs=;
 b=jUZReUcoM/WcrN8XCiaFsTG2RuYantlrW+1VVy7uNzcBTCiOLvTs6oEfKhqzWZqOdn
 IrRyoL1uB6akJoRf2BFmK6aWXbYi41IF4TYXUhCpHWnEHVJMdJXWjwEZmvFrk9+la5sO
 NUAoQQcDC66dXoH0SiQkq3tw4DOkU/OpeeUhsN7bJPZeLbzkpzvuWaao03QRLJpZS6VG
 KbxkCCFDPJIJhl5j7MD0Rz+W5w+McFm3lOxjSGeMAci4CviJ2wbJSy3INheK+SjoYL5o
 l51+recO3JG15XoNy7OxTo01JDTlobr0SHARpaKyKrVyEJ9qvlTJ5iyfqoRech4q0d/u
 DDmA==
X-Gm-Message-State: AHQUAuYNX6XrR6qIlsaiyGGQNifeZVuTE2o2/xrrAsXVNmaa0jiUbYZs
 SBCpm9VUHC1UYAUJ3tj4AwOZlKtipvVztW0h7MbV9w==
X-Google-Smtp-Source: ALg8bN7MMrwk+mDhe1MAT62s0PJe2rrA2KEAm7wdRDHXrdh4GEcylnlhpDq5vV5o5XFaFGE662HzS6BFV0hRef3SsE0=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr15346210ion.173.1548772459410; 
 Tue, 29 Jan 2019 06:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
 <20190129092150.15184-3-ard.biesheuvel@linaro.org>
 <0ea153fd-1c2b-c4e6-54d9-e31189f1b90c@suse.de>
 <CAKv+Gu8S-EFdVtuKHEtV=3Mi7tKWjxEbjovAdspaKTzmUwAfjQ@mail.gmail.com>
 <15bc4db9-779b-93b3-3e6a-be8cda07be67@suse.de>
In-Reply-To: <15bc4db9-779b-93b3-3e6a-be8cda07be67@suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Jan 2019 15:34:08 +0100
Message-ID: <CAKv+Gu8vWfbKBssebBnVrALhdf2W5+6GpVHEtLFEn66Dr5R-zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: x86: convert x86 EFI earlyprintk into generic
 earlycon implementation
To: Alexander Graf <agraf@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_063420_517318_85BDC9F4 
X-CRM114-Status: GOOD (  24.46  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Graeme Gregory <graeme.gregory@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Peter Jones <pjones@redhat.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 at 15:04, Alexander Graf <agraf@suse.de> wrote:
>
> On 01/29/2019 02:41 PM, Ard Biesheuvel wrote:
> > Hi Alex,
> >
> > On Tue, 29 Jan 2019 at 14:37, Alexander Graf <agraf@suse.de> wrote:
> >> On 01/29/2019 10:21 AM, Ard Biesheuvel wrote:
> >>> Move the x86 EFI earlyprintk implementation to a shared location under
> >>> drivers/firmware and tweak it slightly so we can expose it as an earlycon
> >>> implementation (which is generic) rather than earlyprintk (which is only
> >>> implemented for a few architectures)
> >>>
> >>> This also involves switching to write-combine mappings by default (which
> >>> is required on ARM since device mappings lack memory semantics, and so
> >>> memcpy/memset may not be used on them), and adding support for shared
> >>> memory framebuffers on cache coherent non-x86 systems (which do not
> >>> tolerate mismatched attributes)
> >>>
> >>> Note that 32-bit ARM does not populate its struct screen_info early
> >>> enough for earlycon=efifb to work, so it is disabled there.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>>    Documentation/admin-guide/kernel-parameters.txt |   8 +-
> >>>    arch/x86/Kconfig.debug                          |  10 -
> >>>    arch/x86/include/asm/efi.h                      |   1 -
> >>>    arch/x86/kernel/early_printk.c                  |   4 -
> >>>    arch/x86/platform/efi/Makefile                  |   1 -
> >>>    arch/x86/platform/efi/early_printk.c            | 240 --------------------
> >>>    drivers/firmware/efi/Kconfig                    |   6 +
> >>>    drivers/firmware/efi/Makefile                   |   1 +
> >>>    drivers/firmware/efi/earlycon.c                 | 208 +++++++++++++++++
> >>>    9 files changed, 222 insertions(+), 257 deletions(-)
> >>>
> >> [...]
> >>
> >>> +static int __init efi_earlycon_setup(struct earlycon_device *device,
> >>> +                                  const char *opt)
> >>> +{
> >>> +     struct screen_info *si;
> >>> +     u16 xres, yres;
> >>> +     u32 i;
> >>> +
> >>> +     if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >>> +             return -ENODEV;
> >>> +
> >>> +     fb_base = screen_info.lfb_base;
> >>> +     if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> >>> +             fb_base |= (u64)screen_info.ext_lfb_base << 32;
> >>> +
> >>> +     if (opt && !strcmp(opt, "ram"))
> >>> +             fb_prot = PAGE_KERNEL;
> >>> +     else
> >>> +             fb_prot = pgprot_writecombine(PAGE_KERNEL);
> >> Can you determine the default from the UEFI memory map?
> >>
> > No. This is being called way before we parse the system table and the
> > memory map. Given that this is debug code, duplicating a significant
> > chunk of that work here (and run the risk of crashing here due to
> > unexpected contents in those tables) is not a great idea imo.
>
> I see. Maybe we will want to have something there, but I tend to agree
> that for now we should keep bits as simple as possible.
>
> >
> >> Also, doesn't the current logic map it as WC on x86 too? Is that
> >> intentional?
> >>
> > Yes. As mentioned in the cover letter, this aligns it with efifb which
> > also uses WC by default (although there, it can be overridden for
> > performance reasons, but due to the debug nature of earlycon, this
> > doesn't matter, since higher performance only makes it more difficult
> > to capture the log on your phone camera)
>
> Well, the cover letter really only talks about arm :). But yeah, I think
> it's probably a good idea to map it WC regardless.
>

Fair enough.

> Overall, I would've preferred to have a larger patch set with more, but
> smaller changes that refactor the code. But it seems to be reviewable
> enough still. Let's cross our fingers it doesn't break :).
>
>
> Reviewed-by: Alexander Graf <agraf@suse.de>
>

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
