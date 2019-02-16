Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:15:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA7321917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HjKLG9H6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCB/zVzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA7321917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q52+bGCGYO3PCUHj9w8Ml3Yug4jiSLD/o1n24PRrV2M=; b=HjKLG9H6m5Qzi+
	Mlx5pK1+xg1KZb8F/3nDukxcMnh1XgRN6oB82gFjFm9rJuyy2dlU5AQ1VHHCz+9CoBG01mywVx2Ny
	ChOILJfSsiVlAtjSS9Fud5w88CDe0FsVgT7imyFHmb69fP/elfIrbDxwOyZv3wWyrQdstEB539TSL
	aj492W8eEyWbAtZd/fhLZQAzwiP2LoO5ixQzvqbGHdbOduaRmOeWtXDS8kNRUyem27P/IIO3IU63G
	dlMrfJ9CIqGA907NLaM9WyXUWLdwQB3CUv+XYmmmeQ9sPinbVYR3LH+Caf8GG7gRDGdAXs5m/RKyg
	fvEaAb52KA8bSmVHNAgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurOM-0006Xm-Bn; Sat, 16 Feb 2019 04:15:54 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurOJ-0006X0-7T
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:15:52 +0000
Received: by mail-pf1-x443.google.com with SMTP id q17so5803591pfh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 20:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7zOY7rJcyPkYN02Whkr/mHU6wjS0SWfiF1kM+cR67EI=;
 b=PCB/zVzFFC4VyesOFx7iBqctUvJ+ATC1wmof6jXHXtfOvtcQhapyvy2CMpc53gay5A
 N4kFEfufpDM1jfxCITojOPRLnbS+TMvu4bQxyKubXSOWLyKdULMR0sDCAren53U6QEAx
 re+yL4T7HgMdtpT0GZ6ph0YhQXOA0qYVIjo2sqdRhFwaG2WcfvdcyxYn0Hz//rOQ8BE1
 yCsiZ5OeiPiF/na3uRGwNbtbBsQhGaz8E0ib+1IPo2cn1uB+R9QTNv3alywORlIaR0h/
 iSDuV4CBq0XVjwyTE044vFYHsWwpoTo+1Tw79ICMxQOFXtOS7RZhtA08nGS3/FEqUSuZ
 nMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7zOY7rJcyPkYN02Whkr/mHU6wjS0SWfiF1kM+cR67EI=;
 b=uoMzOx3ILHbN26sHyD5N6GLAJuZWE0CamFo8EsXujzwS6LwxLKE8zfW82H0niChi9h
 s1b3TYgk7GXrBvEgmZExBDQgub7ru9gh07TnBy8Om9s7YC1ZnuWw31oLy6FmCS63acp3
 HntTfhoT7mApRCplJ+EaH5eAHHfNYzoIr4KQAN52p2MVl8lC5gq8Y2T+l8xeEE1Bo7aw
 g9vBuCpVauMIgZRtBkeAaEtzWErOGBstwalG4XUJS6s8/Np939ahmtPKBCervHGlKW0E
 3H4dgMH4PSCpRckhO8u8d4xOF7IuQGtLFD82N6PvqGoWRbuzRXg8hc3b5W/ExzqbdMfM
 YOUQ==
X-Gm-Message-State: AHQUAuaWgJyRZYREeZNkT8aCyVISOkEHK2SG7U7nbHl002B0TrjRjsNd
 slexpm08ibmV/OEhqDsT6Hg8
X-Google-Smtp-Source: AHgI3IYtahhOfevSDnucFXm0FKCMF6V5aYRvcR3TbNLUwibqRjkfeZDvRWPSVJgpX9yWoZcyoVpq4A==
X-Received: by 2002:a62:444b:: with SMTP id r72mr13316658pfa.184.1550290550447; 
 Fri, 15 Feb 2019 20:15:50 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e85b:d8eb:c013:fd6d:7b1d])
 by smtp.gmail.com with ESMTPSA id n75sm2889719pfb.39.2019.02.15.20.15.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 20:15:49 -0800 (PST)
Date: Sat, 16 Feb 2019 09:45:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org
Subject: Re: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Message-ID: <20190216041541.GB3054@Mani-XPS-13-9360>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
 <20190201035343.GB4283@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201035343.GB4283@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_201551_329032_30600976 
X-CRM114-Status: GOOD (  20.27  )
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
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, robh+dt@kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On Fri, Feb 01, 2019 at 09:23:43AM +0530, Manivannan Sadhasivam wrote:
> Hi Stephen,
> 
> On Tue, Jan 15, 2019 at 09:03:34AM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds common clock support for Actions Semi S500 SoC of
> > the Owl family SoCs. This series is based on the initial work done
> > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > 
> > Since there isn't any update from him for long time, I took the liberty
> > to modify his patches, address review comments and send to list for review.
> > 
> > This series has been tested on Allo Sparky SBC.
> > 
> 
> Can you please merge the clk patches so that I can take the DT bits through
> Actions sub-tree?
> 

Any update on this patchset?

Thanks,
Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > Changes in v2:
> > 
> > * Incorporated review comments from Stephen for driver cleanup.
> > 
> > Edgar Bernardi Righi (1):
> >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > 
> > Manivannan Sadhasivam (5):
> >   clk: actions: Add configurable PLL delay
> >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> >   ARM: dts: Remove fake UART clock for S500 based SBCs
> >   clk: actions: Add clock driver for S500 SoC
> >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> > 
> >  .../bindings/clock/actions,owl-cmu.txt        |   7 +-
> >  MAINTAINERS                                   |   1 +
> >  arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
> >  .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
> >  arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
> >  arch/arm/boot/dts/owl-s500.dtsi               |  22 +
> >  drivers/clk/actions/Kconfig                   |   5 +
> >  drivers/clk/actions/Makefile                  |   1 +
> >  drivers/clk/actions/owl-pll.c                 |   2 +-
> >  drivers/clk/actions/owl-pll.h                 |  30 +-
> >  drivers/clk/actions/owl-s500.c                | 525 ++++++++++++++++++
> >  include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
> >  12 files changed, 661 insertions(+), 31 deletions(-)
> >  create mode 100644 drivers/clk/actions/owl-s500.c
> >  create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
> > 
> > -- 
> > 2.17.1
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
