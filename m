Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C137EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917EF20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4DaPwUC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QGxfqf7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917EF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s2JO0IVr5x2e0Q/CbCBqr4bNFONFJSB3hQPeRWEo7fg=; b=l4DaPwUCp3nlA1
	4o/ng8b7jNApSaMTMDL4Ut4l5X71pbQMq8C+knk7CgENNnu0lrb+zQh2HsGKqSxMQY4XoszqPh+WE
	dWtBMnhgSAjiFdUsbVyCufTap2AX7MG3kv0Kq8hIGHO3+duXirT6AzJVWK7HdOecb66rR8CvwLff1
	Jn9uCvtnhrgY3DUyu+LOnUuje1njONrt0kGbHGS5oNbeFV5ko0AkIvqkB+Ioo148yD4YdfqhfII6P
	58wp3HGlPCbZeddskeskroefEWAK87oySeCGO1221cMB1IGUbxFo83iZ9+KxayHgaFIT6qQGhRSmb
	Ol9L9Go1nAsrO0A7uBaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHDh-0002kR-2L; Fri, 07 Dec 2018 14:35:09 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHDd-0001V7-Ou
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:35:07 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a850f0000>; Fri, 07 Dec 2018 06:34:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 06:34:55 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 06:34:55 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 14:34:53 +0000
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <677ca0fd-7d99-713d-fe40-f8b0d0a77cb4@nvidia.com>
Date: Fri, 7 Dec 2018 14:34:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-9-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544193295; bh=YMUuIqs9mvCeFeam+ralgVvTkrhB56cef/mhPuP6CNI=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=QGxfqf7t0UivOBruvkakNjKsi4hxypcWa22VZOc4LPKqzZJAWX0eVyR1u4f4k6v/z
 m8wvL6TrkK1xD36oET42iGrBBRbGeakRYzIDJb/i4nzw8L2+Xw2mRGhoY0HkPXUit9
 O/GOYNjANtWTLmdL7K1H06QNu33eBu4BqyQyVIDcmmgQ7YI2WVFMVz3HvNzpOzQlCe
 5wuPu8zc3GBak+SxcPRA31PyH62U1Igai9Y93fjO7ZGdlgrN9DzTt35n4TfmLxB/ux
 xG5HOdy7E3mwHmIt7qMOu3LiuRiQ3PNnThVpbo35zHDb9kWM3kAnHb84XaqpEsSPxP
 BlCQdJUi1+0Lg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_063505_828566_D091D168 
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 04/12/2018 09:25, Joseph Lo wrote:
> When generating the OPP table, the voltages are round down with the
> alignment from the regulator. The alignment should be applied for
> voltages look up as well.
> 
> Based on the work of Penny Chiu <pchiu@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index c294a2989f31..4a943c136d4d 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  {
>  	struct dev_pm_opp *opp;
> -	int i, uv;
> +	int i, align_volt;
>  
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  
> -	uv = dev_pm_opp_get_voltage(opp);

This returns an unsigned long.

> +	align_volt = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;

Nit-pick, the 'align_volt' variable does not contain an actual voltage
but a step index. So maybe consider renaming this 'align_step'. And the
same for other places in this change.

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
