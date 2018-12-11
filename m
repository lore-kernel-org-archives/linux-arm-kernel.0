Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:12:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2D32081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rGoyh+P5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="O3NIhjjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2D32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+eyb8RjDp9VCXSKaQsfyHHi2mH5+jbtOa8legORJUiw=; b=rGoyh+P5/t5Sau
	NWIh++vMlR+pNVCcgOHme/kHdK3P7MiN055lna9MaBKAZ6RuBNKMLO7wJ1R2JucHoN21y+SIMqcrI
	4Ui2AC+lyrPvyck37RUBLwjybNW2rJ+yQkFAly8XPxVxyQx6B3mu7W9WU1OH0wkryHCpRVp97KG8A
	+LXRccqgtAlgcXCjcN+1TUmLARUd+VFrj/wccAaflwI/rmV8zgym8MrtNu9o7Kove/yxI7YfvXQSu
	PZ6eouGZlhXjQ9Q5sspTsxhNgST6WnuF/mkYoTSH0mdz0OPxiUtm8WsPFxWeCl2m4/NGFvg2NDPXo
	WuZXW326avEOMdIpze3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcDQ-00065G-2i; Tue, 11 Dec 2018 07:12:24 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcDM-00064e-Bo
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:12:22 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 76D194002F;
 Tue, 11 Dec 2018 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544512298; bh=SRtpF62rPLRr88K1h+vRUay4KSxTaf4gZ27/Ozn4POk=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=O3NIhjjyZjGCqXI+3EtG/Jho0Mw2+/G702jrnAEVFa5BQODrKOyPrxxFPJaNQYJOs
 bwUTmt+veOhPl3K9C2G5bU22vWT2pSXjes8w9y6lvOAv44NqlJEh1IxDcVlHTzu13U
 qSGlCtRWwa6B9VawBY6YXvERt6h93TNq4CtSqfVcYtyewMkrIyI/zkwFVfjUnZgXg8
 Ckx4H9yFnG/zw1LtuZYZo5GZxQGWPWgZ8gP83xUfH4Xt3ZiILqMjz47UHSu0vSe3mz
 aXttaewmDcFc+FbGaHS1xqY8A7sAp7hlstQGVfJvdMJTb6d+qrSYq1vuQyGxDJFaY9
 eHqhOjEpA9hFg==
Date: Tue, 11 Dec 2018 07:11:37 +0000
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 0/8] This is a second edition of a series
 that implements voltage
Message-ID: <20181211071137.k3rqwctnibg6tyc2@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_231220_569851_8EF36B01 
X-CRM114-Status: GOOD (  16.13  )
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

On Mon, Dec 10, 2018 at 08:42:11PM +0200, Priit Laes wrote:
> ramping for AXP209 DCDC2 and LDO3 regulators and software
> based soft-start for AXP209 LDO3 regulator.

Ugh.. managed to botch this series. I'll send a fixed one
today.

> 
> Both features are needed to work around a PMIC shutdown when
> toggling LDO3 on certain boards with high capacitance on the
> LDO3 output.
> 
> Similar features (or workarounds) have been also implemented
> on u-boot side [1].
> 
> Changes since v1:
> - Rebased on top of next and dropped already merged patches.
> - Dropped LDO4 full range devicetree change for Lime2 (prev patch 9)
>   in favor of general pin-bank regulator dependency [2].
> - Fixed paths in devicetree bindings (patch 3)
> - Added note about software based soft-start for LDO3 (patch 5)
> 
> [1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618459.html
> 
> Olliver Schinagl (8):
>   mfd: axp20x: name voltage ramping define properly
>   regulator: axp20x: add support for set_ramp_delay for AXP209
>   dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
>   regulator: axp20x: add software based soft_start for AXP209 LDO3
>   dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
>   regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
>   mfd: axp20x: Clean up included headers
>   mfd: axp20x: use explicit bit defines
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |   2 +-
>  drivers/mfd/axp20x.c                             |  13 +-
>  drivers/regulator/axp20x-regulator.c             | 142 +++++++++++++++-
>  include/linux/mfd/axp20x.h                       |   4 +-
>  5 files changed, 161 insertions(+), 9 deletions(-)
> 
> base-commit: 14cf8c1d5b90a0cf6a8ba51ef59db8da8c7a2622
> -- 
> git-series 0.9.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
