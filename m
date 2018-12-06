Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317DE20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ayTnDzQJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu0YVRdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317DE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nSvzYCw7aIqNI60tHWPBgDGSqqsZxXIRhTVppt8BMew=; b=ayTnDzQJElqCYV
	8p+AFhKvy1zGqKSuJPvErbtMQn16OXj2zmrVucIQxf3Zj8ph0Dl8lOX4x7WsKRvLJsxYZrCKrOir2
	sZbU0lrEjqCNN7yjrfk0cKJH1kmFCeRU12KQuigoMYJb/mILI+H8xRXx8mbwiuG0uo3xOzgnQRzmc
	Pf8dEbiGXYRHvjanZqUrYTOx74SYcnLQFOVbt+FaMdLwcEvVK6keNTJgjtrOTcrnaYItlxMP0qVHf
	Bo3xH9DyyhGbhNG649bRXmnPnyth2LrZhawhFc7FapRTe590LxR14E78ady7IWBPNpBqWK5qs9tgm
	V+cceGawd28hQzPJrRNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpup-0000A5-A6; Thu, 06 Dec 2018 09:25:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpui-000075-Px
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:25:48 +0000
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E07E214E0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544088334;
 bh=yquEor6AGUb2p6/EUGQqZ2H6Yefy6nm54eUNuIcLIIs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Cu0YVRdJzQkS8WiMUarKxuv7Fp/YlWIYIJ5STrBneZorU02jd3FYwbolkrsWPemzi
 nabEVtvkLmlJolSFOpQtndcPoi4r3eeN5jGQU+Xlv76LVejAq3pJ/cd0siiiOzzpe/
 yZ4OYxAYWZ3cmdCprl+hPd74QsuSFZLVeSjSrB1c=
Received: by mail-lj1-f174.google.com with SMTP id x85-v6so21024027ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:25:33 -0800 (PST)
X-Gm-Message-State: AA+aEWbaR9FOx1294KWWUjWxBVjPHEcLravpX+inZlG8PjyQem6UCDrw
 fsYEpkCkiGQKwVXiaXGvrTR+bq/dZTSw+09O5Us=
X-Google-Smtp-Source: AFSGD/UJermQifqMj7VVuugimzzXNWBaWyDncc4zMM5FNRdd62S1tJxt103d9JZBn4tiCRuMMVvTlQa/StV+8km8AFQ=
X-Received: by 2002:a2e:c41:: with SMTP id o1-v6mr2042505ljd.152.1544088332104; 
 Thu, 06 Dec 2018 01:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20181206013054.GI6707@atomide.com>
In-Reply-To: <20181206013054.GI6707@atomide.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 10:25:20 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Message-ID: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Subject: Re: dmapool regression in next
To: tony@atomide.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_012544_858063_0C89886A 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 john.garry@huawei.com, linux@armlinux.org.uk, hch@lst.de,
 andy.shevchenko@gmail.com, akpm@linux-foundation.org,
 linux-omap@vger.kernel.org, tonyb@cybernetics.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
> on at least omap4 pandaboard, see below.
>
> Any ideas what might be going wrong?
>
> Regards,
>
> Tony
>
> 8< ---------------------
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
> ...

I see it as well on all my Exynos boards, since yesterday's next. In
my case it is the USB EHCI driver:
exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
vaddr)/0xb8844180
Full log here:
https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
