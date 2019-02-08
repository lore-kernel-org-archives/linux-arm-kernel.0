Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FFBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:56:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9CF2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9YJTgj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9CF2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YxJVBpkCJlixLScLzeAKEgAFLxvdPF3gW4952MRn5Fc=; b=o9YJTgj6J68V4e
	+RoEj0oLxDxKrunzsRkzugB0k6+HK+uSfj2MN1534dFARqAjirbhVOJW09gaSlEYIcXsxnSFOC8rR
	89+3+S9jxrUwYDzVW+K9PIpOwkCzDCWASyS5WhlnnLVY1LnJZjHl/AP73SJviC27k9HzL5hpS1RJW
	86FzknZ4bTtTEqOOgkVnjyi2XNHJFmHSSUq211DXmZ/gI7aKUZEtLBcMuZ6U5c6iSAPL0QkEmZE61
	cQIPpDvWyknpBG5y6IQFmEe11ypDd1FobtV/LbBWna6XXTrmLVthab2QPlb8yp9Z1hMHNLstmvi/l
	W15/Y+6sP4pQLDzDRuqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsBJg-0007yh-VM; Fri, 08 Feb 2019 18:56:00 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsBJV-0007i9-Un
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 18:55:59 +0000
Received: by mail-vs1-f67.google.com with SMTP id z3so2723350vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 10:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f61cwLrdFDvWDcPfkag69gux4j1k/vsAch0XX1ifjVE=;
 b=rzOl6dTK+3vBB64rNXaaZs09K9j8jE4/4arOJF9GvC3n0ZeFPhfM4edyAMiOwCgIBf
 CYHBjOPQbJsIKWez2FL1VG69fgGSptWan3sDuAVnBglaXjtZ0SR/GQNLydBHIYAwYOjv
 7xRYPed4EBGXqpXQC7uM1JhcWcbtDy1nvYjDx35pVm7XifTh3YXibOfAjajpuHfvt7TQ
 gByLLFCHzMcjAEyOtnHOjse6MNg1xIKmDRuV95wkwDMTKyHHW9iSCjej9OQ6owZIwgCH
 lU4BHYcKTbUEjaUYP6F8ChwPGCwl5+S0LwE3V+Y5HCsuLwVlcBkuA5MmXKlmGdXIbCmR
 1FYA==
X-Gm-Message-State: AHQUAuYDM8EXwPFZTtZX8gW/lKZgweepqnvnn9uCLZGRCwHkm/ONqbfL
 JYIS/HRdSzdR2LMalEta32DmzepKPnoPoHffU0E=
X-Google-Smtp-Source: AHgI3IaRK3MtMkGTGISomWxB18I0In+4ZKMz+zuiS6KmxlUba/ZclgIgxCKKCfF9lJbpsQnUMR6sQXX7sbWPVRJ8YT4=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9783331vsp.166.1549652147985;
 Fri, 08 Feb 2019 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
 <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
In-Reply-To: <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Feb 2019 19:55:36 +0100
Message-ID: <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_105550_217409_AE646070 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Robin,

On Fri, Feb 8, 2019 at 6:55 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/02/2019 16:40, Joerg Roedel wrote:
> > On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index 8ac10af17c0043a3..d62487d024559620 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >>                      drv->remove(dev);
> >>
> >>              device_links_driver_cleanup(dev);
> >> -            arch_teardown_dma_ops(dev);
> >>
> >>              devres_release_all(dev);
> >> +            arch_teardown_dma_ops(dev);
> >>              dev->driver = NULL;
> >>              dev_set_drvdata(dev, NULL);
> >>              if (dev->pm_domain && dev->pm_domain->dismiss)
> >
> > Thanks for the fix! Should it also be tagged for stable and get a Fixes

FTR, Greg has added it to driver-core-testing, with a CC to stable.

> > tag? I know it only triggers with a fix in v5.0-rc, but still...
>
> I think so:
>
> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time
> for platform/amba/pci bus devices")

Thanks! It won't backport cleanly due to commit dc3c05504d38849f
("dma-mapping: remove dma_deconfigure") in v4.20, though.

> There aren't many drivers using dmam_alloc_*(), let alone which would
> also find themselves behind an IOMMU on an Arm system, but it turns out
> I actually have another one which can reproduce the BUG() with 5.0-rc.

SATA core uses dmam_alloc_*().

> I've tried a 4.12 kernel with a bit of instrumentation[1] and sure
> enough the devres-managed buffer is freed with the wrong ops[2] even
> then. How it manages not to blow up more catastrophically I have no
> idea... I guess at best it just leaks the buffers and IOMMU mappings,
> and at worst quietly frees random other pages instead.

May depend on the actual ops, and whether CMA is used or not.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
