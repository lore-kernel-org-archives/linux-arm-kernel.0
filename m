Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71895C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ED220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fZQVF5mU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WLS4IsIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ED220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UfC8Wsn/TQRwrMIOD+Vom0piZZjBRBQNTjPkzHbX3Yg=; b=fZQVF5mU6GNQnO1TDpcXhmAyt
	s3vaPA0XgU8qmXQCC4FnXFMjYmMPDVPB0nA0g567jFmOaCim3ZmEtkBeIOLmBc6/jC099mx5prs7F
	4oGA1R6MELapbVd4ckq9y8FYrcM8mxHpj4XjYqO5D16WlFh4h2YWqUKHo19NofMpidf1Yq2ezasWv
	tF23O7Cx6BrkxRG4kUH1QU5xn3qcBdV04tgd2+xjfCryNKrNCDEWfgdG1YAnH1XsZhufIKJoEVKXT
	h+mq4BoMoahUkOeeGTETmrl+a+HYWXbXK9P3+GSdpubY6pAoI4/q2IJ/rcMUmdQeznN2IpsJEh6Lp
	Xnzudvhdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcZ3-0004SZ-Db; Tue, 11 Dec 2018 07:34:45 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcZ0-0004Rf-0n
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:34:43 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f68820000>; Mon, 10 Dec 2018 23:34:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 23:34:29 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 23:34:29 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 07:34:28 +0000
Subject: Re: [PATCH 09/19] clk: tegra: dfll: add CVB tables for Tegra210
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-10-josephl@nvidia.com>
 <61658127-d299-013a-d745-47a648f7a4cf@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <dcd13c46-423c-f03a-5df2-70316c5d21c9@nvidia.com>
Date: Tue, 11 Dec 2018 15:34:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <61658127-d299-013a-d745-47a648f7a4cf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544513666; bh=DhaqXg0IOhKzcg7WyHQ+l5cF1HbQychcErzd3myxPHM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=WLS4IsIH8k0xY9kRmIWGtsX8y5ra/XMmQcec2N415MAYUHyQvGAc/AuscMssIITrZ
 Dpau8PkSWLuvSrd9T1wB9yzlXyeh5Y9w4/teP++ejQ9jrJYCUyee15EpIGS3wIo4oG
 ONDWTpe0m1NBu+iXlg7yohnL94HgHgXnM1wNzVwpZMpqc+RhijMD+XPNWmZm2ZqoNt
 +Iok16g95G/SbpzrZXn5mGHIlPSviYJXUMVs+9IqWfNo/EyfoUWQvQ7TiTgaSMP+C4
 RT+8I6a8XAJRXKBAElxggGRw4rDuEsKk5lxzPdEh9tBiTFXXvdOyFaA6bq326rTUPj
 i7vjLb9RKfiWg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_233442_075351_1C9E83BA 
X-CRM114-Status: GOOD (  12.58  )
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

On 12/7/18 10:39 PM, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
>> Add CVB tables with different chip characterization, so that we can
>> generate the customize OPP table that suitable for different chips with
>> different SKUs.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 426 +++++++++++++++++++++
>>   drivers/clk/tegra/cvb.h                    |   1 +
>>   2 files changed, 427 insertions(+)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> index 071a5c674832..bc1358d8084b 100644
>> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
>> @@ -88,6 +88,421 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>>   	},
>>   };
>>   
snip.
>>   
>> diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
>> index bcf15a089b93..91a1941c21ef 100644
>> --- a/drivers/clk/tegra/cvb.h
>> +++ b/drivers/clk/tegra/cvb.h
>> @@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
>>   	u32 tune0_low;
>>   	u32 tune0_high;
>>   	u32 tune1;
>> +	unsigned int tune_high_min_millivolts;
> 
> Where is this actually used?

It's just part of the initial CVB table. We don't have the dynamic 
tunning support yet that will use this tune parameter for output freq 
tunning. It's on my plan of the next series for DFLL enhancement.

Should I remove that from the table?

Thanks,
Joseph



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
