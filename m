Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B7C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB49A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8GJH6Pg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYk8UEWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB49A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1MTlIbLgXBSejUbkNeXx4m/3VuwHNGwpM3Ql6aa+Zf0=; b=I8GJH6Pgk8Pwx6
	GXpW2k3vRmzcrYAArzTliWx9dRNBa9HY6d+4+/Ypb4kJm5EjJ+QiRPhhnr6K1W+asRc9AKd7nm1Q3
	RF80o8muataFINFkq8gY38HEOFc2+HxLVQ+IZy25CnuA/jIKiXTxOTm6bcCz94T0xxr1+LlOxwO+D
	fFUGXZ2fhQC3Ht1VMUEE3Mf9wqz13KC8jihZ7DebY/NXOWObmf2T2nS0cAZw3Fdx1pdpzrGGWfqJ7
	LjD9qteJFc58LIHONEUX+flMY0HgvSx805UL5xkRauCV4GFV5mOJnMYhUQM8Q1K03s9igf1dea2SZ
	8/iAogiBcwgIXS9H6M9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPqM-0003uZ-4a; Fri, 01 Feb 2019 03:50:18 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPqI-0003uE-58
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:50:15 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so2508903plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 19:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dnJny4uhEhe7lSqDgB/6BIGfujg3swil9O1FBbC8amE=;
 b=aYk8UEWosKj5RexzzsV1JoQ2eLErO2RoUMCNaU9nMDoFsqSJr29od+M7wK1JX371yt
 t5gtS4HOsOGoYxT+sXeluMnJsXiBsl5uPUFLz8YdYckc1mVcEG/dfxkQcNCpLidylmlq
 VFEaAJmepp1QqGoiQ3IWJkJLo8GMv1aPVe2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dnJny4uhEhe7lSqDgB/6BIGfujg3swil9O1FBbC8amE=;
 b=fMoNlRxGWQKpv1dsFLCFGMGG66LdF+HtALwKZOA7p66BiTEWkOwjEWU1xSlsaPX0EX
 gGemfblQmwWR6N54C8wEQlzyAUDuvwE1hb0R1BL61LfL6sBHgnjMIA3fLyBMARLgwagy
 N6Sq/SD+t5E05uI3x4T4YjAbjyC/ji5AMgOWM27sSlOmHdWcLnVDOcsJk+YrrP3Ae+Zr
 p5VFdKCxpbUYK1kBv5m1vonKrHeG6V2FjNb+hq7E9UMo9e7sLscO0BcMrv+kDw+Z80zM
 T4/5R3Im7RHcZvXmVgWbvfeKp1MVEAVXQMflDqBzQWAJ5kem0VnIQQ6j12E8nJEO3l7E
 q6kw==
X-Gm-Message-State: AJcUukeZOao8+VmBUyI/cQqtpTXqqMCJ+DOXfzyehWAIXNuUr3mTj6kM
 Rne1wKXPaScjiEBsVTjkLIQB
X-Google-Smtp-Source: ALg8bN5Y8lXv+UyUpoZ2zLoZOVfbtpxACC5HXSO7v1P4+AY3PfBcgydwM6PMd0p4rciJt8fwxwrjgQ==
X-Received: by 2002:a17:902:5601:: with SMTP id
 h1mr38567576pli.160.1548993013015; 
 Thu, 31 Jan 2019 19:50:13 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72ca:1df8:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id f64sm26113585pfh.0.2019.01.31.19.50.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 19:50:11 -0800 (PST)
Date: Fri, 1 Feb 2019 09:20:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190201035005.GA4283@Mani-XPS-13-9360>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_195014_212927_1E64AC61 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, darren.tsao@bitmain.com,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, haitao.suo@bitmain.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Sun, Jan 27, 2019 at 10:24:09AM +0100, Arnd Bergmann wrote:
> On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hello,
> >
> > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > processor subsystem, a single core RISC-V subsystem and a Tensor
> > Processor subsystem. This patchset adds support for only ARM Cortex
> > A53 Application processor subsystem with UART, which enables the board to
> > boot into initramfs with 2 CPUs.
> 
> Nice work! All patches in this series
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks. What is the merge strategy for this patchset? Shall I send a
Pull Request to arm@kernel.org with topic branches?

Regards,
Mani

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
