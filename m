Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4BD20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UsBPzKv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4BD20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vJLVXi7dZFCN3Oem3vpqM9iVFh/PNGjeKafdxTmYTSs=; b=UsBPzKv7u8+ONL
	EuzUQR/izEtzuf26wciI0iIdzno2hjjr0SRFzhrUNTCFh/UOswi0l8gylV0GMvz0sfvZ943zFMeEH
	5NkskR8EP5paSMGtabKFYVpEEHBvuWhjwTUQ2ISZMU4mHVjwCGXE2QSXNTtVYjI+zPpoCHaqJRzqh
	J2VGMu4YIFKk3SNuAo+q6xoZMpc8DOEFwopp3tZbpWjCo6ks/vsvQJWoUiixX/AOKs85MjwMLkHwj
	Hcd7N90eSYWeDIga+585NTb6kzcRx2i1mJ1dukD9OnZWf063ugHl/5B2lPH0yivuWKJFX+1V1ZCpN
	0fAe3Zff2imZNYx6Xrfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWH7l-00011S-Ec; Mon, 10 Dec 2018 08:41:09 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWH7i-0000er-2B
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:41:07 +0000
Received: by mail-vs1-f68.google.com with SMTP id h78so6132561vsi.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1pmH2L5xlbB+FG4kPlZh7uoOejgh9/H85i5Bt9CB3jY=;
 b=lmXufCPNiqRUJKcN4KnOh9tdnUugs2QVfgYhv8eLmfLpJP5Lz4OMYuiuTtA7ML/p3z
 eP77dxoX6eYSqvJgF/lnBJC0kgGxGE1LGANBLgwVKk5nAIrAhthrztynsDYe5w2u44m1
 dIx27vBfWJknkbDqz/Tbm+iK8Mzr8nSYB7Cb8ZvV3/Cp9ojC8vx1Gv7jpJuR+NYWzqbh
 DfOcjaqFuxj7+pEMPoNpS6hsycW/za+HDKqAMxqVQlPQceUmsPNtVfpKo3cvN/gM9uY6
 L4PDQ+nkzVef5g+wzdM5pjrTRw1fop2/kidTwVicaiO4/rhWUFSDB2KA69n+dZ7P6k83
 P72w==
X-Gm-Message-State: AA+aEWZnK8VguU6Y4e+Kx/L4LngvUKlN1OOoJpIrEszR/OinQp99V9En
 Y11i7HcB82yHr/x0LUuymBYOCf8bsyWP1ePgQ80=
X-Google-Smtp-Source: AFSGD/XdbUBb1TQATjjBxG6K3LMimGNxGZM0CA8E1KvI8AJkGBw+33+m41UAtp+N7D1a87hvm79MExdfpnPvNnZA/+Q=
X-Received: by 2002:a67:f43:: with SMTP id 64mr4978141vsp.166.1544431254064;
 Mon, 10 Dec 2018 00:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20181015105517.28032-1-wsa+renesas@sang-engineering.com>
 <20181209215154.GB5856@kunai>
In-Reply-To: <20181209215154.GB5856@kunai>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Dec 2018 09:40:41 +0100
Message-ID: <CAMuHMdVpRYSCyho4n2R8p2s4WV1bXv8MM4VbMA9NVJjwT_rHzg@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
To: Wolfram Sang <wsa@the-dreams.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_004106_122309_3605F508 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

On Sun, Dec 9, 2018 at 10:51 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Oct 15, 2018 at 12:55:17PM +0200, Wolfram Sang wrote:
> > Update the comment because we don't set the pointer to NULL anymore.
> > Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
> >
> > Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Russell, is this patch in your realm? If not, whom should I contact?

Probably you should contact Russell's patch system, instead of Russell's
human email instance, cfr. Documentation/arm/README

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
