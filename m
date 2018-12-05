Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7749DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2553620661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e63zeUuj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hQPY5Sl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2553620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cBfTcm73gN4lYyxN5rfz+RWy/ICt8jG5miWODSw+NkM=; b=e63zeUujQzMtIFt4J+7Xy5Azg
	ZwvXWKd9wUH9+k8F7aLwtk2dM/igKd+u3hZo/MXsmKCz33QrPZ2RtGVTyzpNwPZf9E5eqwN0EaAXz
	TF0u3XsvcPqpnQBgP6jY7s4o2LYySHtBFvJezKn0Jf0z1Ak2G1shYb2z9tqYmBQ0bFzuAmVYMzAM/
	V6x9QstZ6OV27OQBfcWelQKMOpc961/+JZSLmulScVjAFRpVJRZgnu3m9WTnkS9S4FW7LxxMzFgnL
	cLl3nlcgA+23K4YyXXgRXqjv9m2e4zvD6R4JmHbEoSjyEk3Jc8NWl2ARW6PGwGU7mLz8NhcuZ7Kn9
	kbJ8yHN3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNZy-00019x-3H; Wed, 05 Dec 2018 03:10:26 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNZu-00018l-Bh
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:10:23 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0741900001>; Tue, 04 Dec 2018 19:10:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 19:10:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 19:10:12 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 03:10:10 +0000
Subject: Re: [PATCH 04/19] dt-bindings: cpufreq: tegra124: remove cpu_lp clock
 from required properties
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-5-josephl@nvidia.com>
 <20181204153707.GB26056@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <d74b8cf3-a072-a53c-2408-9f479998f5d3@nvidia.com>
Date: Wed, 5 Dec 2018 11:10:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204153707.GB26056@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543979408; bh=wmtGHoWEdfoMfDZp8ejQI+UBVlWOEUBPh9MSn+2yzas=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=hQPY5Sl+O3sBYL+m8UKCcnjXF34mKNFkG48CBmzHInOiA3EBslsHcJp1rInMdCV3p
 md6HFBXPTf50qohxIm4vE/53nTLAwl56ZMg1bpuyxiDM66PpOPPqYXwBAvxLmUOLmt
 vKd43N8mJzXzvqOWGERfBsguezTbCwnE43wtqBpUeQHO1wF6z6NE9p8q+BEUKJP61E
 bnYnUx19FTswuP/QksVpfgLPh8ARq7lpGDHz01GnvuJbmyr3E047sf2/eUCpPEIZS0
 +YuRT1DfdEfueyuqgi5DwbImUp4Z7gPDXjWq6XhWX3Ev5ps2yn9KNDZVK1uZWE+K3U
 DB/TlqIHLO22w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_191022_413934_8D7284DF 
X-CRM114-Status: GOOD (  16.85  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/18 11:37 PM, Peter De Schrijver wrote:
> On Tue, Dec 04, 2018 at 05:25:33PM +0800, Joseph Lo wrote:
>> The cpu_lp clock property is only needed when the CPUfreq driver
>> supports CPU cluster switching. But it was not a design for this driver
>> and it didn't handle that as well. So removing this property.
>>
> 
> I would mark it optional. This means current DTs will still be
> technically compatible with this binding doc.

Hi Peter,

There is no compatible issue of this property. Because the driver 
doesn't use this clock at all. Removing this won't cause any 
backward-compatible issue.

Same as previous patch for removing vdd-cpu-supply property once we fix 
that in the driver. The old dt binding still works with the new driver.

> 
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt   | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> index 031545a29caf..03196d5ea515 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> @@ -9,7 +9,6 @@ Required properties:
>>     See ../clocks/clock-bindings.txt for details.
>>   - clock-names: Must include the following entries:
>>     - cpu_g: Clock mux for the fast CPU cluster.
>> -  - cpu_lp: Clock mux for the low-power CPU cluster.
>>     - pll_x: Fast PLL clocksource.
>>     - pll_p: Auxiliary PLL used during fast PLL rate changes.
>>     - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
>> @@ -30,11 +29,10 @@ cpus {
>>   		reg = <0>;
>>   
>>   		clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
>> -			 <&tegra_car TEGRA124_CLK_CCLK_LP>,
>>   			 <&tegra_car TEGRA124_CLK_PLL_X>,
>>   			 <&tegra_car TEGRA124_CLK_PLL_P>,
>>   			 <&dfll>;
>> -		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
>> +		clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
>>   		clock-latency = <300000>;
>>   	};
>>   
>> -- 
>> 2.19.2
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
