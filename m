Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49574C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:22:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1969521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eorBk2g2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kb+BRrge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1969521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pi/4tgs0BwUqaUThGdVOtYrxRLCoqiAmXYoOXbxHtLc=; b=eorBk2g2b45mTE
	NLounIAVDKlfJ5Q+gE2Dh5d4hK9ypWRO+1fgvnFbsJ6b0OeR6skhsy3LNr1wpVhzpBuAnOKeKCQRv
	smfOqe4hBtny6OB3n58JT17/OgtobQFSFfozxedb8hsweXcPJ4GRvMxQTXI0rxHmgccUIfjSF/+jm
	7DNh5HB8OPvTzrtUM1eOUSrsCTGnKFZcv5tUlAe4qvAUq3LrsppiEavRJNmI6oiGkitgdqrUzZoD7
	QzRxuczw1w548peO8ym7YdcLScDvPJstkBOp+kNu4LAbN7Lzk39heDsB/EMBfCnezW/51NHPRSEXN
	6CUfE2wY0q/R6HO8IgKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd55-0007Vu-BC; Thu, 24 Jan 2019 11:21:59 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd4f-000724-DO
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:21:57 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c499faa0000>; Thu, 24 Jan 2019 03:21:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 03:21:31 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 03:21:31 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 11:21:30 +0000
Subject: Re: [PATCH 4/6] arm64: dts: tegra210: add CPU idle states properties
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-5-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ef99309d-4c03-0c9e-16f0-055059a355d4@nvidia.com>
Date: Thu, 24 Jan 2019 11:21:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107032810.13522-5-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548328874; bh=eOfci/RjHzh6C9l/tLyHsAcpNuyJCDJF03KdLUb942g=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Kb+BRrgeY5umNLWKYcQrI1puZ+F3diu6LirgP9mMfCAZ2yqrLMk9puX0vdLvitHkB
 1E43bkkWqiisJwwmE9uyHtohZjJG/o/17ZPpI6kcLPcgLjslY1kEp/5lPMdIFcI4En
 Nre1z6lN2xxVNBDBexXIpliDX1fYVmyWHFVqEZ92aNAs8lAIL8iZOBf2J+cuvztCzu
 Hq8SjGCjSGF41UAwqm5bTSqICx4zy+mxJCFvtZ4wFaG3OTIWsNSnlE+75ekMEOTVlr
 IaI/fqaa2Bu5VvRICA22r42gRLoKEsI/+zQc9n8WgfkUkC7UoioNXHFKEkrzlzvseU
 6oLh6mlCwgfpA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_032133_813210_A150B86E 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 07/01/2019 03:28, Joseph Lo wrote:
> Add idle states properties for generic ARM CPU idle driver. This
> includes a C7 state which is the power down state of CPU cores.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> Note:
> This dt patch depends on the DT changes in below series.
> http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 143bd103c923..b583d3065946 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -1308,24 +1308,41 @@
>  				 <&dfll>;
>  			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>  			clock-latency = <300000>;
> +			cpu-idle-states = <&C7>;
>  		};
>  
>  		cpu@1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a57";
>  			reg = <1>;
> +			cpu-idle-states = <&C7>;
>  		};
>  
>  		cpu@2 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a57";
>  			reg = <2>;
> +			cpu-idle-states = <&C7>;
>  		};
>  
>  		cpu@3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a57";
>  			reg = <3>;
> +			cpu-idle-states = <&C7>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			C7: c7 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x40000007>;
> +				wakeup-latency-us = <130>;
> +				min-residency-us = <1000>;
> +				idle-state-name = "c7-cpu-powergated";
> +				status = "disabled";
> +			};
>  		};
>  	};

The binding doc says that both 'entry-latency-us' and 'exit-latency-us'
properties are required. Are we able to populate these?

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
