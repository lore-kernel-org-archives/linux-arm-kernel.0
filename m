Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46489C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DC220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r24VfHTD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XPYzD7Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DC220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=obu+qDjK3N1CEbmHEqD/1YSxmNy+AAJtbN7bq6AIrJw=; b=r24VfHTD7/SI9WFEadRB55jie
	MXRPqUV9R7HLmfaelikRnbxpLUv9b6MSCw6xTj1TK1p8iCphgTaO5iiyUeKnBhgmH0bmu3zyO5ewy
	OVINQmwaB4UdP5hYs97AZ+YsGlshv7mBOSTmaA6CEQ6pc5vQCn+eN6t8/rBHowssnVXBZqTyzL4Rf
	eSsAjjJZ3BgaT721Z/yF2trh0SDrNGSOgRUK5VJjL6TpFyQ8vyO2+smYu9pZRzibFPQe6H7aOnEDv
	V65nc7bW5cEdRU2vY1d6RQYSLyu9JgU2PyaM7cY8ZhLP24DCjbVQe2KsHP3sz8+tYKATn5NeJsV1/
	5wLaruC2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXi8P-00071K-OH; Fri, 14 Dec 2018 07:43:45 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXi8M-00070r-TU
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:43:44 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c135f1e0001>; Thu, 13 Dec 2018 23:43:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 23:43:32 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 23:43:32 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 07:43:30 +0000
Subject: Re: [PATCH V2 10/21] clk: tegra: dfll: add CVB tables for Tegra210
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-11-josephl@nvidia.com>
 <8fda3564-ab10-bb24-6d2a-6bd26358fe88@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <9f0d08e3-a87a-2e85-e0d2-49ab25afc109@nvidia.com>
Date: Fri, 14 Dec 2018 15:43:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8fda3564-ab10-bb24-6d2a-6bd26358fe88@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544773406; bh=5wYnr7yEhYR4g6GmiiEkncHydhAlqpHLiDLTCGqIwfg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=XPYzD7UcEiEy+m8ipS2Iah9DUl+b1vdFYPrhpAsYnK7iwb9PAURGNA+7cd1vom41k
 VtatzybBSbEVc3m2e8BOWJ5xhKSjDtxRzvdkRKF+tQmK8Y/erjf8nUHPbMSjrlks2t
 vwhYVujGuD9RnL4WRsPWHdtyMsKz+/qRfe6a/TP3LMRNDRwwTUneuqlupvuqyJKFwK
 gqy6MJdPBMx4SVVb7pNFPnFpjEfgjLgsYig8MflUtcZ40Qbs9zDqh0C5rDtSPw8PZW
 AK8DfT4jswF6JtldzsYTYc8BY79gD16KuiyWsSlZ6bXDrTHrY0nl2+F+PfY0DPNT8r
 NRm4oxbY6RLwA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_234342_953451_677E6059 
X-CRM114-Status: GOOD (  14.70  )
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

On 12/13/18 8:50 PM, Jon Hunter wrote:
> 
> On 13/12/2018 09:34, Joseph Lo wrote:
>> Add CVB tables with different chip characterization, so that we can
>> generate the customize OPP table that suitable for different chips with
>> different SKUs.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> 
> ...
> 
>> diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
>> index bcf15a089b93..91a1941c21ef 100644
>> --- a/drivers/clk/tegra/cvb.h
>> +++ b/drivers/clk/tegra/cvb.h
>> @@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
>>   	u32 tune0_low;
>>   	u32 tune0_high;
>>   	u32 tune1;
>> +	unsigned int tune_high_min_millivolts;
>>   };
> 
> Sorry, I forgot to respond to this on the previous version. I think that
> it is OK to add now, but please add a comment in the changelog to
> reflect that this is not currently used, but we have plans to use it and
> so we are adding all the data now.

Okay, will do. Thanks.

> 
> Cheers
> Jon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
