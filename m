Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9661C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:55:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FFA20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O0ttcNuw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXIGT37S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FFA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:To:References:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D6pmNl9RbLMU7Dphf4ZThZWWEvSkDrpz60I5jeBZoFk=; b=O0ttcNuwJfSAjD
	UsaVV4y7wFvbAyyM3oVoYRg9tc9wUAE2zsh2tLkEYf5qz9SiIeWgj0QZK7zQG/r2glyNLT9zLvA0p
	KAFmaUvOTTGWoAllyZSvlSZMAxR767MghhFiKZviFW1jyFNsm0xeP4M3WWv9b6jpM183KiYPtzwhr
	zpJNsyt1Nu3MYs8L57mi2HBuUgXU6M1w3IwNNKs/b0hh8gTlGDOxZK4iS1V8PFFnbJYDGjqvL27SU
	Ozm1U8GMkdcn8BPa78gnXkJnvIwmFQ5nLfP6avigqSA2KwG8JjATXmr/3tnAmirt3rETU2Kt5vaYN
	z95rnzIrzxKk8bhT9uXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjACS-0006SF-Eu; Mon, 14 Jan 2019 21:55:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjACO-0006Jj-52; Mon, 14 Jan 2019 21:55:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 266F520657;
 Mon, 14 Jan 2019 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547502911;
 bh=8xGbSw414rVINc77HwxSQPE88V4EOEo6pGoxgRcjJTQ=;
 h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
 b=EXIGT37SMG06yPPTlbsFMkfS0YiL6Fr1c2r5sztdU7rJMADYnYW2ofTbM97vZKRVM
 QLJcoJ5sBos87VqIlS8Hk6uB/UB13aW4QN9CQP8+2ynhjCoeUvODCpp+RWJ95lU8vm
 Lg6LAFIWFBtxW3VS4lXGXTjsGpHAfUSQv+rbVhhc=
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
User-Agent: alot/0.8
In-Reply-To: <20190114091850.GB13162@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
 <20190114091850.GB13162@Mani-XPS-13-9360>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <154750291027.169631.13825540584530234373@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 14 Jan 2019 13:55:10 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_135512_277218_52A2B615 
X-CRM114-Status: GOOD (  15.32  )
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

Quoting Manivannan Sadhasivam (2019-01-14 01:18:50)
> Hi Stephen,
> 
> On Fri, Jan 11, 2019 at 02:51:04PM -0800, Stephen Boyd wrote:
> > Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> > > Hello,
> > > 
> > > This patchset adds common clock support for Actions Semi S500 SoC of
> > > the Owl family SoCs. This series is based on the initial work done
> > > by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> > > 
> > > Since there isn't any update from him for long time, I took the liberty
> > > to modify his patches, address review comments and send to list for review.
> > > 
> > > This series has been tested on Allo Sparky SBC.
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > Edgar Bernardi Righi (1):
> > >   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> > > 
> > > Manivannan Sadhasivam (5):
> > >   clk: actions: Add configurable PLL delay
> > >   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
> > >   ARM: dts: Remove fake UART clock for S500 based SBCs
> > >   clk: actions: Add clock driver for S500 SoC
> > >   MAINTAINERS: Add linux-actions mailing list for Actions Semi
> > 
> > What's the merge strategy for these patches? Some are for clk, others
> > are for arm-soc, etc. I see a sandwich of patches too so it sounds like
> > I can't even take just the clk ones for fear of breaking something that
> > the dts bits in the middle clear out of the way.
> > 
> 
> As we did with previous patchsets, clk patches will go through your tree
> and I'll take the ARM/MAINTAINERS patches through Actions sub-tree. Let's
> target these for 5.1. Even if your patches reach first, there won't be
> any regression with existing DTS.
> 

Ok. I have just minor nits. Please resend and I will merge the clk
patches to clk tree.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
