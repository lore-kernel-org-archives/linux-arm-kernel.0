Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C63A2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPTK5B8z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqI6beZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C63A2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pMZBNC+M1PX4nv6pHLrjrmM+jSk8mn72S7nPr+C+xYM=; b=hPTK5B8znj5f/x
	RetH0qTziawm/18rfbct30ld09AeC0O9U0n4xbYNWHF/t+tTRtM4qUxBx0oV4p33haN0yaIBhz+J0
	K3aZN7iLJoYEaN7ckUB2aRPUhcSIjvw+hE8ujwZ/ogh7jkgysjhaefhp7LBTG9bYSbdJbN0gLLP7P
	ywgtcE2gSpeyNzbP3dQvJ9AsUIIn5PyAqm47x0WVCuP1NgVaSgjarH0GOCTmyR/mMcUvwxwr6J5v3
	YZvWBeGK0EjHiNvf0D7QcNOiZ3kuIIsrNrQlYO+GIJ/zAJ6RgBxMxkfobuHn2ZPIJeP6k12oXDdSp
	gwHnAks/8+2dhWywvfZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyiyl-00019B-Ez; Tue, 26 Feb 2019 20:05:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyiyh-00018j-Tz
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:05:25 +0000
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBE3F21874
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551211522;
 bh=7++oKPSczVWE3WQHUIE4FRSsEwE8N2rUD/s0q7bdLHg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UqI6beZYgXOakxqjy4lj15CPrBCuutHZQvDqbkgoLFR5rmyknDC/GpQucEIpNy7Kd
 REP/2XYSOCDSCIOtX6893DuaH+p/4xoeRoG99P23PjmEaOtnUKnUq6yYX90VouYONH
 SygFzhBp5Eikn7JOzaAcSNsEIsRHKmB/l2VCyAgI=
Received: by mail-qk1-f177.google.com with SMTP id h28so8404007qkk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:05:21 -0800 (PST)
X-Gm-Message-State: AHQUAuY9UP74lz73UaPxzUa5AYzwERU++mPMyRK/vixS6G5mlykSTOCg
 +xcKR64UMh20bBiUNf5jl1EOaxwDIsBSU6ph4w==
X-Google-Smtp-Source: AHgI3Ib3RBZnScyqr624DnVWz5AdDFsFOxKphig3vWHcXRPSvSpQVHwPslpGNijTE5oZLEWgiCO2YnHi0pc/Tcybz5A=
X-Received: by 2002:a37:a381:: with SMTP id m123mr1419299qke.147.1551211521070; 
 Tue, 26 Feb 2019 12:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20190226181716.14556-1-robh@kernel.org>
 <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
In-Reply-To: <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Feb 2019 14:05:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
Message-ID: <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_120523_987493_808B86C1 
X-CRM114-Status: GOOD (  18.61  )
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
Cc: Joerg Roedel <joro@8bytes.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 1:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Rob,
>
> On 26/02/2019 18:17, Rob Herring wrote:
> > ARM Mali midgard GPUs have a few differences from standard 64-bit
> > stage 1 page tables.
> >
> > The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> >
> > The access flags are not read-only and unprivileged, but read and write.
> > This is similar to stage 2 entries, but the memory attributes field matches
> > stage 1 being an index.
> >
> > The nG bit is also not set by the vendor driver, but that one doesn't
> > seem to matter.
> >
> > Add a quirk to handle all of these differences.
>
>  From the look of these changes, this isn't a quirk but a distinct
> format. AFAICS from the mali_kbase driver, this must be "LPAE mode"
> rather than "AArch64 mode", so it seems unlikely that it really supports
> the full VMSAv8 gamut of granules, address sizes, and page sizes that
> this patch will happily let through.

Right, but the page size bitmap and the in and out address sizes in
the config struct should be enough to restrict those.

What do you propose? Add another init function which hardcodes all
those or add some checks of allowed settings?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
