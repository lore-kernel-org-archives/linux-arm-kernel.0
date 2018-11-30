Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:45:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D4820673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q+nZ2WNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D4820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0/sDddfwYuHMcNxmbVUG9dtH4EapoqaW0INd689ckdM=; b=Q+nZ2WNGQGew2D
	+e22VoNeJNiyE7kFMkrCqDsePm2lhF3QSaZPT0x2d4opSmtEQ5N/cb92kq8JrW7+Utnc/m594f4dN
	7h1we5sU1osy9MyiYpny0oAMe1vlBFxwieZGjBS8UAqvCRA3/2klxXawiERSZFi+SmGefpjMU85du
	J2Eixrn6h0Stg8BnI6nL8FhMZ0dBFPeZSeyxXLlTZMl+UIPdaucgZ6hj82BaJLnS0+4+hPgIyZSYa
	kac9u/4jrjrg9WzxEow8jiUXAR0r7ewC0VIW6OpPBBGyOp9FpJluXinl6deeg7i6mfSTuv7lm8E09
	DtCd9X0Ee8DmyxFj+//g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmrN-0005jT-8B; Fri, 30 Nov 2018 17:45:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmrK-0005au-Mq
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:45:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9FA0120711; Fri, 30 Nov 2018 18:45:35 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 44470207B0;
 Fri, 30 Nov 2018 18:45:35 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal
References: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
 <d7d0516199244af29efdd5231313a6519f5a4350.1539687053.git.baruch@tkos.co.il>
Date: Fri, 30 Nov 2018 18:45:35 +0100
In-Reply-To: <d7d0516199244af29efdd5231313a6519f5a4350.1539687053.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Tue, 16 Oct 2018 13:50:53 +0300")
Message-ID: <87ftvimpc0.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_094546_885087_E2816FFB 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, netdev@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>,
 Ori Shemtov <ori.shemtov@solid-run.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Baruch,
 
 On mar., oct. 16 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> This reset signal controls the Marvell 1512 1G PHY.
>
> Note that current implementation queries the PHY over the MDIO bus
> (get_phy_device() call from of_mdiobus_register_phy()) before reset
> signal deassert. If the PHY reset signal is asserted at boot time, PHY
> registration fails. So current code relies on the bootloader to deassert
> the reset signal.

Applied on mvebu/dt64

Thanks,

Gregory

>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index af1310c53bc8..73df0ef5e0c4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -337,6 +337,10 @@
>  		 */
>  		marvell,reg-init = <3 16 0 0x1017>;
>  		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp0_copper_eth_phy_reset>;
> +		reset-gpios = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
>  	};
>  
>  	switch0: switch0@4 {
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
