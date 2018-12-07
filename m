Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB302146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oHsSTw3v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bddzFqKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB302146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FamY3UehqSq9xGziUTQfj4TmYD3Ld+x9Z6G//Chzzjg=; b=oHsSTw3vaqMtBx
	0QuD5pRe4HG+LI9CEGlNGb61XQ/ZZ1jtB3PUMBo5gRUVYBDYyxQRXI6aLV2n4jMDR/oeLq6uo2m/g
	+RM1bhrVA0pRojA/OGaoXI/iAz3HZxmNEKBOzXFjrjhYMXCSynbzcJBYTOisuY1dqeZaDiLVg/csa
	AAWvaumHgeoT8gyzDnl67bCLJw8o307wCj0NzndUWxUXLrGjRSQz+a+r80zhWaKegX/T9wwxDhDeE
	C9bWPUWIpTWoSqoIzpARrY+vb6E6qr8pmI6qVYQC/DMtKWt1pF+2TzoVcjr88iZwjpXL11g6CD3BA
	f1Sk5j8ccPsb1uYLn9kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHX6-00047z-A6; Fri, 07 Dec 2018 14:55:12 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHX2-0003Pr-4K
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:55:10 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a89bd0000>; Fri, 07 Dec 2018 06:54:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 06:54:56 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 06:54:56 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 14:54:52 +0000
Subject: Re: [PATCH 14/19] arm64: dts: tegra210: add CPU clocks
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-15-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5835991a-50aa-1fd2-f9c5-53238a38c993@nvidia.com>
Date: Fri, 7 Dec 2018 14:54:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-15-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544194496; bh=8bcCTWY71m7zwQTgXwNIma/PabE+2jtfih5R9YMkTeI=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=bddzFqKmr+MojYVZoeNJ5hBR5OlvHN6dsVVO4yCU5VKGPKdA1VIJ+EqjR3hMi6K7k
 1frNZiSogPMEIyY5AAb4A+d5JiaNJFXsouUr5diLWIZf5jh3e0E5rr/mNVh4RwMIzm
 G6BTnby8IjQIqZsr7gwXsAVLwrFWiHXB4R+B2yH+JaB1j3W/yx1D1gQRZQI02EhqxE
 eY/qfFNYCSDyHbBW5kWvo3A0tgFQF9hg3V+YxSEcb8LQwNh0eBSdJVqOrKXctoxBwB
 HnHQE7icolcjyiFCbdRK/xoPV4WugcUb4kFHOSoqcvX767x5igjoYOOQXvevIfSNt0
 78Q4T7I7Uypbw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065508_422738_32E6334E 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 04/12/2018 09:25, Joseph Lo wrote:
> Add CPU clocks for Tegra210.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index a6db62157442..e2baf52fe1af 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -1304,6 +1304,12 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a57";
>  			reg = <0>;
> +			clocks = <&tegra_car TEGRA210_CLK_CCLK_G>,
> +				 <&tegra_car TEGRA210_CLK_PLL_X>,
> +				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
> +				 <&dfll>;
> +			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
> +			clock-latency = <300000>;
>  		};
>  
>  		cpu@1 {
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
