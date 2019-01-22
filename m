Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C6C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5D321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxecnXMS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYnpA5sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5D321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T3X2g3+T8keBpakdAw4/vXnhTp0t8h42NLrXLED7UTw=; b=gxecnXMSvdq0WE
	SP64Fxvz4d6b398MENigTEkTgnq9JM8Nx93f57hm1mUsuP4ptNffwKERkYCDjxciBgCyPABajun+K
	s/f2eI0KpTsLPDtCRIXCdvnq+M6H+10BdCQ66NdODB9CAlCosRnxvJ0DQCCNYuxX93+e7j3bmx6xb
	0MWFyItOszYOApzu8dufhFniWwg4jtBDE5cuauSwTCVMOSPsNIGi8va/GPJht3fR41GCcp1HBkcp8
	AxNjXCEgV4o7NuCpax0sk9X/4Jf88naQOISQ3g47l4XubR0d/WUAU/iePWA3NkTboKygLACMyMXX8
	Vsv7VaW4sA1HcNfkb97Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0Sh-00026e-Gq; Tue, 22 Jan 2019 18:07:47 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Sd-00026F-6t
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:07:45 +0000
Received: by mail-it1-x144.google.com with SMTP id b5so21396468iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yrBeb97mtWiwMJ9ugQgOL4CFF7vV56ajvn4Qn46h1g0=;
 b=RYnpA5scmbAXbPgbXr1xrvCJDEPL6FqXqhiZcOaL3e8LelSTVPoEyg/UUVIFBtKa+O
 hqaUYeX3FLQ2xnpTtC/EoQx1zbC6mWyKvRL7yVrbs3vgNFs7+LBPSF5tYhPbJFUjkbFE
 Sp3A2GR9QcZH8NHIo7Fzjb8PbHUufcG+cJ2Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yrBeb97mtWiwMJ9ugQgOL4CFF7vV56ajvn4Qn46h1g0=;
 b=BO/X7/lvGxC88IRRDp0p4paUHMpRAi+OQx7mT4HsYqLUI8XZCATKam2iQrPZHVxHIi
 adsszDg4y9sEUXukhTPDUXT05tRNbplHFohaB/8HwVr5RI+/dvSm4mB5y9x2LBTAuXYp
 8kSO0tQWXxxN7v8LDOTy04r78Dkc2b9fEGXgEKdSvohApRyH+t2dhC/jvil8drCUW7Dm
 FrwTA0YkAyh7WIMJ6Pk+ID+f1eWNST9rL1gg7qNU/Fal1ZRMHOjAnOC0Eq94gz7+ovxU
 5Je77awizq16Sxm/j534DLrzDrgkesW/S3N5rxMtPRshU75pEne7+YjKGOqctCeE9VQP
 jYlg==
X-Gm-Message-State: AJcUukeUc2gWfZ4nnaFBh1ikv22VFkvTuVFF2EkUNzZ9YWjnkTryxqlo
 pfRCziAllktkVJDtEiXiKyKnsy9QQrSNjtlDgfF3fA==
X-Google-Smtp-Source: ALg8bN6IITkng2xNX/yPsugGNLsBCY8L0/+48YTJscKMxWVt1cJubO5prUVcRguwSM3xJWNNoJWWwzqK8GDdCXBfvGM=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr2847228itk.71.1548180461806; 
 Tue, 22 Jan 2019 10:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <20190122173222.GB11720@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190122173222.GB11720@e107981-ln.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 22 Jan 2019 19:07:30 +0100
Message-ID: <CAKv+Gu9-tDRbmt+T3or9pMs78-pU-9BpKorhB60N_=Bxo78A1g@mail.gmail.com>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_100743_259074_5F8A2E26 
X-CRM114-Status: GOOD (  31.92  )
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
 Graeme Gregory <graeme.gregory@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, "Hsiung, Harry L" <harry.l.hsiung@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 at 18:32, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Jan 22, 2019 at 04:06:16PM +0100, Ard Biesheuvel wrote:
> > The bitmap left in the framebuffer by the firmware is described by an
> > ACPI table called "BGRT", which describes the size, pixel format and
> > the address of a BMP image in memory. While the BGRT ACPI table is
> > guaranteed to reside in a "ACPI reclaim" memory region, which is
> > never touched by Linux. The BMP image, however, typically resides
> > in EFI Boot Services Memory, which may have been overwritten by the
> > time the BGRT discovery routine runs.
> >
> > So instead, drop the handling from the ACPI init code, and call the
> > BGRT parsing code immediately after going over the EFI configuration
> > table array, at which time no memory has been touched yet except for
> > the .data/.bss regions covered by the static kernel image.
> >
> > Unfortunately, this involves a non-trivial amount of ACPI entry
> > point and root table parsing, but we cannot rely on the normal
> > ACPI infrastructure yet this early in the boot.
> >
> > Also note that we cannot take the 'acpi_disabled' global variable
> > into account, since it may not have assumed the correct value yet
> > (on arm64, the default value is '1' which is overridden to '0' if
> > no DT description has been made available by the firmware)
> >
> > Cc: Peter Jones <pjones@redhat.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Technically this is a fix, right ?
>

