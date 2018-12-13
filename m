Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FCBC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844FC20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BHRA4XhV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eZm7gj1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844FC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lArW7knolG1az++tyhiMHnUttXRDA5+ZCfNpwgp/sS0=; b=BHRA4XhVS3m79s
	d36jSjtgGFvHZDaoOosyHF20meQm0K5atGyAn2K1u5r5MBIhP15kraJb459UF5tIKQrrRnPhtAgkx
	53DCWdoiDZ4evmAS5m7SUfiEnRS3JpwISMry8syJ1v7hq0lKIih580iYqF1XDzhJ9+ONSIehzhSI1
	0XDnStl5NCilkl3elvhKfam3hZnNsPEC5d2YMxN6KGM0FXgS8dq3zm5ozYnHxsbfunLxZbA+baEAy
	I59PE+7JBKhsuHmL2f/k96E/UcNWUrZAIGCnLF1TeIQUWsW+WQfhvDjIF5V0zNg2LSmRKylO84XAI
	/nx4JUdrSGJR6DXy+Czg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQTj-0000Kc-Ic; Thu, 13 Dec 2018 12:52:35 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRi-0006Ue-Ta
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:41 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1255870000>; Thu, 13 Dec 2018 04:50:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 04:50:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 04:50:20 -0800
Received: from [10.26.11.125] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 12:50:17 +0000
Subject: Re: [PATCH V2 10/21] clk: tegra: dfll: add CVB tables for Tegra210
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-11-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8fda3564-ab10-bb24-6d2a-6bd26358fe88@nvidia.com>
Date: Thu, 13 Dec 2018 12:50:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-11-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544705415; bh=VD00aS8WOo+8qGe8n1HKIfYNnLVTOQfzRv+0x4i6JAc=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=eZm7gj1GHO+lllu9yAbLnVe5hisK9WAGDWYOM80/DpeaIfxCFEF5MgQOKrqODMrZi
 oj/wmIPVznuNcTuvsUtaxayOK32/2FoZAvfP5CCdub/RS65YdvKj7HlUMKeEgp0rZp
 9yFqQTC+8wfl4OF2/hJZ4qTEMWS1JqOCnkT97D8DxVIpEIJy5tQ6UOvEBZ5xi37luN
 VUEXCAlmOiF6YMCbuIuoV0tIR2FB5k0H58Sky//9B2crwcmMKql3mwWyoocJyKA9iA
 /plRK3IqCvoaYj0AR9RHHCcMYYDVtWHKyc1GVRq+3jOXg+RJoZJ/N4mb7Vl8uqIwTi
 ZV24qlwbEQoDg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045031_391248_391BECE3 
X-CRM114-Status: GOOD (  12.90  )
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


On 13/12/2018 09:34, Joseph Lo wrote:
> Add CVB tables with different chip characterization, so that we can
> generate the customize OPP table that suitable for different chips with
> different SKUs.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

...

> diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
> index bcf15a089b93..91a1941c21ef 100644
> --- a/drivers/clk/tegra/cvb.h
> +++ b/drivers/clk/tegra/cvb.h
> @@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
>  	u32 tune0_low;
>  	u32 tune0_high;
>  	u32 tune1;
> +	unsigned int tune_high_min_millivolts;
>  };

Sorry, I forgot to respond to this on the previous version. I think that
it is OK to add now, but please add a comment in the changelog to
reflect that this is not currently used, but we have plans to use it and
so we are adding all the data now.

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
