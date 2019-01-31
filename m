Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3523F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHtYDlWB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp269b/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9MC/0EwdJpE+Np/NeNSU9gjvsCuVAAKr+TWdCTLCqU=; b=LHtYDlWBWBIHEL
	Cy6FkzVXmcIbcmxVu2NcEI9qI4YITI9LaNC/LFSzyo/Z0bXBAbCwsGazz4rS59JqT1+fgR0FcDZLL
	EmDKzgZR1P+ay6R2bzLn0kV1TC3AZ04q7COjI/ss1t9mkjbkb79vFkzc1FWO6vAMxxOkGBj5Byyfk
	MQXWeFWw2AVvsur+LMbH+qT0eaAK5iB8ejYirgtiVBj8u7VzJ4Xi9/WTIeAlP6V+w/GxPTp8gaifJ
	VnVLICkBrpo+hq/g4J2GAUqR+jMZAJTw+uAZmI9Qnun7rxBhIPXQSeW0nwbNm5imflyPjilg1KBty
	qMujespewradxq+TCaiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp5JF-00028V-TE; Thu, 31 Jan 2019 05:54:45 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp5JB-00027p-Bm
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 05:54:42 +0000
Received: by mail-lj1-x241.google.com with SMTP id l15-v6so1566213lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 21:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4F+BIoC5hFXGqBFlBhOZIqVE+Jy7im/3T8WXfXdLwWI=;
 b=bp269b/5XwF27CgSY7s+wmtEk4znSKlB+M7K1RDVTTco3dDvaKmSLnFFquclkJt18k
 LZpHSBmntIEUuMDbjTR114tCnjQkr+3lqKcF50ogrKnu7lrWIhkwYqcP6a7MnfbQdUws
 9E9jOHe6v1AP0ymA4X1LIsSA1F6uI7ekTxHdfi37rPcTNoHLgIaVv6Qg/tx/ZesCXa4K
 MCT7nlJUR/T3B+E+eF0NujO4qRatgvsG9aT5bD6XycZ6AGJsWKTcM8pDRWVXL/8sKxo9
 c/KuhM6CBbyGHgyNibBg8adtha/7r5dnq60ytbuO4unJxjh8QVAcFj5doUN9xxeWmDq/
 16Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4F+BIoC5hFXGqBFlBhOZIqVE+Jy7im/3T8WXfXdLwWI=;
 b=qVIx7XxqDl4wNIiEUAU916JOPyFXa6xFok0xFWWVtiDK5fRSHZ+BnKhVncZmCAmhDj
 dUgmtJGLRdUac4ADF/3PRt7SjZnKfcArmvMK9LDVwTq/z5E48znfe4KPh6pNgE5e82Kx
 CnmvdSeMrnPApEn+8Q3GDv+tUSbzWallUqX1xKi7wychmgq+Spru+H8zsEZqGqxKIc3D
 nHbC196Xf+yM8mVgTTtrCdQ2Ep1Zlk9zhNCPGztly2m344a9+xNAwPA91b9HMvCSlyhA
 h7JJ6hPyoyLh3ho4JMV1O9ahf7OoNDmRFqVNcPJlPN+hYTiVyg0GzKk3zyNG9PIX2HTV
 MK6g==
X-Gm-Message-State: AJcUukc0LSOAOfMvQTIZ5KN5xy/C0J8PBPYK/Qj1SQ5Ar9VOWF9UWm6I
 +ng2APvNHzqJ8XWwniI2Sozg75IZJW0nzu0QpOE=
X-Google-Smtp-Source: ALg8bN4UZl+eNXzJK3EHyOKNamr0dpp4Ec4HLveXW/6ZiFj9iQ73NQazBbBLuQK4t9krAIMCTdLCglSsl+6gY6r7o+s=
X-Received: by 2002:a2e:8643:: with SMTP id
 i3-v6mr28777535ljj.43.1548914077333; 
 Wed, 30 Jan 2019 21:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx>
In-Reply-To: <20190117112803.GC3710@rapoport-lnx>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 31 Jan 2019 11:24:24 +0530
Message-ID: <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mm: Remove duplicate header
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_215441_412858_2F66F2DB 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 rppt@linux.vnet.ibm.com, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> > On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > Remove duplicate headers which are included twice.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>
> > Any comment on this patch ?

If no further comment, can we get this patch in queue for 5.1 ?

> >
> > > ---
> > >  arch/arm/mm/mmu.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index f5cc1cc..dde3032 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -23,7 +23,6 @@
> > >  #include <asm/sections.h>
> > >  #include <asm/cachetype.h>
> > >  #include <asm/fixmap.h>
> > > -#include <asm/sections.h>
> > >  #include <asm/setup.h>
> > >  #include <asm/smp_plat.h>
> > >  #include <asm/tlb.h>
> > > @@ -36,7 +35,6 @@
> > >  #include <asm/mach/arch.h>
> > >  #include <asm/mach/map.h>
> > >  #include <asm/mach/pci.h>
> > > -#include <asm/fixmap.h>
> > >
> > >  #include "fault.h"
> > >  #include "mm.h"
> > > --
> > > 1.9.1
> > >
> >
>
> --
> Sincerely yours,
> Mike.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
