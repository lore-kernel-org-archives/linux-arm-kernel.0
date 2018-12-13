Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0438EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:46:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC67920849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7JbEe/d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bPZRY74U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC67920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rl/cpeRN802/giudfBF6c2KbdVomjymhZDsk88eCTnM=; b=G7JbEe/dFNgmFe
	zn/uJkfxnXj1DSpNH/aK1YscfWnoIIukKXK4JTWNEeudmKldG2B+n9OOTAqlHnFChiLoDv9/W4C2/
	9hsx4qL2lZmTMHKkptfjHzENPe76qHMVYRggFjFRTNdabFMnRbMmVLU4/j3NH5JUAaAs/vmXoQx+4
	8NXTBRvWe5TfF6tQLn24z6VXdZrhiaZeesGuZ0UkpuwvyB97nQ8UUS98fbiTKyMlny2TtvnUC0/2E
	J/NODPKGMUApyWS8OJqkK6xF9OPBjAyUFptv0jRg2rTpy4HEczhTrcvz4L/X7U2pBMl+1YSXKuanz
	+d1g71ifv3vuzjkeJNhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPS1-0004dS-DI; Thu, 13 Dec 2018 11:46:45 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPRy-0004cR-J9
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:46:44 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1246950000>; Thu, 13 Dec 2018 03:46:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 03:46:31 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 03:46:31 -0800
Received: from [10.26.11.125] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 11:46:29 +0000
Subject: Re: [PATCH V2 08/21] clk: tegra: dfll: round down voltages based on
 alignment
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-9-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c1ce50e0-fccf-aa37-361c-4dd9367b092d@nvidia.com>
Date: Thu, 13 Dec 2018 11:46:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-9-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544701589; bh=oDthzxuE74SejfjxcEIQD9xRRx51Ge2buzNvAx78kGY=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=bPZRY74U6esombBjCaLk4oBsqGEwR5YA8iHyhnFd5JY2x1j3sBEpsDQ5xYrwcg6VX
 +lEeQzPgBqduQRYB1+xoPHRPCYot7A5Aq0T4p+g3vOW21ZHb8FWg12amLMWdeqJP/Q
 MX+9ncGMrO9hLO+n2yBU4P3sgfTRCCYdoPkNmd1BeGq4nJXS9PpknM0DPkU3JIYro8
 4AQava20kFTT8NBdUQtWdw6yqNut//3Al9sFwa32o71KGe/uzZBabF3KhtdCzIRG1L
 lK6fG1QVuoO3aERWVfOxuDQyjgRp/UF20sNYnjpQ0H1vv+BvAyzKXkC3uAKfiKFGrf
 XNjVS2I94GKHA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_034642_639415_97577536 
X-CRM114-Status: GOOD (  19.27  )
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
> When generating the OPP table, the voltages are round down with the
> alignment from the regulator. The alignment should be applied for
> voltages look up as well.
> 
> Based on the work of Penny Chiu <pchiu@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - s/align_volt/align_step/
>  - s/reg_volt/reg_volt_id/
> ---
>  drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 72e02898006c..b3668073d9b4 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  {
>  	struct dev_pm_opp *opp;
> -	int i, uv;
> +	int i, align_step;
>  
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  
> -	uv = dev_pm_opp_get_voltage(opp);
> +	align_step = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
>  	dev_pm_opp_put(opp);
>  
>  	for (i = td->lut_bottom; i < td->lut_size; i++) {
> -		if (td->lut_uv[i] >= uv)
> +		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_step)
>  			return i;
>  	}
>  
> @@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
>   */
>  static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_volt_id, align_step;
>  
> +	align_step = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> -		if (reg_uV < 0)
> +		reg_volt_id = regulator_list_voltage(td->vdd_reg, i) /
> +			      td->soc->alignment.step_uv;
> +		if (reg_volt_id < 0)

I don't think that this will work. If the step is say 10000 and we
return an error code greater than -10000, we will end up with 0.

>  			break;
>  
> -		if (uV == reg_uV)
> +		if (align_step == reg_volt_id)
>  			return i;
>  	}
>  
> @@ -1554,15 +1556,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>   * */
>  static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_volt_id, align_step;
>  
> +	align_step = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> -		if (reg_uV < 0)
> +		reg_volt_id = regulator_list_voltage(td->vdd_reg, i) /
> +			      td->soc->alignment.step_uv;
> +		if (reg_volt_id < 0)

Same here.

>  			break;
>  
> -		if (uV <= reg_uV)
> +		if (align_step <= reg_volt_id)
>  			return i;
>  	}
>  
> 

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
