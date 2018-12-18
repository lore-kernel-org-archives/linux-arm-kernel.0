Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB36217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hVr09Xwn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gjkl69hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB36217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wikQ1iobFjwvKCspzysZxrh2iRl2SdTA+huCUuzYit0=; b=hVr09XwnPlLTt8
	QYummho9teZ29EHS9AmsLVbkJiIlSeTCUDwVt1I0Lh3GSFWuOckSfqI06O5HjbmM7/FuiRql567eX
	H0v86fcKr/TrHcX95qE+u1GRCQ6fgf+nKM4w3Qc6aNo5kP+We5ZlcYfN8m7IeJsWlyQTtUn/8m8wd
	NeY429bo6InSQC6NpVa+OmhgfkgW5MIRgHCXKQS2KqzySQP7HWKZYaI9Nfr48efOMjTlJQ00cl4Et
	6dBsRc72IFiBHcdmYU6PAuaODsk3tySqIkrLbdUkoDFtDLbkJz1Zkn0dfRkXaZc2FKqp8NLlOQsxE
	RlLckVsM/+KQHYA948VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCG7-0002jT-NA; Tue, 18 Dec 2018 10:05:51 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCG3-0002gs-E5
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:05:50 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18c66b0000>; Tue, 18 Dec 2018 02:05:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 02:05:37 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 02:05:37 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:05:35 +0000
Subject: Re: [PATCH V3 09/20] clk: tegra: dfll: add CVB tables for Tegra210
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-10-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <431e6dcb-684f-91a3-debd-1553b956583e@nvidia.com>
Date: Tue, 18 Dec 2018 10:05:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218091232.23532-10-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545127531; bh=cjGLjn3INL2fXCGfU/JqSlcBzvmpz36+Dnz7+ea+aYM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Gjkl69hUuKga3RBOXlMxQ+5tnaMT70C1oY9TBeDqfdPljPBj0+zDs2I10crrSx6V+
 ZWVOoyqTNm6StGoPoFrGbnZjdMquviCrv5AQ3e2SxGyhBLQqjyo/7Gd5G+I7ziEKjI
 NG3OZQgv07gMLLIZYv/uGfOwXtj0G6MINyb1qsBOKHCw5gHdik17JKAic7EyLLdoNn
 zN5wP/Q/gfhyioO9pV4+Gx/YoZ4mPyxvxV4mrNGWAXDCEZ7LE+g3E0KnChhDRDSCtl
 JLJkh5DiGTfnZHlpsA0BlHj8l6HsfBTlEakSJccCIJd5GwrTFAmrLbF0Ld5A53F0ex
 MSDXxNmaF8o8Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_020547_487981_EC7D0B47 
X-CRM114-Status: GOOD (  16.35  )
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


