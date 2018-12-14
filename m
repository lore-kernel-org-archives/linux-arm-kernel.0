Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F918C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A7720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jwWwVqjX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FsxAjCCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A7720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PF+HdMfvJ6ziiOlIxTXgNmWXI4nZ5XC++r3tS/Qq8TM=; b=jwWwVqjXPDmwYUjq1w8+eM7ph
	FKf2HcCXyqLVtFHjc8lmprfTU9l09O/RVtfXkjplked6FUMfswv5q2+3uagh/cop27yW9DLLPsoyj
	NmbaRqv6cNskxaDHCuth1XryaZ+p+NzYDyFDNNS+U+NfTqHc0PDdUl/E4pd3l+H/hjJjZ8qIvX9cf
	Z7ryS1cuoLGUBsYjHmPsfG9QQ9bCXrOqrTy9hcCh/GS0batluaw2ci13TWpkQ3y7nE2bh72FE3U/0
	Pq+pDZrbE2QAO5h0cZvGxorA4+Qx02ZCBJf1RgMtFJCUZfX+/St/YCK5nQQDXN0jEi0PvWw+BfqKY
	HbZbydZ6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXhdU-0005Lt-5E; Fri, 14 Dec 2018 07:11:48 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXhdQ-0005L2-5A
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:11:46 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1357a00000>; Thu, 13 Dec 2018 23:11:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 23:11:32 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 23:11:32 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 07:11:30 +0000
Subject: Re: [PATCH V2 07/21] clk: tegra: dfll: support PWM regulator control
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-8-josephl@nvidia.com>
 <42e5746b-8484-8c2d-f871-5ad17e576f32@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <cba91bef-db11-5dde-a85a-a5edfc6e6d92@nvidia.com>
Date: Fri, 14 Dec 2018 15:11:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <42e5746b-8484-8c2d-f871-5ad17e576f32@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544771488; bh=4X0QsehJj2dl9Fd2o9eIaO6fFDMYljVX/gWfBDw/PC0=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=FsxAjCCGZhR1I1/Y0zRaAySRsn0O94FbDPhRVs8zr+Pb1iX2gTFhdkumOMUQk58hW
 h8F16Yg7PUTZAqFzeMhw0cd4Zp+zgyV6OqyCRnA3tCvX3AYAP2F5/tyZJ+0i7oP0OL
 bSMj90hoOgy65pnkOmTsqJ0Ntnd7AJDNEIbeE52+7u4PJOlmyRkXBUR1VpTFCembIG
 bs93lDfR7LA7SRRcYRNolbZPfwwgsuiD8yUx2uN5F08OzUopyufW2zRIPTScJvkb/K
 X6ajVL2szasTjpB0942bmeRpyfKsYiEUh7MMDpQ+wyxbj7XMU/q7DFVccSKP2AdGoh
 6ndg6Mg9jSpqQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_231144_476919_EB9BFB1F 
X-CRM114-Status: GOOD (  21.14  )
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

On 12/13/18 7:41 PM, Jon Hunter wrote:
> 
> On 13/12/2018 09:34, Joseph Lo wrote:
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
>> *V2:
>>   - move reg_init_uV to be with the PWM related variables
>>   - fix the variable type to 'unsigned long' if it needs to catch the
>>   return value from 'dev_pm_opp_get_voltage'
>>   - update to use lut_uv table for LUT look up. This makes the generic
>>   lut_uv table to work with both PWM and I2C mode.
>> ---
>>   drivers/clk/tegra/clk-dfll.c | 435 +++++++++++++++++++++++++++++------
>>   1 file changed, 369 insertions(+), 66 deletions(-)

snip.

>> @@ -594,24 +750,41 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>>   {
>>   	u32 val;
>>   
>> -	td->lut_min = 0;
>> -	td->lut_max = td->i2c_lut_size - 1;
>> -	td->lut_safe = td->lut_min + 1;
>> +	td->lut_min = td->lut_bottom;
>> +	td->lut_max = td->lut_size - 1;
>> +	td->lut_safe = td->lut_min + (td->lut_min < td->lut_max ? 1 : 0);
>> +
>> +	/* clear DFLL_OUTPUT_CFG before setting new value */
>> +	dfll_writel(td, 0, DFLL_OUTPUT_CFG);
>> +	dfll_wmb(td);
>>   
>> -	dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
>>   	val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
>> -		(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
>> -		(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
>> -	dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
>> -	dfll_i2c_wmb(td);
>> +	      (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
>> +	      (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
>> +	dfll_writel(td, val, DFLL_OUTPUT_CFG);
>> +	dfll_wmb(td);
>>   
>>   	dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
>>   	dfll_i2c_writel(td, 0, DFLL_INTR_EN);
>>   	dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
>>   			DFLL_INTR_STS);
>>   
>> -	dfll_load_i2c_lut(td);
>> -	dfll_init_i2c_if(td);
>> +	if (td->pmu_if == TEGRA_DFLL_PMU_PWM) {
>> +		int vinit = td->reg_init_uV;
> 
> This should be u32.
> 
>> +		int vstep = td->soc->alignment.step_uv;
>> +		int vmin = td->lut_uv[0];
> 
> This should be unsigned long.
> 
>> +
>> +		/* set initial voltage */
>> +		if ((vinit >= vmin) && vstep) {
>> +			unsigned int vsel;
>> +
>> +			vsel = DIV_ROUND_UP((vinit - vmin), vstep);
>> +			dfll_force_output(td, vsel);
>> +		}
>> +	} else {
>> +		dfll_load_i2c_lut(td);
>> +		dfll_init_i2c_if(td);
>> +	}
>>   }
>>   
>>   /*
>> @@ -640,8 +813,8 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>>   	uv = dev_pm_opp_get_voltage(opp);
>>   	dev_pm_opp_put(opp);
>>   
>> -	for (i = 0; i < td->i2c_lut_size; i++) {
>> -		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
>> +	for (i = td->lut_bottom; i < td->lut_size; i++) {
>> +		if (td->lut_uv[i] >= uv)
> 
> I think that we need to fix the type for 'uv' in this function while we
> are at it.

Okay, looks like I still have some variable type issue in V2. Will fix 
accordingly.

Thanks,
Joseph

> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
