Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AFC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F29220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AaPijQKH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PV2WW8Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hCYrQKn1fhqCbjwX9WWTaprh0fjD0I+VgEdP5xBGpYE=; b=AaPijQKH650UFF
	skCX+514qXv1rrBa7y/APvtyL4o7NCif0rYRyqHveIjEIKbnRDPg6QLPQ9imQhv/Pq4+iBc6XOrbZ
	vxxqSU95w9lbqA3SDhv3yhfWBSsGvVOh8I9OgtvAy0m25+tI+btcF2orCdDLafqkrcEXoXMrcyyEK
	xZVmNoLphW5OuCpVqhuFHkGv7bMLSaGI95P4CZhLjkAqcRxjkpZalNdTiYh0BkW5YlxiNO1v4FHDX
	T4i0BYqyrbaC14twZ0mTfad0yilgjV5nATeMdt9dcHiNoC5DWz9oDcEHwtik+3QbFgAxsSS3s71Dm
	ilMq3pjPTKgJhxHcTuZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCrl-0003ij-9y; Wed, 12 Dec 2018 22:20:29 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoZ-0007Uj-OJ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:15 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so2385ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Fu+rlcVKij1eE1U6dtMPJ8S7J2eje5tMdNABI/Ki/SE=;
 b=PV2WW8OxjvSyx89dHcJKC0/+rAezcX28SrNzndPmQ0q4EFi7aHXOzvmRgJlokw3/wL
 sW0T0s5P1aLbbmQZ1dVDoaJpX70o56pGqKUNukAhlLUwmnqn62u9LmXjwHCHAbhk/4a+
 Lv2eOGJRQi57SuLQ79uwY1f3P1G8+fwYpUa0AKOU01fe4TTnqR3+KUbrJYj0TMHskyuB
 U+gtN7o3f+XZajs7K7c4XhMhYRbVr8djND5wf4PXOQoAfi8CQiKVII08TwWjkrx4c3e6
 7AmX2rDoLhvLlVYVvtbx8dZBxXiFDBwzECqppoNKOXhUNjg6+44NUY1vcPThN+UrWF4g
 DLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Fu+rlcVKij1eE1U6dtMPJ8S7J2eje5tMdNABI/Ki/SE=;
 b=FpZlqjC1vzyYs4j2cdgHlwKrNCc3w2CTXbLOae+CEWw2v5YY6v9ZLtmQlfMlSirXxX
 wdM4jYVZ5SmvYpoa7Dh6dyzIIOgBUj9lLZMliSoD6H9UC3PLU68iLzXgBfqbu33O3eyf
 R9vq9RfYJzIo6MIFXCThrPAg96qvJADgMck3v8umnmmiq92pcr2JSnoLWrEM0Yp0a2Aa
 Q/BHE2EHfjsV+udylBkfhu4jYPQ57owieM/J94Lzx9p1OzvM9Oh8UyZFX9Ihsk+aLHlW
 uha4vRyfy8+xk56RU7CqeVhqAviwM8cL0ntCo0H7AoRzhAF2CWN1I5mMBHvlU200tpKi
 D81g==
X-Gm-Message-State: AA+aEWbZbp+5s5BWKieizU4vKKDj8BXi8s2rz7YE136YB+ChyjY9q2P9
 hl7EsTzpQj2FK7+ZcC2xyiAwAg==
X-Google-Smtp-Source: AFSGD/VBu2gIgFeI47xRpsJHXPx03lssDwEw3XewMqTeYCVwsFLdUJIPxAFY0JNjjRXiy37FTO9VBQ==
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr12839540lja.19.1544653022335; 
 Wed, 12 Dec 2018 14:17:02 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d190sm6701lfe.9.2018.12.12.14.17.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:01 -0800 (PST)
Date: Wed, 12 Dec 2018 13:57:41 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181212215741.uvkbvf5cvcvvod42@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
 <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
 <20181211102856.GI14426@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211102856.GI14426@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141711_899551_1B4EE496 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, arm-soc <arm@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 11:28:56AM +0100, Thierry Reding wrote:
> On Tue, Dec 11, 2018 at 11:08:53AM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > >
> > > On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > > > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
> > > > The function tegra114_gic_cpu_pm_registration() references
> > > > the (unknown reference) __initconst (unknown).
> > > > This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> > > > annotation or the annotation of (unknown) is wrong.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/arm/mach-tegra/irq.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > I'm not seeing these. Do I need to enable any special options to trigger
> > > these? Or are these just so new that I haven't run into them yet?
> > 
> > My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
> > option that is now available in linux-next.
> 
> Okay, that would explain. It's not set in my configurations currently.
> 
> Do you want to apply this to ARM-SoC directly with my Acked-by, or
> should I queue it up for v4.22?

I'm picking up a few others of these, so I'll include it in that batch.

Applied to arm-soc next/soc.


Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
