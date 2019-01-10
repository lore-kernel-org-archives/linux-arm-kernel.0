Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EEE214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAkrYST3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EEE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LAQ8AmdAHh/M6a5jrVMP/E2H+E12WZ/rJ6daEie77b0=; b=rAkrYST3OURoYk
	4Njys0h12vCWtU2H2dAdHfNzfd65MnFrNyy4nKeN37oIWbH66bDhN01ZiSnkJ0iuvv5PKW8t3aSQv
	Hd3NStz+2KxCNXKNMYxFkquy6W2M/PFUz1lfWlyuoYfn8hg+gkGZbKCjk2Df7VT6xtKnnQxslMbgq
	y29xmTyyBEtYVYlnYGEn7TQ6yClaUihBKJP1+wAOCPPlXj4d0XSZk9FCduBVchT80yGi0sXKnSojs
	qHcP9rPkm5IbnFTnsitI8/kZGFboQSb0arkS4gA6QFY//wNOZsLlTP2jmdJJ26azlcLihKKJgV5KW
	8H9J3mOQPQegwmt/uUqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaLq-00033s-1f; Thu, 10 Jan 2019 13:26:26 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaLk-0002tM-TX; Thu, 10 Jan 2019 13:26:23 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghaLg-0003Lg-M9; Thu, 10 Jan 2019 14:26:16 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Fix nanopi4 uSD card detect
Date: Thu, 10 Jan 2019 14:26:15 +0100
Message-ID: <6110368.KK4K1XCW2x@phil>
In-Reply-To: <c2c40662-f7aa-75d5-572e-c58b21170b59@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <6925511.AQqqGbhmY3@phil> <c2c40662-f7aa-75d5-572e-c58b21170b59@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_052621_268621_076FD9FB 
X-CRM114-Status: GOOD (  24.16  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 9. Januar 2019, 00:22:01 CET schrieb Robin Murphy:
> On 2019-01-08 10:42 pm, Heiko Stuebner wrote:
> > Am Dienstag, 8. Januar 2019, 22:57:27 CET schrieb Robin Murphy:
> >> For whatever reason, the sdmmc_dectn function isn't working properly
> >> as-is, and microSD insertion and removal goes unnoticed. Flipping the
> >> pin into GPIO mode, however, does do the job, so let's just handle it
> >> that way for now until someone feels inclined to figure out what GRF
> >> voodoo or otherwise is needed for correct 'native' operation.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> >> index 9c723038d8f8..2a183a6af150 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> >> @@ -505,6 +505,10 @@
> >>   		sdmmc0_pwr_h: sdmmc0-pwr-h {
> >>   			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> >>   		};
> >> +
> >> +		sdmmc0_det_l: sdmmc0-det-l {
> > 
> > alphabetically by node-name please,
> > aka sdmmc0-det-* should be above sdmmc0-pwr-*
> 
> Right you are, not sure how that one slipped through.
> 
> > If you're respinning the whole series this should be fixed,
> > otherwise I can also do that when applying.
> 
> I've fixed it up locally, although it might be worth holding off on this 
> particular patch for the moment now that I've taken another look through 
> the TRM and noticed those smoking-gun-looking bits in 
> GRF_SIG_DETECT_CON{0,1} - I'll investigate...

Personally I'm very much fine with using a cd-gpio instead of trying
to bring order to the GRF "chaos" ;-) as I'm also not really sure
if we gain anything with the IP-internal detect mechanism.

But then do as you like :-D

> [ side note - do you reckon there'd be any value in bolting a debugfs 
> interface onto the GRF driver, or is the realistic answer to just use 
> /dev/mem like everyone else and stop having silly ideas? ]

I don't think it would help much ... especially when it really only outputs
the register contents in the same way as mem or so does.

Having to fiddle with GRF bits really should only happen in rare cases,
so I guess mem should do the trick for that.

And the GRF driver also was a bit controversial anyway, with the title
of "dumping ground" looming over it ... so I'd like to keep it small
and simple ;-) .

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
