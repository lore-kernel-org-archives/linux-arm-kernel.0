Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2851C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:52:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B103C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0F7tpum";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y42FYLST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cjCNKkXKh1fQU5z2LZyXbpFsE8KWQotB8EldU2HS0Lc=; b=p0F7tpumCZ13eo9/BjEDOz/jS
	kTdmh4UYJsCx654dD+nGUqtN6IuzagWvyQpYUwZG9UHZHQ7vOo1rofQjLhv6+38ZsCuCgDDrPrajr
	740wu1OxAR/yfwJyMlELDqwyCkO/xikPRGxwYgc2TBs+Eq9o2tfIHQSpaJc2J+aF1MuOScmvY968d
	HkpFwCJ1igazRWVHwRdHNtjS6h5vsLLokwpqXNNGyLQOCyFaWTIVN92bE50ZQI7O+WpwyhwVEwgi7
	Rzxb8Vm60duwsRCZTEM2eN3wgCp6wuWV6hrMSWuYpcYEkhTPa5MlN1G4NWtWkYaeKNqNloG+5IFxk
	odXU4OCpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdmA-0005Y4-CN; Tue, 11 Dec 2018 08:52:22 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWdm8-0005XP-4N
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:52:21 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f7ab50001>; Tue, 11 Dec 2018 00:52:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 11 Dec 2018 00:52:09 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 11 Dec 2018 00:52:09 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 08:52:07 +0000
Subject: Re: [PATCH 16/19] arm64: dts: tegra210-p2371-2180: enable DFLL clock
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-17-josephl@nvidia.com>
 <827e05c8-13b9-fb5e-7bca-1a34b81763b1@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <0f424403-50b7-983b-069b-1a7b757bf26a@nvidia.com>
Date: Tue, 11 Dec 2018 16:52:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <827e05c8-13b9-fb5e-7bca-1a34b81763b1@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544518326; bh=UiRMSJ0A5NA13xkV3lqV0J5+ypmaiKdB3d6d1NsY1Vw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Y42FYLSTAznJ54BX1OhUZq7Nlg+WmRHhoTfww7FLy2CZ4dfPXSDFEW2resqQqXUCW
 fRjkf9Nnm+wDOCYkoVG9/1gMASZiJuco+QpQPXV66xSegKjTmAp+9t2l4m/KtULi51
 AzKj7Gb6M3j6aGzlxfgoe7MeQ2ku0nKQ3011uYmsAhm3bYk0aBG2z1lVOq1YXUNfLc
 gU06gvwNiG3fLFLWH9a2KE6Eie5ctMfCKUNJPt/PsDBC6wVMLXYloZc9pknI0RYjyU
 NgR471t1A7hsiF7Sf6GP6jDJEGy8TfaBDS4f9kfZZe2qYcNsJUZOklQTne4qhAvr7g
 Z/aDBlKqZxOHQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_005220_185850_CAE40E04 
X-CRM114-Status: GOOD (  11.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 10:57 PM, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
>> Enable DFLL clock for Jetson TX1 platform.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../boot/dts/nvidia/tegra210-p2371-2180.dts   | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> index 37e3c46e753f..53f497c2b3ff 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> @@ -78,4 +78,24 @@
>>   			};
>>   		};
>>   	};
>> +
>> +	clock@70110000 {
>> +		status = "okay";
>> +		nvidia,pwm-to-pmic;
>> +		nvidia,init-uv = <1000000>;
>> +		nvidia,align-offset-uv = <708000>;
>> +		nvidia,align-step-uv = <19200>;
>> +		nvidia,sample-rate = <25000>;
>> +		nvidia,droop-ctrl = <0x00000f00>;
>> +		nvidia,force-mode = <1>;
>> +		nvidia,cf = <6>;
>> +		nvidia,ci = <0>;
>> +		nvidia,cg = <2>;
>> +		nvidia,idle-override;
>> +		nvidia,one-shot-calibrate;
> 
> I don't see any Documentation for or usage of the above two properties.

Oops. Good catch. Will remove that.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
