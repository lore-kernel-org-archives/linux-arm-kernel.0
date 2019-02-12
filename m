Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BFC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5544120449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SKYMircN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5544120449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rtspua2cBo5Yf7YHyAtfoQcyhM05gvkCz6qcq6SiPUQ=; b=SKYMircNdWz7Am
	/99uLgW0FEW9sBinOnyeAocW8q3u2wU7ZLyr9KD0qh38DadzGlY6Me/5BcfiIw6/X+rGdY+WnRl3J
	TFpdWCaqm7epztPty8DST4DK0X4PYCcMeiyKmWnSetRLHCrwiH/zoNKX0HGFUuj/RBFjhIFV3v+F6
	4wVWj7W5n9JtrCUyCe4r0UJU5LazgQm+9eU2XVtu2QsrFex6n+QhlZXim0RAIloMUOMt1mNFfzvmM
	jA5HstTqn1ARjpTQXdNZbbkZeDyuyLeFgcrPmoVTz0vKcoKBP3VYts8ZHNCOwSQZwYuJ6LBnsHnmF
	prHxDTX7raBhAM6pux2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVzr-00050I-9b; Tue, 12 Feb 2019 11:13:03 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVzn-0004xD-GR; Tue, 12 Feb 2019 11:13:00 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gtVzl-0001Au-HM; Tue, 12 Feb 2019 12:12:57 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Date: Tue, 12 Feb 2019 12:12:57 +0100
Message-ID: <2275914.n7pQDzs7mT@diego>
In-Reply-To: <c4ce7f7a-c791-ae0a-ad3d-02b2efa41709@katsuster.net>
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
 <1970132.3b67tCGWFf@phil>
 <c4ce7f7a-c791-ae0a-ad3d-02b2efa41709@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_031259_691031_2365A493 
X-CRM114-Status: GOOD (  15.69  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Am Montag, 4. Februar 2019, 13:59:37 CET schrieb Katsuhiro Suzuki:
> On 2019/02/03 18:06, Heiko Stuebner wrote:
> > Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
> >> This patch adds HDMI sound (I2S0) node and remove dma properties
> >> from UART2 node for rock64.
> >> 
> >> The DMAC of rk3328 can use 8 channels at same time. Currently, total
> >> 
> >> 7 channels are used as follows:
> >>    - I2S1  2ch
> >>    - UART2 2ch
> >>    - SPDIF 1ch
> >>    - SPI0  2ch
> >> 
> >> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
> >> 
> >> UART2 can work without DMA resources, so this patch removes dma
> >> allocation for UART2 and reuses it to I2S0.
> > 
> > I don't follow that description. How can i2s0 re-use the uart2 dma
> > channels? Looking at the dma table in the TRM, uart2 has channels 6+7
> > while i2s0 uses channels 11+12. They should just run concurrently?
> 
> Sorry for confusing... 6 or 7 is as ID number of slave DMA channel.
> TRM calls it 'Req number'. Req number 6+7 and 11+12 can work
> concurrently but TRM says DMAC can transfer 8 DMA channels at same
> time. So all 16 Req numbers cannot activate at same time. It should
> be keep less or equal than 8 numbers.

But that "shortcoming" of having more requests than channels is not
something specific to the pl330, instead most dma controllers have that
"problem", which seems to get solved by the virt-dma mechanism of
dmaengine - which pl330 doesn't use so far. (but see pl080 for example)

The devicetree only describes the hardware and is never meant as a
configuration space for kernel-code shortcomings.


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
