Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB39420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPM+kNce";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YhubCNfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB39420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f5Agf4mFlZfgSudLb/yjcuwG9OjlusciV8/i75v3ngE=; b=jPM+kNcew0Zqvq
	J2d2oiq35YTHtsXYvBCGAYDlQJ0JP+BmOxrx8/ESBOeb4TGQFRBuitDpDUCRpmWyyAR+tTUg5RRdq
	8qNPsvFZxz8JNh533pEKVFU4VR+v0Jol9iu0rBbj+DbcwPscXQNek4T/BEussnjAz5Urhc6LLHJtM
	+vyjqYQLVUhz9Mhm9QO//x097IhTsf/xcUVrItiGk/+FNm4orLSQnxl2HPvf0kxcwUtbPGh6QdNuF
	/d8XggtOwZpzj83qjRLkzAWwK4yoOZb7+Mz5FI+law3rnyIdyc7qbkcmgeYkgmuY1A6XmuR4S2Sm+
	ol60c3wv3hvqx/8d/WdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKG9-0005Rn-1n; Mon, 10 Dec 2018 12:02:01 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKG5-0005RM-7w
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:01:58 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAC1arI059664;
 Mon, 10 Dec 2018 06:01:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544443296;
 bh=BXSauysFtSHnUqgxpsB1VhuLgfyEVffNcruP+e9gkxI=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=YhubCNfbyD1LX6Gt+wYdzYEEqgeP8eq59x8ogkEHljSdyEtlQZFJ+VnttMRbANDlG
 ln1AmbX3MQnsAhY6KZJ/bijVuq11cmYHXzPxRVF7AB9Uhu92sZWyDJHyVaYjW/cjXo
 08zK4BTRIGFz+fAO0Mlm7tJPndssmZd5Kvbwv5dg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAC1atT050620
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 06:01:36 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 06:01:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 06:01:36 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAC1WIF025102;
 Mon, 10 Dec 2018 06:01:33 -0600
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Add Initial Support for AM654 SDHCI
 driver
To: Adrian Hunter <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-4-faiz_abbas@ti.com>
 <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
 <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
 <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <94794998-2c22-1b7f-946c-7887116ee55b@ti.com>
Date: Mon, 10 Dec 2018 17:34:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <970c3531-5d7d-fe94-55c1-13603735b43a@intel.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040157_362922_0AB82BEA 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
 michal.simek@xilinx.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Adrian,

On 07/12/18 7:02 PM, Adrian Hunter wrote:
> On 5/12/18 5:07 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 05/12/18 7:12 PM, Adrian Hunter wrote:
>>> On 29/11/18 6:15 PM, Faiz Abbas wrote:
>>>> The host controllers on TI's AM654 SOCs are not compatible with
>>>> the phy and consumer model of the sdhci-of-arasan driver. It turns out
>>>> that for optimal operation at higher speeds, a special tuning procedure
>>>> needs to be implemented which involves configuration of platform
>>>> specific phy registers.
>>>>
>>>> Therefore, branch out to a new sdhci_am654 driver and add the phy
>>>> register space with all phy configurations to it. Populate AM654
>>>> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
>>>> applicable.
>>>>
>>>> Only add support for upto High Speed for SD card and upto DDR52 speed
>>>> mode for eMMC. Higher speeds will be added in subsequent patches.
>>>>
...
>>>> +
>>>> +	sdhci_am654->clk_ahb = devm_clk_get(dev, "clk_ahb");
>>>> +	if (IS_ERR(sdhci_am654->clk_ahb)) {
>>>> +		dev_err(dev, "clk_ahb clock not found.\n");
>>>> +		ret = PTR_ERR(sdhci_am654->clk_ahb);
>>>> +		goto err_pltfm_free;
>>>> +	}
>>>
>>> Did you intend not to enable clks?
>>
>> Yes. Clocks get enabled as a part of pm_runtime calls.
> 
> Ok, but that could use an explanatory comment.  Also why get a reference to
> clk_ahb if that reference is never used?
> 

You're right. It was being used in sdhci-of-arasan because other users
needed to call enable() and disable(). I missed out on removing it when
porting over. Will remove it and add the comment.

Thanks,
Faiz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
