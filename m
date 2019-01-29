Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1770C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8D220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HjSlZnkW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3IP0wvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8D220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zJFmYQq0bHRhNT1hzKisrElMM+7aXH1qRxknSUEStJk=; b=HjSlZnkWKimxvE
	IQfEzH/EAZEmDu4eKpn3oLEZ3HFB/C1TkrwsCRFsg48Oa2Iq8ewqvebniLDOe2m+tEqLgpNsTjbB4
	iS0JvpLV0r226pSxK2QUb6A1xpEjs4EDDHFbqom/qub9CX3PY4MLFjzUXUOknzmEMNEIgovhSJ2u4
	0j3hz8T1JEbrNhdhm/hSx2443n5p4qi4SfaQlC11deRmBRB7VoYfo4Hjmcq97uHGP9LQzsc649v+w
	lV29TTLBDGV65b3jVJainufCxcwe0OGCjYj/Woq5q0fX0a0fyXpBQ7gk1H8GlidZjEmBDzmINEkse
	GB1QymVkzeDx5yNlrBMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTeR-0003lo-86; Tue, 29 Jan 2019 13:42:07 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTeN-0003lE-IB
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:42:05 +0000
Received: by mail-it1-x144.google.com with SMTP id d11so4515625itf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x+grDnfJAgABtQck5U8w0dV8K15R3XKvjTcRJHODgYc=;
 b=Y3IP0wvuqC21SeSVWa7tbdHF56eK4V3Xt2wEOtobUJhl994ogC2F+8R9x6Pi8zz/QL
 HNNuhW2m/8tcyhkCB/T8Fmf7ZXyAo4MUEeST+ThVa7vaheQDC3sb0OIku3qHb2fi5GjE
 S4BUTHXU15uZXG0wcZ1eWyxSLrRNvya9zONc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x+grDnfJAgABtQck5U8w0dV8K15R3XKvjTcRJHODgYc=;
 b=tpVsdxJAVGi1gcgjjsoUYEqyT7Ms0LrSbhtOG+9BnFdKKDF5CmjhDKfB7m0QieJyZ9
 lZraiYWzw5+LBH5e6Ig6Hp4hpb6bWUd4ywhd/a3lnrJzKsVyQWWppZwYfRombiwcRFQX
 xsclMkqS4JNbxlCAjL/++xglco9F+0HCW2QO2+I5Rf/bnb4b+sFp2U8J142PNEODrXTj
 trMf/+0qjx8uteKC62joL91W7ay5thcfVSkqpnCMzY3M3vWvOxg9vw7L+ugUzOd0E1xJ
 y0iskspeQmUvLMYa0EHQMJbMM/RNSmzSZOcGPVAFhuXfIlthr0AZzKZx+jDxli0twVsZ
 OvzA==
X-Gm-Message-State: AJcUukdKWfugogNwXud7EANyS7fNpaB5cUguy3RTfY2V/KDBe8ToiTAe
 qzKnS7A/SWpZgGexyAdapxqZ44QCgUvfUYbDQpJkQw==
X-Google-Smtp-Source: ALg8bN7UyWyKFb9uvZGUPSUWycoNnAcz9hygaP3G1aIVad4kO2ykZQcImcWPq0KZipgupcGTDyexgU96kBjGOT0x4DM=
X-Received: by 2002:a24:710:: with SMTP id f16mr11287836itf.121.1548769322146; 
 Tue, 29 Jan 2019 05:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
 <20190129092150.15184-3-ard.biesheuvel@linaro.org>
 <0ea153fd-1c2b-c4e6-54d9-e31189f1b90c@suse.de>
In-Reply-To: <0ea153fd-1c2b-c4e6-54d9-e31189f1b90c@suse.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Jan 2019 14:41:51 +0100
Message-ID: <CAKv+Gu8S-EFdVtuKHEtV=3Mi7tKWjxEbjovAdspaKTzmUwAfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: x86: convert x86 EFI earlyprintk into generic
 earlycon implementation
