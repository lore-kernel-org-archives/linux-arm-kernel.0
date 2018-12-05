Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:21:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6883B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r4+kqB84";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g0S939/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6883B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sjNQlFz/H2Dos8y734ET40jNa63I/+agewbM/JcgrsI=; b=r4+kqB84wMqA10+76ilzXA3VK
	TumEsodNrUlIDnf/Lj/8t4i5xjZrMW4vOw7lLoR3pZGAwx5QxX6/KBYAW3UbdgnnCyatK34TMEH7e
	3ElgAeDTQEDJ8BFZ1NRzeGgPzaQKeqrBeBHTKkDB85aX7L1X9t7mCr5tnJoXp7zgZ3ltHbLgzEU63
	uNRVLo1u36TpQ51vC7+U2u3v6B7qrQcN5kd+0OBz1c/xlBeRCNWuabB4Lj1EhIoGzkd8eDMBUraff
	ZR/ViJLzMKAZUYt6taXwQKmoMbSUsYkpREO72ze2sse6l4gh3sWuiZ83lO6DvM2NC3phBFyyn9uRm
	xWGZtVm1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQYI-000344-0f; Wed, 05 Dec 2018 06:20:54 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQYE-00033T-74
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:20:51 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c076e370000>; Tue, 04 Dec 2018 22:20:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 22:20:38 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 22:20:38 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 06:20:36 +0000
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
To: Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
 <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <1cbe2662-1b5e-8261-f0c1-04a760cb08c1@nvidia.com>
Date: Wed, 5 Dec 2018 14:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543990839; bh=nwkHq7qY6kVmEU1kACdW/TsLd1gFki98L+Uc8j8wYqk=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=g0S939/EQr+Fxn0zpcMU/XU98WHMV3UztviRxD/06QwOYtcyGw65XBp8daQDv992J
 qjL2lwC61IZ5xkigNy8XxckUN5sgkUVzUGm29Zo+TSdMIn9FBAlZWL0PayQqV1PLdl
 8NsMyeRBiNgFzBOYjLjr0dInwfhquny8xeIL2syEZPsFvAON6Vo4C7z+9sI30fbHeZ
 zBIPCjLmm/WkvsYhVLpyTtFVzLtg7ytWnaRshzxcgQTsVpKLCTeOzk/RBip3J6hk2W
 okR14y7jVZN5cp4QKT4DGNPQ0tztzQeqMgfWf57f2IxyBYBm1GptfAsR/G49vnXZWT
 2Dz0eIOWaU97g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_222050_274785_61509ED7 
X-CRM114-Status: GOOD (  16.08  )
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

On 12/4/18 11:46 PM, Peter De Schrijver wrote:
> On Tue, Dec 04, 2018 at 05:25:37PM +0800, Joseph Lo wrote:
>> When generating the OPP table, the voltages are round down with the
>> alignment from the regulator. The alignment should be applied for
>> voltages look up as well.
>>
>> Based on the work of Penny Chiu <pchiu@nvidia.com>.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index c294a2989f31..4a943c136d4d 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>>   static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>>   {
>>   	struct dev_pm_opp *opp;
>> -	int i, uv;
>> +	int i, align_volt;
>>   
>>   	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>>   	if (IS_ERR(opp))
>>   		return PTR_ERR(opp);
>>   
>> -	uv = dev_pm_opp_get_voltage(opp);
>> +	align_volt = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
>>   	dev_pm_opp_put(opp);
>>   
>>   	for (i = td->lut_bottom; i < td->lut_size; i++) {
>> -		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)
>> +		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_volt)
>>   			return i;
>>   	}
>>   
>> @@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
>>    */
> 
> These 2 functions are only valid for I2C mode. We should probably add a
> WARN_ON() in case they are called when PWM mode is used and return
> -EINVAL.
>

Okay, will add that.

Thanks,
Joseph

>>   static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>>   {
>> -	int i, n_voltages, reg_uV;
>> +	int i, n_voltages, reg_volt, align_volt;
>>   
>> +	align_volt = uV / td->soc->alignment.step_uv;
>>   	n_voltages = regulator_count_voltages(td->vdd_reg);
>>   	for (i = 0; i < n_voltages; i++) {
>> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>> -		if (reg_uV < 0)
>> +		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
>> +				td->soc->alignment.step_uv;
>> +		if (reg_volt < 0)
>>   			break;
>>   
>> -		if (uV == reg_uV)
>> +		if (align_volt == reg_volt)
>>   			return i;
>>   	}
>>   
>> @@ -1554,15 +1556,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>>    * */
>>   static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>>   {
>> -	int i, n_voltages, reg_uV;
>> +	int i, n_voltages, reg_volt, align_volt;
>>   
>> +	align_volt = uV / td->soc->alignment.step_uv;
>>   	n_voltages = regulator_count_voltages(td->vdd_reg);
>>   	for (i = 0; i < n_voltages; i++) {
>> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>> -		if (reg_uV < 0)
>> +		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
>> +				td->soc->alignment.step_uv;
>> +		if (reg_volt < 0)
>>   			break;
>>   
>> -		if (uV <= reg_uV)
>> +		if (align_volt <= reg_volt)
>>   			return i;
>>   	}
>>   
>> -- 
>> 2.19.2
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
