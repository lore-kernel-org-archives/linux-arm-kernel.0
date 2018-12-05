Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:14:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0837A2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHkZK+uX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XCkC22h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0837A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RlcMnfKwjCQAkkhQpDR3mkLev7exxQaV3gwIMORqAac=; b=sHkZK+uXXxZN0OKQyWkly79UB
	49j5cl/ZQnFJSuCfXHtCNKrKL3EMr24DDy+vwaRtmKiWErZh1Ip4hA5W7+y6UJCj7V9vUxU1dCgE2
	jgKRZr2H+jPyYu/c02Eykbxcjwmm95dhVKoojCwRh15tjO8qGcPdy4a2ftdlPczQ90vrw36NmZJ8G
	WIXESkd6YwOpL1FmzKQyC8hAhiksN+yHaujZI6HMB6HPNtJUQovz23AZb+rzMdBJhspg3GnGGK/Hh
	G9Q3gUWGgG0z8VW78+jrLF3UWlWkSa97YONmd18luCqCXCscRQNFHnKeO3QuEbvPlPaWCWRRx2J1S
	yVVbduF/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQSI-0007zK-4A; Wed, 05 Dec 2018 06:14:42 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQSF-0007yd-55
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:14:40 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c076cc00000>; Tue, 04 Dec 2018 22:14:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 22:14:28 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 22:14:28 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 06:14:26 +0000
Subject: Re: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-8-josephl@nvidia.com>
 <20181204155351.GD26056@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <2ccd2fc0-64a6-95b8-05ad-feadd8e1e1c1@nvidia.com>
Date: Wed, 5 Dec 2018 14:14:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204155351.GD26056@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543990464; bh=z1g+KykSm619z9XnO6GOkIidMZxJvAiwZZBFleumClo=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=XCkC22h0PO5aYHwjE8X/inB2BaE4IDox77rcrBJa9gAj6R/2nTTSUBx7oExKC6C5q
 QRMGOCRv/MjA/dbgcUrd+S2ZFM8hjb80S5qgHcjTP4XWBY769KSmoVIXRZewyN6NLP
 uK3EyVLU5H7lPvuPgB7U0bmw3+uGIAEloXBIFqQuClYvnGht8gqk3GmFb2L1SWvYfx
 8Z/dymE3TXEVBLBtfT8Hj4y+plmQj2S+kO/1uCOCEc5nJF6Cdtsukj06F9ZSqIldKr
 aubBv4TMf97YlssQcUYPkJXm6ZLQa+ZTPiLs6xciRj2ZveYnfo/odUHgr1x9u3wOM5
 2e+JRJwVyp+BQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_221439_213451_B39E15DA 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/18 11:53 PM, Peter De Schrijver wrote:
> On Tue, Dec 04, 2018 at 05:25:36PM +0800, Joseph Lo wrote:
>> The DFLL hardware supports two modes (I2C and PWM) for voltage control
>> when requesting a frequency. In this patch, we introduce PWM mode support.
>>
>> To support that, we re-organize the LUT for unifying the table for both
>> cases of I2C and PWM mode. And generate that based on regulator info.
>> For the PWM-based regulator, we get this info from DT. And do the same as
>> the case of I2C LUT, which can help to map the PMIC voltage ID and voltages
>> that the regulator supported.
>>
>> The other parts are the support code for initializing the DFLL hardware
>> to support PWM mode. Also, the register debugfs file is slightly
>> reworked to only show the i2c registers when I2C mode is in use.
>>
>> Based on the work of Peter De Schrijver <pdeschrijver@nvidia.com>.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
snip
>>   
>>   /*
>> @@ -640,8 +813,8 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>>   	uv = dev_pm_opp_get_voltage(opp);
>>   	dev_pm_opp_put(opp);
>>   
>> -	for (i = 0; i < td->i2c_lut_size; i++) {
>> -		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
>> +	for (i = td->lut_bottom; i < td->lut_size; i++) {
>> +		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)
> 
> Use td->lut_uv[] here, so it will also work for PWM regulators. Also
> change == to >= because the exact OPP voltage may not be available. In
> the next patch the rounding can then be fixed.
> 
Okay, make sense to me. Will fix it.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