To: Alexander Graf <agraf@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_054203_598105_52564912 
X-CRM114-Status: GOOD (  21.71  )
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

Hi Alex,

On Tue, 29 Jan 2019 at 14:37, Alexander Graf <agraf@suse.de> wrote:
>
> On 01/29/2019 10:21 AM, Ard Biesheuvel wrote:
> > Move the x86 EFI earlyprintk implementation to a shared location under
> > drivers/firmware and tweak it slightly so we can expose it as an earlycon
> > implementation (which is generic) rather than earlyprintk (which is only
> > implemented for a few architectures)
> >
> > This also involves switching to write-combine mappings by default (which
> > is required on ARM since device mappings lack memory semantics, and so
> > memcpy/memset may not be used on them), and adding support for shared
> > memory framebuffers on cache coherent non-x86 systems (which do not
> > tolerate mismatched attributes)
> >
> > Note that 32-bit ARM does not populate its struct screen_info early
> > enough for earlycon=efifb to work, so it is disabled there.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt |   8 +-
> >   arch/x86/Kconfig.debug                          |  10 -
> >   arch/x86/include/asm/efi.h                      |   1 -
> >   arch/x86/kernel/early_printk.c                  |   4 -
> >   arch/x86/platform/efi/Makefile                  |   1 -
> >   arch/x86/platform/efi/early_printk.c            | 240 --------------------
> >   drivers/firmware/efi/Kconfig                    |   6 +
> >   drivers/firmware/efi/Makefile                   |   1 +
> >   drivers/firmware/efi/earlycon.c                 | 208 +++++++++++++++++
> >   9 files changed, 222 insertions(+), 257 deletions(-)
> >
>
> [...]
>
> > +static int __init efi_earlycon_setup(struct earlycon_device *device,
> > +                                  const char *opt)
> > +{
> > +     struct screen_info *si;
> > +     u16 xres, yres;
> > +     u32 i;
> > +
> > +     if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> > +             return -ENODEV;
> > +
> > +     fb_base = screen_info.lfb_base;
> > +     if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> > +             fb_base |= (u64)screen_info.ext_lfb_base << 32;
> > +
> > +     if (opt && !strcmp(opt, "ram"))
> > +             fb_prot = PAGE_KERNEL;
> > +     else
> > +             fb_prot = pgprot_writecombine(PAGE_KERNEL);
>
> Can you determine the default from the UEFI memory map?
>

No. This is being called way before we parse the system table and the
memory map. Given that this is debug code, duplicating a significant
chunk of that work here (and run the risk of crashing here due to
unexpected contents in those tables) is not a great idea imo.

> Also, doesn't the current logic map it as WC on x86 too? Is that
> intentional?
>

Yes. As mentioned in the cover letter, this aligns it with efifb which
also uses WC by default (although there, it can be overridden for
performance reasons, but due to the debug nature of earlycon, this
doesn't matter, since higher performance only makes it more difficult
to capture the log on your phone camera)


> > +
> > +     si = &screen_info;
> > +     xres = si->lfb_width;
> > +     yres = si->lfb_height;
> > +
> > +     /*
> > +      * efi_earlycon_write_char() implicitly assumes a framebuffer with
> > +      * 32-bits per pixel.
> > +      */
> > +     if (si->lfb_depth != 32)
> > +             return -ENODEV;
> > +
> > +     font = get_default_font(xres, yres, -1, -1);
> > +     if (!font)
> > +             return -ENODEV;
> > +
> > +     efi_y = rounddown(yres, font->height) - font->height;
> > +     for (i = 0; i < (yres - efi_y) / font->height; i++)
> > +             efi_earlycon_scroll_up();
> > +
> > +     device->con->write = efi_earlycon_write;
> > +     return 0;
> > +}
> > +EARLYCON_DECLARE(efifb, efi_earlycon_setup);
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
