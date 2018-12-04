Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E812EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DB9206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="clwgath0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dgJ3trRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DB9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yeDE+m06bdCGxMO+p5U1CCSYvCgWZ9YtNhl5u+tnnGo=; b=clwgath0vqAmTi
	79UR0bO7uec2vEX0IcMK+PYm2Gct/HwADAgmRr2xRioXAdS3AnOwc4bEoSmc7YUcjUwi0b6VwkP+1
	Ztx2KtQSzJJc7gIQak7SCl71GIqow2kh4A1F4aUBq1K0LEvzMZp3I6j4d8YtwtAkyY7vAzhlr7JJx
	2BYkrJ2B0dRcTMEA8d9IHlxymwd9iXen/FCxgc62n60vW1TiZXweKEHOHAuOl5ZXXOvG6jXeoN6oO
	qtzIZd74l+9xThmSx7dfOMFHCdG0b0SO0IrrDtAluYn9f/vrdbiyPdQLLSoCLPjbpMKxfLpBbInrH
	I4BCEnWsBlOND+rLDUew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUClI-0007Ci-EW; Tue, 04 Dec 2018 15:37:24 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUClE-0007AZ-Ft
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:37:22 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c069f270000>; Tue, 04 Dec 2018 07:37:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 07:37:09 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 07:37:09 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 4 Dec 2018 15:37:09 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 48AD4407B1; Tue,  4 Dec 2018 17:37:07 +0200 (EET)
Date: Tue, 4 Dec 2018 17:37:07 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 04/19] dt-bindings: cpufreq: tegra124: remove cpu_lp
 clock from required properties
Message-ID: <20181204153707.GB26056@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-5-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204092548.3038-5-josephl@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543937831; bh=suxuU4hx+hDKXy/SxFoGVMGYMNWY+N/hdV6JEtOX8BI=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=dgJ3trRpD8vzFwueidDl2AKZRnXZ7l8M5EHLbp+YHPoPrRycsdXG8XvlnCxlDgjS9
 xLZYZfe/bhWvQsTOWELrrwitvvVXmYjAsFW24HQR3jMfT9rSqjlW8FcOFnxGJkPwgJ
 Es0MXls+DJpDmEHW0XOirF6km6xsFM0iNdq85ZpGfZdALCIlp5Ebrd4p0MniexnJD5
 Pc2VvCml+yJ15Jp82jyLqAfNQ41EuLTtSmG/KKe/fiWZgogISneCRAQP1SLxzMswH6
 3PhVP/oFF65UkEIMVFUqeBd8ep+69EjyCj9gaOEeFuXk1n3/wgYQEHTTITO+XCpqMW
 Aem9tzS3ZR74g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073720_540651_FA61B259 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:25:33PM +0800, Joseph Lo wrote:
> The cpu_lp clock property is only needed when the CPUfreq driver
> supports CPU cluster switching. But it was not a design for this driver
> and it didn't handle that as well. So removing this property.
> 

I would mark it optional. This means current DTs will still be
technically compatible with this binding doc.

Peter.

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt   | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> index 031545a29caf..03196d5ea515 100644
> --- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> @@ -9,7 +9,6 @@ Required properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names: Must include the following entries:
>    - cpu_g: Clock mux for the fast CPU cluster.
> -  - cpu_lp: Clock mux for the low-power CPU cluster.
>    - pll_x: Fast PLL clocksource.
>    - pll_p: Auxiliary PLL used during fast PLL rate changes.
>    - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
> @@ -30,11 +29,10 @@ cpus {
>  		reg = <0>;
>  
>  		clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
> -			 <&tegra_car TEGRA124_CLK_CCLK_LP>,
>  			 <&tegra_car TEGRA124_CLK_PLL_X>,
>  			 <&tegra_car TEGRA124_CLK_PLL_P>,
>  			 <&dfll>;
> -		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
> +		clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>  		clock-latency = <300000>;
>  	};
>  
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
