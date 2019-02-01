Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEA9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B8C2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VY9+pTrn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ChS7e8BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8C2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7BkM+N6extJg0jvqLO7DLIzLbU298pkxUvvlnsYzG90=; b=VY9+pTrnV2EXxZ2yWGGOn78ck
	QLfRYXE7wMeHtFyahZhY4tTMHSJ/IR8dxx/+XzgdvStbHRaQh6DXKSmq6Xj3pOdnz87D6qrGsz40h
	HvbFkZtu8F08OiUaFjhoTWwrfDjFnmd4JLFCikhhR+Ei6/Y7af0uFRV34wIx47ezbboXsLmA9bAEy
	DQlQz63AOTmSuwMG3iQxk3cFiQjvatvnryOZabkNcQvqU4xKt/CP91cmkTDxtSzMSGxSCspUltWuj
	dI0A5IkzG430U9SNMampngTgusJoRtDf5fLJtAFe2FcELickDkJzM0mx77biPJdgk1cRkii3FXNOP
	v8LQF0gKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOXC-0002mR-Pj; Fri, 01 Feb 2019 02:26:26 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOXA-0002m8-60
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 02:26:25 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53ae250000>; Thu, 31 Jan 2019 18:25:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 18:26:23 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 18:26:23 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 02:26:21 +0000
Subject: Re: [PATCH V4 6/7] arm64: dts: tegra210-p2180: Enable CPU idle support
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190131092410.28222-1-josephl@nvidia.com>
 <20190131092410.28222-7-josephl@nvidia.com> <20190131125711.GL23438@ulmo>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <92eaf9ce-a483-5ccd-0894-b72476f2ee86@nvidia.com>
Date: Fri, 1 Feb 2019 10:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131125711.GL23438@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548987942; bh=QJfXGwQtEEsoAgvUXNOzHjz1k/maHNFoGC0fxnAGb8Q=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ChS7e8BRQLzctlTxca8dbvsZlovoms+bB06hcTfo9OvqgzW9xMhCp5icyCdOQKZg4
 taYMbbcOAd6BjumyTzbx0EqT4QSeHutQlULGe+Xk/AhWIniOnEUC7ZHus8enCFHuse
 +6p7BRzHMO934o/SWGyVtCAlLdDuQEwtJPbiA3B/J+tufWuj17hzVkqNgEKq52Pu7h
 Cf9mkPfLlEi/vtvva42lEkhhTGBh7pbTd1L3AspMMNWi/p46crT5xIr4qifTKORDt5
 QwopMoG/Wkj+B1/+J3WkupQxaIQfxVIP8ljC3Ug2JHmzr8RgLjW0NGcyQ4xCHG0dul
 kDybF13PP3aWg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_182624_232820_485D1F89 
X-CRM114-Status: GOOD (  16.15  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 8:57 PM, Thierry Reding wrote:
> On Thu, Jan 31, 2019 at 05:24:09PM +0800, Joseph Lo wrote:
>> Enable CPU idle support for Jetson TX1 platform.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> v4:
>>   * no change
>> v3:
>>   * no change
>> v2:
>>   * no change
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>> index 053458a5db55..d1a492c63e96 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
>> @@ -305,6 +305,12 @@
>>   		cpu@3 {
>>   			enable-method = "psci";
>>   		};
>> +
>> +		idle-states {
>> +			c7 {
>> +				status = "okay";
> 
> Doesn't seem like the code currently cares, but the bindings are
> specific, so this looks good to me.
> 
> Given that we need the timer in order to get out of this state, I'm
> assuming that I should hold back on these patches until the driver
> changes have been merged to make sure we don't regress. Is that
> correct?
> 

Yes, correct. Need to make sure all the timer related stuff landed first.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
