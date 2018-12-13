Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEFEC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B55220849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mgb+TxXz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MCUz3Ppc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B55220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8042TLBUDnIv/qcNe5zESY2NWS8ogJWZ8sL0M/DIFU=; b=mgb+TxXzZz24sM
	hp+dLmiVLguK/nJ0uxghatnsPNDuR6xq9YAWH8pI4FRqlDFC+tohiJSCcE+1mXJz/g7z8MvJlx7BM
	cXWSVI4fqQsswarVV00JinNDrlMOPYmtBdjsp9rMNY1oKUruc2QdZjvnkXbT8eIOhi3UXTLq1yc3u
	INqD/iYo/Y1PS4+9S51CQhBKWKSvo9/yrchby8YnsUYsoogbdwFf3lf0gLWTVoTHmGHby8Q+Yl/4n
	+uAGFkjSvumlMb/RyJusnw9yhhnDsu9mfIRNGV5khPgSnpk65i+XP04IfTKDgm4W2KuHhYc2zaosm
	rzILpa8+XJ8V98P8A1fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQkT-0007KT-DT; Thu, 13 Dec 2018 13:09:53 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQkP-0007Jt-QO
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:09:51 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c125a100000>; Thu, 13 Dec 2018 05:09:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 05:09:39 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 05:09:39 -0800
Received: from [10.26.11.125] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 13:09:37 +0000
Subject: Re: [PATCH V2 14/21] cpufreq: dt-platdev: add Tegra210 to blacklist
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-15-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1bfade8e-5d2b-d006-11e8-20ecb5c7daf9@nvidia.com>
Date: Thu, 13 Dec 2018 13:09:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-15-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544706576; bh=/NxXxejn9LZMRdmyKHdMa7hKq4nTgN6FaID1/QNIUzw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=MCUz3PpcmZiqXLUkj7TJf+haXjeSKvOQlEYvLianHVBr4fhbx58XRiDsLQdMp2KIi
 A9GpxHj7SZ5U8WPazgCVe6pTkgBGaS2WIY+R29ct66MVz+XD9uy9ayMJ8e7IHELJp2
 UaoOXZ8/Ub31DUqnYrdw/GHok7Fj9zBTsNjtp0GKvqNJadZOdAhrPFjs7zFS8dQ3jD
 pDI0NLW4C5IHDT9mSz4F3pxMWy0qteZEciNViiO9g/XU9rgr2fNwrgJStr8rGR9k7d
 97dkTz25V9CdiQ5i0IrCqTc0OEK+gS9tZOssbX3bsk/iuoob40/a9jYqQjckc8rwLw
 jQsbwh85NPihw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_050949_855804_AA3BD712 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: linux-tegra@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 13/12/2018 09:34, Joseph Lo wrote:
> Tegra210 uses "tegra124-cpufreq" platform driver to register device data
> for "cpufreq-dt" driver. So add it in the blacklist for
> "cpufreq-dt-platdev" driver to drop that.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - new added in V2
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index b1c5468dca16..47729a22c159 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt8176", },
>  
>  	{ .compatible = "nvidia,tegra124", },
> +	{ .compatible = "nvidia,tegra210", },
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
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
