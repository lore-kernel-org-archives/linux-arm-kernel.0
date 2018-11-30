Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5CEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:45:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7095920673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iWPvQEDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7095920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10iedLi2WsZOJJSplofCZuvjUMtZDcAD7osG2Fe12tk=; b=iWPvQEDbGnRMCQ
	CNMvLcBFXbEbj3XB0K/YR0+zjb5az3MOippoLLdGmgw9PiRvO2ZGBWjP18lsutZ06zvUjs4PvVe2U
	jf7u9nWrvN5BTo6H2mcbQpzmyk8xFRk2KoWGYjs0JxVa2CyetmTyvqnMXmmQmm/3J2aeHj8Th53nO
	ndl49/8KWAybKw6CwT+6kfEoaFmuwXpCz/WVbNZkUr2VCDicxov8rwAGm0D0HIWyNkAEaM1aPYY7P
	yDsUE9lrhxHgzXu8nARkMVrgkC6uJNUL6sgZCwQXx9vTv/W7UbT8qEyg5bL9vxvBJpuHWk1kI8Zlo
	4sJklg7QT+6ntnspE4iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmr4-0005VL-W2; Fri, 30 Nov 2018 17:45:30 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmr1-0005Ur-AK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:45:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2002220746; Fri, 30 Nov 2018 18:45:09 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id E407020726;
 Fri, 30 Nov 2018 18:45:08 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/2] arm64: dts: clearfog-gt-8k: fix USB regulator gpio
 polarity
References: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
Date: Fri, 30 Nov 2018 18:45:09 +0100
In-Reply-To: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Tue, 16 Oct 2018 13:50:52 +0300")
Message-ID: <87k1kumpcq.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_094527_485451_A05EE388 
X-CRM114-Status: GOOD (  16.25  )
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

> The fixed regulator driver ignores the gpio flags, so this change has
> no practical effect in the current implementation. Fix it anyway to
> correct the hardware description.
>

Applied on mvebu/dt64

Thanks,

Gregory

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index aea9c220ae6a..af1310c53bc8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -42,7 +42,7 @@
>  
>  	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
>  		compatible = "regulator-fixed";
> -		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
> +		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cp0_xhci_vbus_pins>;
>  		regulator-name = "v_5v0_usb3_hst_vbus";
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
