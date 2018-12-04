Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64379C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E591206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bznLxAnw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VVDutLTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E591206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ruPKj2jxDxhWB4tDgVIVAwBbsXPC31dxEIY/XiEtzDk=; b=bznLxAnw5sqUxZ
	ybJ/7NuXnXm6OA3ZaSO3bztZnFfonXructQVMw299iDhgZBjvJgyePbu911TpNbCivjraOlqqFCDO
	uf5IK/TKPo+EqB9+aV87ej1SWXQuUzwHUteAeF/eylgmAGp3jIBHWsqaiaEwwCcGlVxvmgBItdKzx
	4/phLPc0HsqakScgOcRd+A7PLHh8i6dU8H7pU8fvecNL4eogmkINIye7itQgLA5rF4wYyIBjwOaGk
	V0cNmTqMzx6MOkjaYi065Er8wAw5CoixYpJSRAiXzZ7EVxrcGjJ+9Zgbzsxy8Bx0dYRiPp5Wl9Lg3
	HfjCiD3I4brdTOv0GE4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCuI-0004IU-6K; Tue, 04 Dec 2018 15:46:42 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCu7-000454-1G
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:46:39 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06a14e0000>; Tue, 04 Dec 2018 07:46:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 07:46:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 07:46:20 -0800
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Dec 2018 15:46:20 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 19BB9407B1; Tue,  4 Dec 2018 17:46:18 +0200 (EET)
Date: Tue, 4 Dec 2018 17:46:18 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 08/19] clk: tegra: dfll: round down voltages based on
 alignment
Message-ID: <20181204154618.GC26056@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-9-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204092548.3038-9-josephl@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543938382; bh=CAv7moa/rHrIfpLTeL8A5gqIXg6pCGZc3ORWQX9e0RQ=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=VVDutLTDKbyP+FJB51W8o1qDVzffXacHDPGiESNdjq7/02Y16cEzGne1/OTj/sKQn
 ojCuCc5989ygCiJvyhttBpBHLwDCs2CMRIFgjrkbzRztXOtDYEywfMI2PdNBhEgMvY
 w1EcCu0TfrwkRVPnq+aDwGgx799aXcvET1Jb2oLwuK4zNzf/gvUqBHE6QAYlQZMY9I
 N6eTGu0x2693q3PZOotM3pjbxoFp8aXDciLr90XOVPku4D7+awZuyh/3QCMd1/kN5+
 84B0gj0+Ok83WhFZcBGOOPRLc1q5TYUw68NPRJbyuag8DTAv1XroN5OiT5Tr1jidvZ
 rDxJAjKcevUAg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_074631_612482_D2F858EB 
X-CRM114-Status: GOOD (  18.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:25:37PM +0800, Joseph Lo wrote:
> When generating the OPP table, the voltages are round down with the
> alignment from the regulator. The alignment should be applied for
> voltages look up as well.
> 
> Based on the work of Penny Chiu <pchiu@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index c294a2989f31..4a943c136d4d 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  {
>  	struct dev_pm_opp *opp;
> -	int i, uv;
> +	int i, align_volt;
>  
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  
> -	uv = dev_pm_opp_get_voltage(opp);
> +	align_volt = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
>  	dev_pm_opp_put(opp);
>  
>  	for (i = td->lut_bottom; i < td->lut_size; i++) {
> -		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)
> +		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_volt)
>  			return i;
>  	}
>  
> @@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
>   */

These 2 functions are only valid for I2C mode. We should probably add a
WARN_ON() in case they are called when PWM mode is used and return
-EINVAL.

>  static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_volt, align_volt;
>  
> +	align_volt = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> -		if (reg_uV < 0)
> +		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
> +				td->soc->alignment.step_uv;
> +		if (reg_volt < 0)
>  			break;
>  
> -		if (uV == reg_uV)
> +		if (align_volt == reg_volt)
>  			return i;
>  	}
>  
> @@ -1554,15 +1556,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>   * */
>  static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_volt, align_volt;
>  
> +	align_volt = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> -		if (reg_uV < 0)
> +		reg_volt = regulator_list_voltage(td->vdd_reg, i) /
> +				td->soc->alignment.step_uv;
> +		if (reg_volt < 0)
>  			break;
>  
> -		if (uV <= reg_uV)
> +		if (align_volt <= reg_volt)
>  			return i;
>  	}
>  
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
