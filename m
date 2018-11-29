Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB5C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4605E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BE3ysEYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4605E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X7LN0T7n3o5QDeiZpU6anrry+e7rGIaLrlg9M2FGumA=; b=BE3ysEYnjk/zEn
	G6XNgbLq+Xm3up81K8mD3rebIS/DupdZ+e76W+RdHmxIXQ2EmBfcp+8pkIL3N27T+HeGcHfXs1oUw
	mX91ghsSHIU6tMcjjWiR6iVI9LIQoANu4Q0XRF79KeAZgfq6SpVgds92TBdxIKcYrhsZkDxmMhhvJ
	gw7sUOSAUejEOp7Du4gtRZ+kpjU9e3NH1BST9I98xEbIb5+jJ9rDF0gYV9LDaOzvu4bVzyxI4RaOQ
	Q7uN7IRh6wJ5GpFeqIW7VPDHnYVXlB0sVEKYOnWH9JPdlBibplYSfF0ZkYbK9Oebk1z33FOkSD5ad
	d0r1rLbHZRbE5QAs2+SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOV4-0003XE-CJ; Thu, 29 Nov 2018 15:45:10 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOUz-0002HL-EB
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:45:08 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 348668AB5E2B5;
 Thu, 29 Nov 2018 23:44:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:44:47 +0800
Subject: Re: [PATCH 04/10] arm64: dts: hi3660: Add missing cooling device
 properties for CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, <arm@kernel.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C000967.7070103@hisilicon.com>
Date: Thu, 29 Nov 2018 15:44:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_074506_062718_F1C317E6 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Viresh,

On 2018/11/16 10:04, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a88c65..d943a96eedee 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -79,6 +79,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -91,6 +92,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -103,6 +105,7 @@
>  			capacity-dmips-mhz = <592>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
>  			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu4: cpu@100 {
> @@ -129,6 +132,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu6: cpu@102 {
> @@ -141,6 +145,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu7: cpu@103 {
> @@ -153,6 +158,7 @@
>  			capacity-dmips-mhz = <1024>;
>  			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
>  			operating-points-v2 = <&cluster1_opp>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		idle-states {
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
