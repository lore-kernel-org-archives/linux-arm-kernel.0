Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383C2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E7C222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fXBZHtmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E7C222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kxg8rB5xObwD7jt6VfcvR+UaCYkb3gAk6JK+bvUHdb4=; b=fXBZHtmX/IbJkS
	3J4dWDKDpdDSQ3gBjMPmc3Y7OI4YSUws4n5fAfVsdW6IDVYsgud6rZXAqejQhiS8NzBB5GkhdTCLo
	fnPUPw01sKky8QEuQ9Plnikafioi47ekJh2jo9dA4XvO+oiKA1TzVp/ZffUZZHI8utfzY9bBgZ+2n
	Utv5ibyKuRn9w+y+m/vxw41AqE757neY5bG9Ghe0kuvb5T5Z83UfeQwFPIta8Lf7vA2wR2qEvMrvo
	WxejA0UEWxMNr3d5T4ZSbDDgPMXiERK1OvG9aqDS2q92N0zt1X9xkV6lpyaBj5tNfYdMim8ia5SnA
	JixYCItmsuA4EaZhbRrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBzc-0007ob-BR; Thu, 14 Feb 2019 08:03:36 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guBzG-0007TS-Rg
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:03:19 +0000
Received: by mail-ua1-f68.google.com with SMTP id d2so1734252ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NF+3L53BNvZkogBeIQvWy8YJNldDSZkGj555Q/LewKU=;
 b=aLFtgJpUJse3yftfDYjFLfgUHnhUu0uxVhZYeLdcQqypQKdmB5DcfB1c/49mnNal7P
 8ypCJQloh62QcQO4oyU73nQrAM/jiL8SFCIFpdlDCFuvXg/gYq3Q5FQC91DCmWnA1c0+
 ybdX3V9HiCqg0F8ZamWMjqac3HK5poTvj/YNtk6gjV5aLIUmw9d7lflcipqb0yRfC3nt
 88mpKjAsu+DR+Do8LzJqIyh8OfW11jDqbeg9l1+qRN/dJ5GsViafEqkROpg5sy7LKjAO
 hMPVWKcsqnZBUrTdfK430xtbPruT4q1vu68w1VVdvJAAn2IoW3xBOq4S76wGhhWg8+Mp
 wGqg==
X-Gm-Message-State: AHQUAua9siojBacd6VUDJMMzWVN4jmmeEKkl6fU+hEJJehINh3ZsLrhj
 mcUk0/m+D7JkNFtCTvgoAECeiPZHm6qM6Y3MJRU=
X-Google-Smtp-Source: AHgI3IYuwLbFH4xBoLJND8KWDgiGKKBj02ToPLGU+20FyrmwcFmKg50xLpk/vXNoc6k9cTcyD9Hb8gWxJbpWMgOdiZA=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr1272618uaa.75.1550131393111; 
 Thu, 14 Feb 2019 00:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de>
In-Reply-To: <20190213174621.29297-8-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 09:03:01 +0100
Message-ID: <CAMuHMdX0oJeGO90E9O=vVoDjahS5M8Rku+JGD1Tt+t-oKHnPJQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_000315_214231_16C15A25 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@pku.edu.cn>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
> For most architectures free_initrd_mem just expands to the same
> free_reserved_area call.  Provide that as a generic implementation
> marked __weak.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/mm/init.c       | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
