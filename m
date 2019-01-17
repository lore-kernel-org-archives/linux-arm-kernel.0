Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B748DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842A020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZCixAP6k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dJKwaopu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842A020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FjXFaUgLm9YWra+ZKFalNX8oymLdGhyUwSl98q1e8hg=; b=ZCixAP6kSCHYzc
	HG6QaTuOwqQx24zKVI5B6KzDgJXD9Zx9wT2g8lc3gdFi4eucn6JKJ7940z22G9uE+yH8X0VW/edL4
	jhpcioyI+aSPN9C/PPUFI2+GLAOA+eXwoiiRiZzQXJA6NEerXFdT1tsE0JzyCSNWgmvxhh878DqDF
	q9MUZjFxHx9T5b52pS+8gliDLxTRXVYdKsShmBcE7dWigN7sD9byHTfNXC/hm/BgpsXWcYsRJLefD
	Sd3Vb+wQdjbr36sSL3vIAfinEDVD2IBPhoGkOxXHi8FT5RuIvGGCIaaAlxqUT87ouTeg+J4bu5Pph
	eairD4fxeblQu+GM8MSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk87n-000607-7E; Thu, 17 Jan 2019 13:54:27 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk87W-0005pl-Cr
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 13:54:19 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D85FD25BE43;
 Fri, 18 Jan 2019 00:54:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547733249; bh=bP3VzhZ4PpSngfoXO4nJmAPFCEe1Y2PfKPHnxOw/n8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dJKwaopu2d19LpqMQDeJ+dAawG+jee5bzyNNfSwkJU9XMzbJGyW6MBVTTd3CeSiHY
 Wdp8E2f4gPFGBRXbgtQRBrka194GR2LCawoOWKMnFMjZERMrAETJCLBMxNiPpww0qe
 oqQnb7uxaRkah8fF5GSo+mz7SV4vI6HVcssGB1pk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id CE7A8940459; Thu, 17 Jan 2019 14:54:06 +0100 (CET)
Date: Thu, 17 Jan 2019 14:54:06 +0100
From: Simon Horman <horms@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190117135406.kw2djf5iunq2ju25@verge.net.au>
References: <20190110142833.31577-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110142833.31577-1-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_055411_011341_C0C829BB 
X-CRM114-Status: GOOD (  17.21  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 03:28:33PM +0100, Simon Horman wrote:
> Add SDHI3 UHS pin control and use it when enabling HS200 support
> for SDHI3.
> 
> Based on work by Takeshi Kihara.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Tested on top of renesas-devel-20190110-v5.0-rc1
> 
> [    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
> [    3.055659] mmc0: new HS400 MMC card at address 0001
> [    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
> [    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
> [    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
> [    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
> [    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
> [    3.055659] mmc0: new HS400 MMC card at address 0001
> [    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
> [    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
> [    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
> [    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
> 
> [    2.901527] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
> [    2.909824] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
> [    2.967136] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
> [    3.055659] mmc0: new HS400 MMC card at address 0001
> [    3.061726] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB
> [    3.070827] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
> [    3.077508] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
> [    3.084132] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)

I see the command lines for the tests were omitted below.
I have added them, for the record.

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=128 iflag=direct
> 128+0 records in
> 128+0 records out
> 134217728 bytes (134 MB) copied, 0.92438 s, 145 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 9.02486 s, 59.5 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 7.36003 s, 72.9 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 11.0156 s, 48.7 MB/s
>
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 7.15907 s, 75.0 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 8.78869 s, 61.1 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 10.3861 s, 51.7 MB/s
> 
> The above test results seem favourable when compared to
> testing against renesas-devel-20190110-v5.0-rc1 where the eMMC
> device uses HS200 mode.
> 
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 14.7343 s, 36.4 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 8.46809 s, 63.4 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 14.6945 s, 36.5 MB/s
> 
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 19.1677 s, 28.0 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 21.3139 s, 25.2 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 19.9205 s, 27.0 MB/s
> ---
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> index 89383aa35d65..f2846c9eb83f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -535,6 +535,12 @@
>  		power-source = <1800>;
>  	};
>  
> +	sdhi3_pins_uhs: sd3_uhs {
> +		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
> +		function = "sdhi3";
> +		power-source = <1800>;
> +	};
> +
>  	sound_pins: sound {
>  		groups = "ssi01239_ctrl", "ssi0_data", "ssi1_data";
>  		function = "ssi";
> @@ -689,12 +695,13 @@
>  &sdhi3 {
>  	/* used for on-board 8bit eMMC */
>  	pinctrl-0 = <&sdhi3_pins>;
> -	pinctrl-1 = <&sdhi3_pins>;
> +	pinctrl-1 = <&sdhi3_pins_uhs>;
>  	pinctrl-names = "default", "state_uhs";
>  
>  	vmmc-supply = <&reg_3p3v>;
>  	vqmmc-supply = <&reg_1p8v>;
>  	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
>  	bus-width = <8>;
>  	non-removable;
>  	status = "okay";
> -- 
> 2.11.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
