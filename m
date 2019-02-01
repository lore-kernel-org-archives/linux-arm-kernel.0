Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB14C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E3920869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lbi19Buz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn/N2ppw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E3920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nX9ATyblfcBq/NH6pH65DVH+wqs1nmRh7jzrSmgTxV0=; b=lbi19BuzWdPnnZ
	5PGcvO56QHKzmv+YHB5GTiraHFZjGp38axxJiG07FDj33edpLkTz8zP4bcucLMGk30Y59RiwdmyrO
	GZL9XBlbxF2XyVMbnGefXywxQwclMMNA0VAZy9jymqea++wmYpPwqWrYGFW3HUy2m9PBUkdh7m01p
	L0S+4U536EanQi722MzPCC6w9OhSm4aeBbLw3Haz2STuIdjZajtBt55wHJW81BTw3KKv5Xaw9Hve1
	PlHpqBxCQwwTymyjBMb/1teQ9TsJLnnq9XW3bD/0WN3VFKdR+QHB54f8LwWn3kAdkm/kt5NC5+qPN
	cFPlhF/Nm23MCkeR0anA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPtq-000533-4w; Fri, 01 Feb 2019 03:53:54 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPtn-00051n-DA
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:53:52 +0000
Received: by mail-pg1-x542.google.com with SMTP id v28so2296348pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S9LasyzrQ0TxSPombwL6hgsxriPftAjP7h1Vz7GenYM=;
 b=Hn/N2ppwwQ9r0l2tXCeKWhTKGI77LrgEVTlEGUI91oBRy0wBRMGAgXSYT7wahDcvGm
 hgR4CvBnKSBrgNvKXhfHzBhwCImJhpkHmUTQkg602tKy0B75JAyRPSNFi5JQ8UJpr9yk
 QluU6cjej5yx16EQU3p5+c33afhcgtq6FUHD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=S9LasyzrQ0TxSPombwL6hgsxriPftAjP7h1Vz7GenYM=;
 b=bpaUATjwjkWV1Iveuh5ucOhNNRCmL5dwcbXPFx3af+OTZX98kDL3E9mzjly2QcTU5y
 egmasqwRJsAiHVwWj+JpN5ZfwnnIyeu69/6Ko7rXbMrXha/ih5ouYTJRKqbE45XyJWz5
 L1r/gJ8tDXq38x3NQBVfz9LHFb9PJtMfW1aKt3rongOn6H1kvg7p3BcZv7sT5Ps62myG
 rG8vY/DKksd7Y/JgCjgWhI1MC+7sOkTxot92fzvGY7ka4LzXxLtafehno6FioKBdUrY9
 dK7zqgpNf2+lJOBqyXZoeY2Sb7nmoT6Pb2GO7c4M8oPGycz519ke3kGxxexB470w3Evr
 psVA==
X-Gm-Message-State: AHQUAubDxWjB9sGagk6TxIJJkh0UuIUR0kl5aNWovcUZkbUbgNyavRDd
 8mYt47Z28viaEruafgf3SbG/
X-Google-Smtp-Source: AHgI3IaYzFupx8Rp55r9QwMjklghWV/j0AWYVD5TpYpBPjRF1AuBWLAE4fI27w9hKUyU1gQvJrqZ3w==
X-Received: by 2002:a63:554b:: with SMTP id f11mr716292pgm.37.1548993230864;
 Thu, 31 Jan 2019 19:53:50 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72ca:1df8:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id g26sm7448811pfh.61.2019.01.31.19.53.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 19:53:50 -0800 (PST)
Date: Fri, 1 Feb 2019 09:23:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <20190201035343.GB4283@Mani-XPS-13-9360>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_195351_449621_03BE4059 
X-CRM114-Status: GOOD (  17.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Tue, Jan 15, 2019 at 09:03:34AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds common clock support for Actions Semi S500 SoC of
> the Owl family SoCs. This series is based on the initial work done
> by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> 
> Since there isn't any update from him for long time, I took the liberty
> to modify his patches, address review comments and send to list for review.
> 
> This series has been tested on Allo Sparky SBC.
> 

Can you please merge the clk patches so that I can take the DT bits through
Actions sub-tree?

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v2:
> 
> * Incorporated review comments from Stephen for driver cleanup.
> 
> Edgar Bernardi Righi (1):
>   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> 
> Manivannan Sadhasivam (5):
>   clk: actions: Add configurable PLL delay
>   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
>   ARM: dts: Remove fake UART clock for S500 based SBCs
>   clk: actions: Add clock driver for S500 SoC
>   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> 
>  .../bindings/clock/actions,owl-cmu.txt        |   7 +-
>  MAINTAINERS                                   |   1 +
>  arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
>  .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
>  arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
>  arch/arm/boot/dts/owl-s500.dtsi               |  22 +
>  drivers/clk/actions/Kconfig                   |   5 +
>  drivers/clk/actions/Makefile                  |   1 +
>  drivers/clk/actions/owl-pll.c                 |   2 +-
>  drivers/clk/actions/owl-pll.h                 |  30 +-
>  drivers/clk/actions/owl-s500.c                | 525 ++++++++++++++++++
>  include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
>  12 files changed, 661 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/clk/actions/owl-s500.c
>  create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
