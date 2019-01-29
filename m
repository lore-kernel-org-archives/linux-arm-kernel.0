Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EBEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C8421848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MRogUSt2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9qXvm99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C8421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xftauo12BdhMuvXdRh2snBz2MPc8brScHmmfD1rQ18M=; b=MRogUSt2fJHc8j
	Kz+9GiBIPVrX1dyF8tIoNrXEtUnxWKDmRHuQotDoa3H3KHHjFHiV0WOLdfCJjOGlXVguzFatjWivN
	6LoaFjsnMBiPCsxdxz4s/5GkhBWus29+AGtOF12PD7Clxc6lWRbGCBbZ8wU+d16AE/08b6XTF7+XF
	SqLzhM9aQTm1PIwTJ59Q9xL/FrEZV41tb+S8ZKJSJcj0EEBLBhBiFvDHYiCj+Npq3NzjqLSYXHe+W
	JB1qzwJVWreY+d3byzh66kAAl6aJnOus3+0VgV+9qsZ2RZDgO+H4vE+hvX7O7BZzO+4Sj3k1+WM3c
	Ihg/lq29t3RDDBomHKwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXp3-0005Tq-ET; Tue, 29 Jan 2019 18:09:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXoy-0005Si-64; Tue, 29 Jan 2019 18:09:17 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C00DC2084A;
 Tue, 29 Jan 2019 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548785355;
 bh=VkDWohIUenCSmi9fACRiHhRgqBorJR6nclSPdr+2RTs=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=f9qXvm99ZMZhTWgYI1q+gleMChm6HixUeTL9EhMS7/Ws+3CqA28jh6ILM43noIppx
 VFIXZ1qDRS5A8Xmdux7V/zADLocuzbQcRjGuVSbZiGcH54yidfAdTD8R+pzpyRN4d1
 nlmX2oStBM3gx99tICOIhZHDiYUDIoap8uWseBmM=
MIME-Version: 1.0
Subject: Re: [PATCH 14/14] clk: meson: rework and clean drivers dependencies
References: <20190128180430.28689-1-jbrunet@baylibre.com>
 <20190128180430.28689-15-jbrunet@baylibre.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-15-jbrunet@baylibre.com>
Message-ID: <154878535502.136743.7217447718652873910@swboyd.mtv.corp.google.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 29 Jan 2019 10:09:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100916_256874_68894587 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jerome Brunet (2019-01-28 10:04:30)
> Initially, the meson clock directory only hosted 2 controllers drivers,
> for meson8 and gxbb. At the time, both used the same set of clock drivers
> so managing the dependencies was not a big concern.
> 
> Since this ancient time, entropy did its job, controllers with different
> requirement and specific clock drivers have been added. Unfortunately, we
> did not do a great job at managing the dependencies between the
> controllers and the different clock drivers. Some drivers, such as
> clk-phase or vid-pll-div, are compiled even if they are useless on the
> target (meson8). As we are adding new controllers, we need to be able to
> pick a driver w/o pulling the whole thing.
> 
> The patch aims to clean things up by:
> * providing a dedicated CONFIG_ for each clock drivers
> * allowing clock drivers to be compiled as a modules, if possible
> * stating explicitly which drivers are required by each controller.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sounds good to me.

> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 2b9490dd9878..8baec10a49a1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -2,12 +2,17 @@
>  # Makefile for Meson specific clk
>  #
>  

Add a comment here that these are all the clk library parts or something
like that?

> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) += sclk-div.o
> -obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
> +obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
> +obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
> +obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
> +obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
> +obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
> +obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
> +

And maybe add a comment here indicating that SoC drivers go below?

>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> -obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o gxbb-aoclk.o
> -obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o axg-aoclk.o
> -obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     += axg-audio.o
> -obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
> +obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o

And sort them by config name alphanumerically?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
