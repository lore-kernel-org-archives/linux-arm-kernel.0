Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21A4206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjYrXwy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21A4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w+V87GXCvoIQ7+0BjznYoi6fi76mFHPPBwcxv3zWEbo=; b=jjYrXwy3JlgjYY1VxV7UfemBm
	nh85ViEn6LCRzG9Bgko1OturWyaXz9/hoeKi/EyxvPU+Pl75tqUIEAFfYDJFXHsP6/mWg5+c5tR3P
	MCmjH6hLyftd56/1sq9QUsDeLX1UgmkdRdsknxJCWrW1Re+BWpjNet1yeY9DRXaZ8GtYQWk7q86fb
	bKQ34JUMZ0snTqUmfmyzlorJqjUhSTFQ++AWAA5qW/LL84jKJHFRcbBKUvDvx73Wk/6N0LWwFBTJs
	/DQG4XPz+fP2kKdPIazHSakieuKOkJNCmojThJ0FFeJuHIoSZRO6fsinSojEQfHO29Lx+tJDvo64y
	H/neZZQ3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy048-0006eF-Id; Sun, 24 Feb 2019 20:08:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy045-0006dt-TZ; Sun, 24 Feb 2019 20:07:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 783ED80D;
 Sun, 24 Feb 2019 12:07:53 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CDD3F5C1;
 Sun, 24 Feb 2019 12:07:50 -0800 (PST)
Subject: Re: [PATCH] arm64: rk3399: Add capacity-dmips-mhz attributes
To: Marc Zyngier <marc.zyngier@arm.com>, Heiko Stuebner <heiko@sntech.de>
References: <20190224143525.15539-1-marc.zyngier@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9562f9e4-b832-5cc1-821f-696ededf8a02@arm.com>
Date: Sun, 24 Feb 2019 20:07:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190224143525.15539-1-marc.zyngier@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_120757_963097_3678110C 
X-CRM114-Status: GOOD (  20.59  )
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
Cc: Lin Huang <hl@rock-chips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 2019-02-24 2:35 pm, Marc Zyngier wrote:
> The RK3399 has the interesting property to be a so called "big-little"
> system, where not all the CPUs are equal (the A53s are much weaker
> than the A72s).
> 
> So far, we're not telling the OS that there is such a difference in
> processing capacity, and Linux assumes that they are equal. Too bad.
> 
> Let's tell the OS about this by using the capacity-dmips-mhz
> property. The values used here are those used on the Juno platform,
> which is quite similar. This leads to the scheduler knowing that
> it can pack more tasks on the A72s, and leads to a better interactive
> experience.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 6cc1c9fa4ea6..7eab31184aee 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -75,6 +75,7 @@
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <100>;
>   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			capacity-dmips-mhz = <578>;

Probably better to use the value from Juno r2 (485) which should more 
appropriately represent A53 vs. A72, rather than A53 vs. A57.

>   		};
>   
>   		cpu_l1: cpu@1 {
> @@ -86,6 +87,7 @@
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <100>;
>   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			capacity-dmips-mhz = <578>;
>   		};
>   
>   		cpu_l2: cpu@2 {
> @@ -97,6 +99,7 @@
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <100>;
>   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			capacity-dmips-mhz = <578>;
>   		};
>   
>   		cpu_l3: cpu@3 {
> @@ -108,6 +111,7 @@
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <100>;
>   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			capacity-dmips-mhz = <578>;
>   		};
>   
>   		cpu_b0: cpu@100 {
> @@ -118,7 +122,7 @@
>   			clocks = <&cru ARMCLKB>;
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <436>;
> -			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;

Oops.

Otherwise, though, I was on the verge of tackling this myself now that 
my 3399 board is building its own kernels - annoyance at the linking 
bottleneck steadfastly refusing to move off CPU0 (except occasionally to 
another little core) has been growing steadily :) With the nits fixed,

Tested-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> +			capacity-dmips-mhz = <1024>;
>   		};
>   
>   		cpu_b1: cpu@101 {
> @@ -130,6 +134,7 @@
>   			#cooling-cells = <2>; /* min followed by max */
>   			dynamic-power-coefficient = <436>;
>   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			capacity-dmips-mhz = <1024>;
>   		};
>   
>   		idle-states {
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