I would argue that it is a hack to work around a deficiency in the
ACPI spec, i.e., that the BGRT table but not the image are passed in
ACPI reclaim memory.

> > ---
> >  arch/arm64/kernel/acpi.c        |  2 -
> >  arch/x86/kernel/acpi/boot.c     |  2 -
> >  drivers/acpi/bgrt.c             |  6 --
> >  drivers/firmware/efi/efi-bgrt.c | 80 ++++++++++++++++++--
> >  drivers/firmware/efi/efi.c      | 13 ++++
> >  include/linux/efi-bgrt.h        |  4 +-
> >  6 files changed, 89 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index 44e3c351e1ea..7429a811f76d 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -230,8 +230,6 @@ void __init acpi_boot_table_init(void)
> >                       early_init_dt_scan_chosen_stdout();
> >       } else {
> >               acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> > -             if (IS_ENABLED(CONFIG_ACPI_BGRT))
> > -                     acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> >       }
> >  }
> >
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 2624de16cd7a..2d3535b62752 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -1633,8 +1633,6 @@ int __init acpi_boot_init(void)
> >       acpi_process_madt();
> >
> >       acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
> > -     if (IS_ENABLED(CONFIG_ACPI_BGRT))
> > -             acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> >
> >       if (!acpi_noirq)
> >               x86_init.pci.init = pci_acpi_init;
> > diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
> > index 75af78361ce5..048413e06898 100644
> > --- a/drivers/acpi/bgrt.c
> > +++ b/drivers/acpi/bgrt.c
> > @@ -81,12 +81,6 @@ static const struct attribute_group bgrt_attribute_group = {
> >       .bin_attrs = bgrt_bin_attributes,
> >  };
> >
> > -int __init acpi_parse_bgrt(struct acpi_table_header *table)
> > -{
> > -     efi_bgrt_init(table);
> > -     return 0;
> > -}
> > -
> >  static int __init bgrt_init(void)
> >  {
> >       int ret;
> > diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
> > index b22ccfb0c991..8bd9b96942d2 100644
> > --- a/drivers/firmware/efi/efi-bgrt.c
> > +++ b/drivers/firmware/efi/efi-bgrt.c
> > @@ -27,24 +27,92 @@ struct bmp_header {
> >       u32 size;
> >  } __packed;
> >
> > -void __init efi_bgrt_init(struct acpi_table_header *table)
> > +void __init efi_bgrt_init(unsigned long rsdp_phys)
> >  {
> >       void *image;
> >       struct bmp_header bmp_header;
> >       struct acpi_table_bgrt *bgrt = &bgrt_tab;
> > +     struct acpi_table_bgrt *table = NULL;
> > +     struct acpi_table_rsdp *rsdp;
> > +     struct acpi_table_header *hdr;
> > +     u64 xsdt_phys;
> > +     u32 rsdt_phys;
> > +     unsigned int len;
> >
> > -     if (acpi_disabled)
> > +     if (!efi_enabled(EFI_MEMMAP))
> >               return;
> >
> > -     if (!efi_enabled(EFI_MEMMAP))
> > +     /* map the root pointer table to find the xsdt/rsdt values */
> > +     rsdp = early_memremap(rsdp_phys, sizeof(*rsdp));
> > +     if (rsdp && ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
> > +             xsdt_phys = rsdp->xsdt_physical_address;
> > +             rsdt_phys = rsdp->rsdt_physical_address;
> > +     } else {
> > +             WARN_ON(1);
>
> You may need to unmap rsdp.
>

Indeed.

> > +             return;
> > +     }
> > +     early_memunmap(rsdp, sizeof(*rsdp));
> > +
> > +     /* obtain the length of whichever table we will be using */
> > +     hdr = early_memremap(xsdt_phys ?: rsdt_phys, sizeof(*hdr));
> > +     if (WARN_ON(!hdr))
> > +             return;
> > +     len = hdr->length;
> > +     early_memunmap(hdr, sizeof(*hdr));
> > +
> > +     if (xsdt_phys) {
> > +             struct acpi_table_xsdt *xsdt = early_memremap(xsdt_phys, len);
> > +             int i;
> > +
> > +             if (WARN_ON(!xsdt))
> > +                     return;
> > +
> > +             for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u64); i++) {
> > +                     table = early_memremap(xsdt->table_offset_entry[i],
> > +                                            sizeof(*table));
> > +                     if (WARN_ON(!table))
> > +                             break;
> > +
> > +                     if (ACPI_COMPARE_NAME(table->header.signature,
> > +                                           ACPI_SIG_BGRT))
> > +                             break;
> > +                     early_memunmap(table, sizeof(*table));
> > +                     table = NULL;
> > +             }
> > +             early_memunmap(xsdt, len);
> > +     } else if (rsdt_phys) {
> > +             struct acpi_table_rsdt *rsdt = early_memremap(rsdt_phys, len);
> > +             int i;
> > +
> > +             if (WARN_ON(!rsdt))
> > +                     return;
> > +
> > +             for (i = 0; i < (len - sizeof(*hdr)) / sizeof(u32); i++) {
> > +                     table = early_memremap(rsdt->table_offset_entry[i],
> > +                                            sizeof(*table));
> > +                     if (WARN_ON(!table))
> > +                             break;
> > +
> > +                     if (ACPI_COMPARE_NAME(table->header.signature,
> > +                                           ACPI_SIG_BGRT))
> > +                             break;
> > +                     early_memunmap(table, sizeof(*table));
> > +                     table = NULL;
> > +             }
> > +             early_memunmap(rsdt, len);
> > +     }
> > +
> > +     if (!table)
> >               return;
> >
> > -     if (table->length < sizeof(bgrt_tab)) {
> > +     if (table->header.length < sizeof(bgrt_tab)) {
> >               pr_notice("Ignoring BGRT: invalid length %u (expected %zu)\n",
> > -                    table->length, sizeof(bgrt_tab));
> > +                    table->header.length, sizeof(bgrt_tab));
> >               return;
>
> Likewise for the table pointer.
>

Yep.

> >       }
> > -     *bgrt = *(struct acpi_table_bgrt *)table;
> > +     *bgrt = *table;
> > +     early_memunmap(table, sizeof(*table));
> > +
> >       if (bgrt->version != 1) {
> >               pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
> >                      bgrt->version);
>
> Side note (not related to this patch):
>
> I do not understand this check:
>
> if (bgrt->status & 0xfe) {
>         pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
>                bgrt->status);
>         goto out;
> }
>
> Should not we check against 0xf8 (reserved bits are [7:3]) ? And what
> about status[0] (valid), should we check that as well ?
>

