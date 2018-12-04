Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564C9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF782081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFokv5oQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqQqRW0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF782081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zwRHz+AZ+PxbDGatUR2nsaJfvOlg/LIMoWkonWkBG6E=; b=cFokv5oQdZ5egH
	8f3sXBnpj6+agocLRN8EMhRSQ6f+mbt8/kAAl4kP8D297B5ji0VJl4w/LLPThcBfOIoqKuYSW/s/u
	qBvd+4Lw17Dj1yk8TSM2TzTVqZTx/ZDhQv6dj4p4yBVX1o0z2P4FW6dHndrFrkHUM+8EvVli00MvV
	71RUg31b3xjYeh746XyuUyNErGGNNiEObY05DpnRu8e7KmbmkuXWuEkBsNXdR3wjCNIW37CZBmiRT
	ROrQQTz/qIsxxmCWuVcbW2rfjvObf1xSJme+kntM/WBHp1JqNoH+fZQGB2vn9Ek2w+f6RWEvYJsnC
	HWfyL0IO8a8blhIOnRSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHiR-000630-V6; Tue, 04 Dec 2018 20:54:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHiP-00062Q-Hj
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:54:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BA0E2081B;
 Tue,  4 Dec 2018 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543956875;
 bh=SrFbdyxYsYVyjA57irTwtVbQ8ELhrcpR5swTOS87yXQ=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=GqQqRW0TR/RZUMEKXPH8zmW5M46WjiCKCLAO/3fn66SG9MyNMhXV/QlFlKH0YCTkn
 VDzL0X4u4165uqj5ZHjxShYJUtU1ssdpeOc6c0ppg6OgVYLYHKOMo318OkYqF7MrL9
 qCK19HYYZEdHUaHJsKRBGtPKMurzJ70PTGbYUpqw=
MIME-Version: 1.0
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Joel Stanley <joel@jms.id.au>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CACPK8XcwMMoxG6vhDhUU8RYGABx7rtBoxJvp2yDhHeD-PemdqA@mail.gmail.com>
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcwMMoxG6vhDhUU8RYGABx7rtBoxJvp2yDhHeD-PemdqA@mail.gmail.com>
Message-ID: <154395687459.88331.13570416457347078441@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
Date: Tue, 04 Dec 2018 12:54:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_125445_600189_88B1BA76 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Michael Turquette <mturquette@baylibre.com>, chyishian.jiang@gmail.com,
 "# 3.4.x" <stable@vger.kernel.org>, linux-clk@vger.kernel.org,
 vijaykhemka@fb.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joel Stanley (2018-12-04 12:51:43)
> Hi Jae,
> 
> On Wed, 5 Dec 2018 at 05:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> >
> > These interfaces are used by host to talk to BMC, and the clock
> > source is from the host, usually from PCH. So this commit marks
> > the lclk as critical to make it able to be enabled. Also, it marks
> > espiclk too because eSPI is sharing the same interface with LPC.
> 
> While this is true on the platform you have in mind, on other
> platforms this is not the case. They do not use eSPI, and LCLK is
> enabled by the driver that is used to configure LPC
> (drivers/misc/aspeed-lpc-ctrl.c):
> 
>  lpc_ctrl: lpc-ctrl@0 {
>      compatible = "aspeed,ast2400-lpc-ctrl";
>      reg = <0x0 0x80>;
>      clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>  }
> 
> I wonder if we need a device tree binding to describe which clocks are critical.

A binding to describe critical clks has been rejected in the past. I
don't think we need to have it here either? More information on why
things are being marked critical will be helpful to see if we need to
re-open that discussion again.

> 
> Stephen, please don't merge this patch yet.
> 

Sure.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
