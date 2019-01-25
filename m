Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922A4C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61900218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IU0aI24A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I6yyXt0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61900218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T5sSPBhOG3io2ERn4GGe6VRabACH2Y6QZA1gwLnOdiU=; b=IU0aI24Aq28DyaEO72jI2ArA/
	RqrAsxp7/ZUbLuv3UIZjLTdAW2gXNKkuig8deay9zxaZfLGfDFIpmYsS2mZ4P7Apu7hXc1cK0KQ0M
	b2s5XIrB+6+MWTH6TKWzN6ta/g0/1qnJuk0/uSn4UhDEBK8aEObnTBN0ue85LX4BfEsItOYvATb6R
	4V0og1M+BU8Bj6GsRWz81IYFrYFnqxd8O1bCsyQ58bZBcoJq30wlMMGx9WqSNXGLlTXw6CEJgvRPL
	c5174CAM1uuYJMQzY2tt0x0LPmd4Uokq28z01YSSlOeKmYmgKbsoRuqs0hw/jdvl9Q3TM3g2z9FWo
	/v3E62x8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmsyu-0005TF-AZ; Fri, 25 Jan 2019 04:20:40 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmsyq-0005Sr-IZ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 04:20:37 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a8e93000b>; Thu, 24 Jan 2019 20:20:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 20:20:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 20:20:35 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 04:20:34 +0000
Subject: Re: [PATCH] arm64: dts: tegra210: fix register range of apbmisc
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
References: <20190104071646.15828-1-josephl@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <96906a73-b851-a188-3090-15105be10eae@nvidia.com>
Date: Fri, 25 Jan 2019 12:20:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-1-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548390036; bh=AqjzTHOUOwKZa4sro34BmJ+fOgY+i3yuzwP7PtRREqw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=I6yyXt0Z2Zuw2Jv9U2bLX8DEzbZ+94dPqigxTepfRg7PE11EjaN4ZuuJF+jZpOq6c
 C089z5utKyheZja76fGRBFVitjFjxc3bZGaYeD5h7zyKhRJxzsnobnIuMTvTaCkeqR
 ym/3p9uL4zzYnJ25Rp36lMDOy6N78OBG8UFCozeAbl5cvymLWumYJU4w4J7B/rS+s0
 3JRlaIfVEbgUFV9vgCqmMN4p8d8EE3aEMhZF8R/Pu/3nhE5MSuW9j/Z7CyhN+DzC7K
 NUDrbnw/vqaeXEwQ80C3lSzhkN3s7WJsRII+mNifhQMBp8LzMZaH5qE81HUrRtHGVj
 Tk0mEyMvh8V6g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_202036_616328_E7DBDD9F 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jon,

Could you help me to review this patch?

Thanks,
Joseph

On 1/4/19 3:16 PM, Joseph Lo wrote:
> Fix the register range of apbmisc, that originally inherited from
> Tegra124.
> 
> Reported-by: Mark Zhang <markz@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index e2baf52fe1af..b5858b5ea052 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -470,7 +470,7 @@
>   	apbmisc@70000800 {
>   		compatible = "nvidia,tegra210-apbmisc", "nvidia,tegra20-apbmisc";
>   		reg = <0x0 0x70000800 0x0 0x64>,   /* Chip revision */
> -		      <0x0 0x7000e864 0x0 0x04>;   /* Strapping options */
> +		      <0x0 0x70000008 0x0 0x04>;   /* Strapping options */
>   	};
>   
>   	pinmux: pinmux@700008d4 {
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
