Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5F6218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gw/i6wmW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/q7rr04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5F6218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yKGdZKyF8zUBAbZfPdItPzYpz4XrXUDdpkvDQ4S2nsY=; b=Gw/i6wmWSLtQ0c
	q2q7Htq7xhCUK89rG12bNGqu0gkkhGenPcl5RpyRPn7/1EiPfCAxj4CrMjggxo3UN3S5AmcaOkiqO
	FNEdStdsVpOBjpFqv9I52YqfLphItKSGpooBKziVG98vl//qXgeKtIkGGxRK8cqLKRMzk0KjSseEx
	GlzrBGDcUwwkICwPypKHYxjX+hNe3eYwwi7ms2UWRFkn56B9tjyJaACGL6zZRF744E8dw7OYUOdJI
	2B3HNMg5eAVa/Hl6xR4TuUBXd7imoN/ILEVBbs4EZvRIiLQ/ubty9yxhzQ9Tn8KIbOhTKjuz3u/ww
	xfoeTIhp8m68CqgnitGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynOl-0007Rv-24; Wed, 27 Feb 2019 00:48:35 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynOh-0007Rc-Qj
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:48:33 +0000
Received: by mail-pg1-x543.google.com with SMTP id r124so7046423pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ft0FA+4NTHqTeSvcJWsn7L3fQEbgpl8zmIuDm5nISvw=;
 b=r/q7rr04nrSR5NmbOcVfHrtA6shL7vv72GPVHN8eGR09TYzKd/w6vlOCZjuIMtWc/E
 uTdcHgHEZ4FBV8+y1MkjP3UTVqDeizQX9FgzWh4TJEvGRI9IhBOBJeK+vdQgyw1QSACZ
 562WWN+9jUJWfocIxwTkgIk8iVL5RUTLgJcxjZhvm15rJN/iEQuNgRoUAdr7YVLAG2Rg
 FIwjysDadzZ04TQCBvNbqy9Uq/5wLjs16snENMaqmq7k5hhIv1SwOlTUaOkhGyAl0d8S
 WVvLOVDpgGXGmrDomZxv419gz0QVUpllo3rkH2ckGE6+jYeoAjmekpSMn7zyzZH1otxB
 aTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ft0FA+4NTHqTeSvcJWsn7L3fQEbgpl8zmIuDm5nISvw=;
 b=WktAcBDKBGPv4ljGxd5o5c4WWaFdp9RWcSeIgqoES6osIhNNTF6lrXLo+R3iDJHBM1
 ihFMXF7F9xDFLcI7DDuddwhGMtkHJctrnP7Mee2XesZZx8aNUkv1czFfjft19W4CSHzq
 mdRpCZ2Ejrhdlz6ZEnvqrKaLWDouYxIvYtu6CTQEeBQG16HyzzDxTsZiz4kry73FBUdj
 TphMh+EYeTmISGFOMz22vUiXQP/9R7hCNGZrm/bliY+9rpsi+dt7CUWf2nKnZE1Z+cu0
 Tgvg8S5BRoI2TvYjGdKmaMYUK8Fv4/K5lXFQLrtaWEYqIQKcOgTN6YKoLguosA31MHv8
 LU+w==
X-Gm-Message-State: AHQUAuYx+cZLZX7fHFwHzvZ6kqMhqJcpLvw0UMcdAXhHZksPRghm3HZy
 LkayF+Yt8/FDrruxImZpqVc=
X-Google-Smtp-Source: AHgI3IYS8Vl3IqgWGYpSkAfRwYjjZlQXh8dyNZe0ySpSzlguvDRmvyztcXp8Zq2dyBAcojrcHSp1VA==
X-Received: by 2002:a63:5318:: with SMTP id h24mr275028pgb.76.1551228510466;
 Tue, 26 Feb 2019 16:48:30 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id s10sm22181352pfi.117.2019.02.26.16.48.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 16:48:30 -0800 (PST)
Date: Tue, 26 Feb 2019 16:48:25 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Message-ID: <20190227004825.GA29112@Asurada-Nvidia.nvidia.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
 <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_164831_892042_2345C756 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: tony@atomide.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, sre@kernel.org,
 tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
 linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 11:35:44PM +0000, Robin Murphy wrote:
> On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> > This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> > 
> > The original change breaks omap dss:
> >      omapdss_dispc 58001000.dispc:
> >          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> > 
> > Let's revert it first and then find a safer solution instead.
> 
> Ah, I think I see the problem - once arch/arm's __dma_alloc() has decided to
> use CMA (because dev_get_cma_area(dev) returns the global area), it then
> won't fall back to trying a regular page allocation if
> dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm trying
> to allocate a single-page buffer in blockable context with a CMA-enabled
> config is just going to fail. Similarly, it looks like none of the
> DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this change either
> (amd_iommu appears technically affected, but is already using
> dma_alloc_from_contiguous() backwards compared to everyone else, hmm).

Yea, I searched the tree and got the same results.

> I guess the question is whether to add alloc_page()/free_page() fallbacks to
> those call sites, or stuff them directly into the CMA helpers here.

Probably would be safer/easier to do the later one I feel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