On 18/12/2018 09:12, Joseph Lo wrote:
> Add CVB tables with different chip characterization, so that we can
> generate the customize OPP table that suitable for different chips with
> different SKUs.
> 
> The parameter 'tune_high_min_millivolts' is first time introduced in
> this patch, which didn't use in the DFLL driver for clock and voltage
> tuning before. It will be used later when DFLL in high voltage range.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V3:
>  - update the commit message for 'tune_high_min_millivolts' parameter
> *V2:
>  - no update
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 426 +++++++++++++++++++++
>  drivers/clk/tegra/cvb.h                    |   1 +
>  2 files changed, 427 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index e87f73957c6f..1fcad135ace0 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -88,6 +88,421 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>  	},
>  };
>  
> +static const unsigned long tegra210_cpu_max_freq_table[] = {
> +	[0] = 1912500000UL,
> +	[1] = 1912500000UL,
> +	[2] = 2218500000UL,
> +	[3] = 1785000000UL,
> +	[4] = 1632000000UL,
> +	[5] = 1912500000UL,
> +	[6] = 2014500000UL,
> +	[7] = 1734000000UL,
> +	[8] = 1683000000UL,
> +	[9] = 1555500000UL,
> +	[10] = 1504500000UL,
> +};
> +
> +#define CPU_CVB_TABLE \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{ 1007452, -23865, 370 } }, \
> +		{  306000000UL,	{ 1052709, -24875, 370 } }, \
> +		{  408000000UL,	{ 1099069, -25895, 370 } }, \
> +		{  510000000UL,	{ 1146534, -26905, 370 } }, \
> +		{  612000000UL,	{ 1195102, -27915, 370 } }, \
> +		{  714000000UL,	{ 1244773, -28925, 370 } }, \
> +		{  816000000UL,	{ 1295549, -29935, 370 } }, \
> +		{  918000000UL,	{ 1347428, -30955, 370 } }, \
> +		{ 1020000000UL,	{ 1400411, -31965, 370 } }, \
> +		{ 1122000000UL,	{ 1454497, -32975, 370 } }, \
> +		{ 1224000000UL,	{ 1509687, -33985, 370 } }, \
> +		{ 1326000000UL,	{ 1565981, -35005, 370 } }, \
> +		{ 1428000000UL,	{ 1623379, -36015, 370 } }, \
> +		{ 1530000000UL,	{ 1681880, -37025, 370 } }, \
> +		{ 1632000000UL,	{ 1741485, -38035, 370 } }, \
> +		{ 1734000000UL,	{ 1802194, -39055, 370 } }, \
> +		{ 1836000000UL,	{ 1864006, -40065, 370 } }, \
> +		{ 1912500000UL,	{ 1910780, -40815, 370 } }, \
> +		{ 2014500000UL,	{ 1227000,      0,   0 } }, \
> +		{ 2218500000UL,	{ 1227000,      0,   0 } }, \
> +		{          0UL,	{       0,      0,   0 } }, \
> +	}
> +
> +#define CPU_CVB_TABLE_XA \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{ 1250024, -39785, 565 } }, \
> +		{  306000000UL,	{ 1297556, -41145, 565 } }, \
> +		{  408000000UL,	{ 1346718, -42505, 565 } }, \
> +		{  510000000UL,	{ 1397511, -43855, 565 } }, \
> +		{  612000000UL,	{ 1449933, -45215, 565 } }, \
> +		{  714000000UL,	{ 1503986, -46575, 565 } }, \
> +		{  816000000UL,	{ 1559669, -47935, 565 } }, \
> +		{  918000000UL,	{ 1616982, -49295, 565 } }, \
> +		{ 1020000000UL,	{ 1675926, -50645, 565 } }, \
> +		{ 1122000000UL,	{ 1736500, -52005, 565 } }, \
> +		{ 1224000000UL,	{ 1798704, -53365, 565 } }, \
> +		{ 1326000000UL,	{ 1862538, -54725, 565 } }, \
> +		{ 1428000000UL,	{ 1928003, -56085, 565 } }, \
> +		{ 1530000000UL,	{ 1995097, -57435, 565 } }, \
> +		{ 1606500000UL,	{ 2046149, -58445, 565 } }, \
> +		{ 1632000000UL,	{ 2063822, -58795, 565 } }, \
> +		{          0UL,	{       0,      0,   0 } }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM1 \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{  734429, 0, 0 } }, \
> +		{  306000000UL,	{  768191, 0, 0 } }, \
> +		{  408000000UL,	{  801953, 0, 0 } }, \
> +		{  510000000UL,	{  835715, 0, 0 } }, \
> +		{  612000000UL,	{  869477, 0, 0 } }, \
> +		{  714000000UL,	{  903239, 0, 0 } }, \
> +		{  816000000UL,	{  937001, 0, 0 } }, \
> +		{  918000000UL,	{  970763, 0, 0 } }, \
> +		{ 1020000000UL,	{ 1004525, 0, 0 } }, \
> +		{ 1122000000UL,	{ 1038287, 0, 0 } }, \
> +		{ 1224000000UL,	{ 1072049, 0, 0 } }, \
> +		{ 1326000000UL,	{ 1105811, 0, 0 } }, \
> +		{ 1428000000UL,	{ 1130000, 0, 0 } }, \
> +		{ 1555500000UL,	{ 1130000, 0, 0 } }, \
> +		{ 1632000000UL,	{ 1170000, 0, 0 } }, \
> +		{ 1734000000UL,	{ 1227500, 0, 0 } }, \
> +		{          0UL,	{       0, 0, 0 } }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM2 \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{  742283, 0, 0 } }, \
> +		{  306000000UL,	{  776249, 0, 0 } }, \
> +		{  408000000UL,	{  810215, 0, 0 } }, \
> +		{  510000000UL,	{  844181, 0, 0 } }, \
> +		{  612000000UL,	{  878147, 0, 0 } }, \
> +		{  714000000UL,	{  912113, 0, 0 } }, \
> +		{  816000000UL,	{  946079, 0, 0 } }, \
> +		{  918000000UL,	{  980045, 0, 0 } }, \
> +		{ 1020000000UL,	{ 1014011, 0, 0 } }, \
> +		{ 1122000000UL,	{ 1047977, 0, 0 } }, \
> +		{ 1224000000UL,	{ 1081943, 0, 0 } }, \
> +		{ 1326000000UL,	{ 1090000, 0, 0 } }, \
> +		{ 1479000000UL,	{ 1090000, 0, 0 } }, \
> +		{ 1555500000UL,	{ 1162000, 0, 0 } }, \
> +		{ 1683000000UL,	{ 1195000, 0, 0 } }, \
> +		{          0UL,	{       0, 0, 0 } }, \
> +	}
> +
> +#define CPU_CVB_TABLE_EUCM2_JOINT_RAIL \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{  742283, 0, 0 } }, \
> +		{  306000000UL,	{  776249, 0, 0 } }, \
> +		{  408000000UL,	{  810215, 0, 0 } }, \
> +		{  510000000UL,	{  844181, 0, 0 } }, \
> +		{  612000000UL,	{  878147, 0, 0 } }, \
> +		{  714000000UL,	{  912113, 0, 0 } }, \
> +		{  816000000UL,	{  946079, 0, 0 } }, \
> +		{  918000000UL,	{  980045, 0, 0 } }, \
> +		{ 1020000000UL,	{ 1014011, 0, 0 } }, \
> +		{ 1122000000UL,	{ 1047977, 0, 0 } }, \
> +		{ 1224000000UL,	{ 1081943, 0, 0 } }, \
> +		{ 1326000000UL,	{ 1090000, 0, 0 } }, \
> +		{ 1479000000UL,	{ 1090000, 0, 0 } }, \
> +		{ 1504500000UL,	{ 1120000, 0, 0 } }, \
> +		{          0UL,	{       0, 0, 0 } }, \
> +	}
> +
> +#define CPU_CVB_TABLE_ODN \
> +	.speedo_scale = 100,	\
> +	.voltage_scale = 1000,	\
> +	.entries = {		\
> +		{  204000000UL,	{  721094, 0, 0 } }, \
> +		{  306000000UL,	{  754040, 0, 0 } }, \
> +		{  408000000UL,	{  786986, 0, 0 } }, \
> +		{  510000000UL,	{  819932, 0, 0 } }, \
> +		{  612000000UL,	{  852878, 0, 0 } }, \
> +		{  714000000UL,	{  885824, 0, 0 } }, \
> +		{  816000000UL,	{  918770, 0, 0 } }, \
> +		{  918000000UL,	{  915716, 0, 0 } }, \
> +		{ 1020000000UL,	{  984662, 0, 0 } }, \
> +		{ 1122000000UL,	{ 1017608, 0, 0 } }, \
> +		{ 1224000000UL,	{ 1050554, 0, 0 } }, \
> +		{ 1326000000UL,	{ 1083500, 0, 0 } }, \
> +		{ 1428000000UL,	{ 1116446, 0, 0 } }, \
> +		{ 1581000000UL,	{ 1130000, 0, 0 } }, \
> +		{ 1683000000UL,	{ 1168000, 0, 0 } }, \
> +		{ 1785000000UL,	{ 1227500, 0, 0 } }, \
> +		{          0UL,	{       0, 0, 0 } }, \
> +	}
> +
> +struct cvb_table tegra210_cpu_cvb_tables[] = {
> +	{
> +		.speedo_id = 10,
> +		.process_id = 0,
> +		.min_millivolts = 840,
> +		.max_millivolts = 1120,
> +		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 10,
> +		.process_id = 1,
> +		.min_millivolts = 840,
> +		.max_millivolts = 1120,
> +		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 9,
> +		.process_id = 0,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1162,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 9,
> +		.process_id = 1,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1162,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 8,
> +		.process_id = 0,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1195,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 8,
> +		.process_id = 1,
> +		.min_millivolts = 900,
> +		.max_millivolts = 1195,
> +		CPU_CVB_TABLE_EUCM2,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 7,
> +		.process_id = 0,
> +		.min_millivolts = 841,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_EUCM1,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 7,
> +		.process_id = 1,
> +		.min_millivolts = 841,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_EUCM1,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 6,
> +		.process_id = 0,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1150,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 6,
> +		.process_id = 1,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1150,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +		}
> +	},
> +	{
> +		.speedo_id = 5,
> +		.process_id = 0,
> +		.min_millivolts = 818,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 5,
> +		.process_id = 1,
> +		.min_millivolts = 818,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 4,
> +		.process_id = -1,
> +		.min_millivolts = 918,
> +		.max_millivolts = 1113,
> +		CPU_CVB_TABLE_XA,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x17711BD,
> +		}
> +	},
> +	{
> +		.speedo_id = 3,
> +		.process_id = 0,
> +		.min_millivolts = 825,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_ODN,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 3,
> +		.process_id = 1,
> +		.min_millivolts = 825,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE_ODN,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 2,
> +		.process_id = 0,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +		}
> +	},
> +	{
> +		.speedo_id = 2,
> +		.process_id = 1,
> +		.min_millivolts = 870,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +		}
> +	},
> +	{
> +		.speedo_id = 1,
> +		.process_id = 0,
> +		.min_millivolts = 837,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 1,
> +		.process_id = 1,
> +		.min_millivolts = 837,
> +		.max_millivolts = 1227,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 0,
> +		.process_id = 0,
> +		.min_millivolts = 850,
> +		.max_millivolts = 1170,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x20091d9,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +	{
> +		.speedo_id = 0,
> +		.process_id = 1,
> +		.min_millivolts = 850,
> +		.max_millivolts = 1170,
> +		CPU_CVB_TABLE,
> +		.cpu_dfll_data = {
> +			.tune0_low = 0xffead0ff,
> +			.tune0_high = 0xffead0ff,
> +			.tune1 = 0x25501d0,
> +			.tune_high_min_millivolts = 864,
> +		}
> +	},
> +};
> +
>  static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
>  	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
>  	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
> @@ -95,11 +510,22 @@ static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
>  	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
>  };
>  
> +static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
> +	.cpu_max_freq_table = tegra210_cpu_max_freq_table,
> +	.cpu_max_freq_table_size = ARRAY_SIZE(tegra210_cpu_max_freq_table),
> +	.cpu_cvb_tables = tegra210_cpu_cvb_tables,
> +	.cpu_cvb_tables_size = ARRAY_SIZE(tegra210_cpu_cvb_tables),
> +};
> +
>  static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
>  	{
>  		.compatible = "nvidia,tegra124-dfll",
>  		.data = &tegra124_dfll_fcpu_data,
>  	},
> +	{
> +		.compatible = "nvidia,tegra210-dfll",
> +		.data = &tegra210_dfll_fcpu_data
> +	},
>  	{ },
>  };
>  
> diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
> index bcf15a089b93..91a1941c21ef 100644
> --- a/drivers/clk/tegra/cvb.h
> +++ b/drivers/clk/tegra/cvb.h
> @@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
>  	u32 tune0_low;
>  	u32 tune0_high;
>  	u32 tune1;
> +	unsigned int tune_high_min_millivolts;
>  };
>  
>  struct cvb_table {
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
