Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578A6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:06:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D8120661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UenvsiE0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pbImOOjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D8120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RC2un0/q9b9v0HavZLEb+gYvedwzEtK6su18v2VV52A=; b=UenvsiE0YpjZPMMs9wWSo+zU4
	8bEWdBzuigU7GG1vArmq6KGMz+tRCaEAB9eeb+9HI48oECd5Wy0VDdBnEelEt7ua4f5ilbqyvILGB
	YvTkQKUmRnq1Mxs3fl0u5U924Kp+8cniIAm7P5PPx1TMYYRcLRUx/FW7kQ6WOcVzi+Nq4oKsvqdrD
	SY8BzTiCzV5gBR8DtPCPq8Bw7SuwFHZBgCWXJuPHWN+jEozxf2F2DwKF1UWeRPgn5xpVXPWhZ+Izs
	CA3QUkLUw33INMrRudrfkG7j3sUBaCVV7qS+B1BfpUqgdToqlr/w+aGob/CRkn4B2sEH+jIImkkOA
	tsfSxCC4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNVy-0007u9-8t; Wed, 05 Dec 2018 03:06:18 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNVv-0007ta-36
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:06:16 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0740960002>; Tue, 04 Dec 2018 19:05:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 19:06:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 19:06:02 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 03:06:00 +0000
Subject: Re: [PATCH 03/19] dt-bindings: cpufreq: tegra124: remove
 vdd-cpu-supply from required properties
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-4-josephl@nvidia.com>
 <20181204153600.GA26056@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <3a6f4512-db3f-4cba-21da-572edf14c5dc@nvidia.com>
Date: Wed, 5 Dec 2018 11:05:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204153600.GA26056@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543979158; bh=u7qvTh5hLw/pcLQZUU8RdA9Io6oupy5SV9sK1rGzzbU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=pbImOOjmcu/J+mYWbfBjfNjQLWF1acKu79fqFAdigfRyHQ/KgZGCdNlBas6rPfMhy
 lZPXe+FuW7hGZdQtW6CUpizBYJ5mCFyGhrhk923xOMSDWaEO/1IOKBfUVDqHYxIKZC
 P7fiMCEN+N/RWpRn3YSylw2A00t04LCUrybaHIVjKgu9i17CTqhrz/o5atXt9weWIh
 4KprPr9ATJZSUAc+730ImC91EaNyCeGCOmSVJ0lEy8KsuyWAtcg4a7iD6gIAfPqk63
 9SjGuryFTcLHlIr+fDH8zJOEJOM3vHKUx/Ne4wUd1tvRKJB3jqw2sumF2CECFFJ03V
 5kUlJWCI0xZqA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_190615_148359_39605076 
X-CRM114-Status: GOOD (  15.08  )
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

On 12/4/18 11:36 PM, Peter De Schrijver wrote:
> On Tue, Dec 04, 2018 at 05:25:32PM +0800, Joseph Lo wrote:
>> The Tegra124 cpufreq driver works only with DFLL clock, which is a
>> hardware-based frequency/voltage controller. The driver doesn't need to
>> control the regulator itself. Hence remove that.
>>
> 
> I think this is required for DFLL controlled I2C regulators because the
> regulator is queried for voltage selectors and I2C slave ID?
> 

Hi Peter,

Yes, it's required for DFLL-I2C mode and defined in DFLL node. It's not 
needed here in the CPU node for CPU freq driver to handle that. Hence 
remove that.

Thanks,
Joseph


> 
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt     | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> index b1669fbfb740..031545a29caf 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>> @@ -13,7 +13,6 @@ Required properties:
>>     - pll_x: Fast PLL clocksource.
>>     - pll_p: Auxiliary PLL used during fast PLL rate changes.
>>     - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
>> -- vdd-cpu-supply: Regulator for CPU voltage
>>   
>>   Optional properties:
>>   - clock-latency: Specify the possible maximum transition latency for clock,
>> @@ -37,7 +36,6 @@ cpus {
>>   			 <&dfll>;
>>   		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
>>   		clock-latency = <300000>;
>> -		vdd-cpu-supply: <&vdd_cpu>;
>>   	};
>>   
>>   	<...>
>> -- 
>> 2.19.2
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
