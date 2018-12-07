Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C3EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FFC208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRRaQVNV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z8lcJB6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FFC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UeXBskZbiE3JcIg6mZpixmXvnuycD9y1SKzFAlbERfY=; b=kRRaQVNVsaCmRM
	mgoza08h4KkUt/7+AfzG3YozRoVtO16SmQJeDtI5AxHvECrCBPo4mbK1GMRD+/28fUz/BoYV5RJBT
	UNmovAsjcoeWtWDCOu3Rtg3LAzKGodbvi04vsJjC24Ze25q+Ew7MxJV7x8bE/pccjgM/QelO0O5dq
	bxUw08u2fQOeK8xfX5HRSlFls85q0ZaxcdMK991ChxVzZ8tNbDTdG1xvwqWAJ/whTdaDVDZRVvxaw
	jNfjTbBiekT7YNi9XbDdQnEs/Mc+PsOCfvSFde8kuDA4BiHhFhF1peXywcYLYyW6E+lGiB+wKz7E+
	TTvcGwqWBFhjiV5nY6Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHfm-0002Mp-7y; Fri, 07 Dec 2018 15:04:10 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHfi-00029t-No
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:04:08 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a8bdb0000>; Fri, 07 Dec 2018 07:03:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 07:03:56 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 07:03:56 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 15:03:53 +0000
Subject: Re: [PATCH 18/19] arm64: dts: tegra210-smaug: enable DFLL clock
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-19-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f84d154c-a204-d1af-b76e-6d4652fa3647@nvidia.com>
Date: Fri, 7 Dec 2018 15:03:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-19-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544195036; bh=KaD9cQlXg6WmVElE8C5gx5egC2hI/SjjgyvAgbM1ODk=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Z8lcJB6EIuXPA9fsOqT2tBGyjjgNhklcMQJVTe28O1fWkzka3a/oVSU91/yYAHceD
 ETVAfmudfVWxRZkDFFRayEtbxAQaCDFAS8nzCTh9OUUVqLn0yxS/2I8fJOWmczNKBe
 EUgBUMY6hQ1zYaIJP3QgABk/r9Tkv4BKiRyVNiI466ym3Mgto1RADpDOF6R5M3esQf
 C4RWq5SlPdFke3RpTmpuKt1KR+wJkpoYVL6FrXL+UgXhs4ZJgfbmrAvnBCk3cCIsUT
 JDGqEO7ZLBlutVaB6NZ1ZYItGcP7J/1pk6HnNTkccwt8+lusEXv/MIUllGDfNohnVl
 i5uxwMtEmenHQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_070406_845053_770B65A8 
X-CRM114-Status: GOOD (  11.94  )
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
> Enable DFLL clock for Smaug board.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> index b3930a9dd139..beac7b0bf436 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1698,6 +1698,18 @@
>  		status = "okay";
>  	};
>  
> +	clock@70110000 {
> +		status = "okay";
> +		nvidia,sample-rate = <12500>;
> +		nvidia,droop-ctrl = <0x00000f00>;
> +		nvidia,force-mode = <1>;
> +		nvidia,cf = <6>;
> +		nvidia,ci = <0>;
> +		nvidia,cg = <2>;
> +		nvidia,i2c-fs-rate = <400000>;
> +		vdd-cpu-supply = <&max77621_cpu>;
> +	};
> +
>  	aconnect@702c0000 {
>  		status = "okay";
>  
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