I will let Peter take that question ...

Thanks,
Ard.

> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 4c46ff6f2242..e5ef5c0eacc1 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/init.h>
> >  #include <linux/device.h>
> >  #include <linux/efi.h>
> > +#include <linux/efi-bgrt.h>
> >  #include <linux/of.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/io.h>
> > @@ -592,6 +593,18 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
> >
> >               early_memunmap(tbl, sizeof(*tbl));
> >       }
> > +
> > +     /*
> > +      * We need to parse the BGRT table (which is an ACPI table not a UEFI
> > +      * configuration table) by hand and figure out where the bitmap it
> > +      * describes lives in memory so we can reserve it early on. Otherwise,
> > +      * it may be clobbered by the time we get to it during the ordinary ACPI
> > +      * table init sequence.
> > +      */
> > +     if (IS_ENABLED(CONFIG_ACPI_BGRT) &&
> > +         efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +             efi_bgrt_init(efi.acpi20);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/include/linux/efi-bgrt.h b/include/linux/efi-bgrt.h
> > index e6cd51005633..528ea62d99ec 100644
> > --- a/include/linux/efi-bgrt.h
> > +++ b/include/linux/efi-bgrt.h
> > @@ -6,7 +6,7 @@
> >
> >  #ifdef CONFIG_ACPI_BGRT
> >
> > -void efi_bgrt_init(struct acpi_table_header *table);
> > +void efi_bgrt_init(unsigned long rsdp_phys);
> >  int __init acpi_parse_bgrt(struct acpi_table_header *table);
> >
> >  /* The BGRT data itself; only valid if bgrt_image != NULL. */
> > @@ -15,7 +15,7 @@ extern struct acpi_table_bgrt bgrt_tab;
> >
> >  #else /* !CONFIG_ACPI_BGRT */
> >
> > -static inline void efi_bgrt_init(struct acpi_table_header *table) {}
> > +static inline void efi_bgrt_init(unsigned long rsdp_phys) {}
> >  static inline int __init acpi_parse_bgrt(struct acpi_table_header *table)
> >  {
> >       return 0;
> > --
> > 2.20.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
