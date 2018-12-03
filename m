Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE387C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8842081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZGPAbc4S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MGdnQmSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8842081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tzx2a0KN+ZJHWw+dPVmysGo24nQIjcDa28bKGTEUsrA=; b=ZGPAbc4SLci45U
	7QrWP/dqMWI8qy0cYhaKutPnop4s7oQxd6l20Yx/NV16VskTzOav0md/6pKOacTJAN12eSuRWwFJX
	+oxrUB05EOa/qMSancZ5ZduqUjwqsiMbBmnKSlSoHm0NtFUl9MFTqV9OUexyr1TYyLAKIw117E/aS
	MywocgAPiuFOVOv2atA3F9Acbq2B78l09tBJJ/zcxCxjJAC06/DhC+aG+hwt6Alh0POPT6I48MJpv
	ZYv9P4Gc0dNLPCyoBmbMEgi1yWvixjMN0q7wvtZ6EKi28ykqdysuD9T4PA/KrF33ymJrkhoBQl32i
	BBTKprpZhklKN9xN6deg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjAT-0005Pu-Ux; Mon, 03 Dec 2018 08:01:25 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjAQ-0005P2-Of
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:01:24 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3814CM103384;
 Mon, 3 Dec 2018 02:01:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1543824064;
 bh=FJxEOqIxrfdFtne8qvaYFf+/d98SHkdkTN9dmmSKMDc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=MGdnQmSIrarWx+Y+blfk5j4uuRRJfvKvyc+TJ9zOeL+jnjIk7hHNgIvmFPm9f3YZ3
 m2WoQUTbhzFZi437/lkZus93EkI74B0r91IW2zfY2WnbuPVDf18waazolHszB2tZWG
 IK5OfLdWW2Y+NsxOEBTzdmQk5X7sHz56tRcx69vE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3814Nb053618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 02:01:04 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 02:01:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 02:01:04 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB38105a007973;
 Mon, 3 Dec 2018 02:01:01 -0600
Subject: Re: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am654
To: Michal Simek <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-3-faiz_abbas@ti.com>
 <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <e431f6f8-3c8d-3540-3d21-d3e9aa292574@ti.com>
Date: Mon, 3 Dec 2018 13:33:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6f4734e6-8238-2e14-ae11-114e396df75c@xilinx.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_000122_917316_DFB8F7BA 
X-CRM114-Status: GOOD (  18.69  )
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
 adrian.hunter@intel.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Michal,

On 30/11/18 12:48 PM, Michal Simek wrote:
> On 29. 11. 18 17:15, Faiz Abbas wrote:
>> The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
>> this by a deprecated message.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index e2effe17f05e..1edbb049cccb 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -16,6 +16,10 @@ Required Properties:
>>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>>      - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>> +	Note: This binding has been deprecated and moved to [5].
>> +
>> +  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>> +
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>
> 
> I would prefer if you can extend commit message by description you have
> in cover letter which explains reasons. When this is applied and someone
> look at git history none will understand from first read why you have
> done that.
> 

Ok. Will add full explanations to both documentation patches.

Thanks,
Faiz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
