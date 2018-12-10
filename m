Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9C2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jRJGI4Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/PDFqCqct3MJctLUieCBqlRVs0lios1Po9Vvjij6OI=; b=jRJGI4Yi+9S/2y
	kYDqopKOGx4hc+T7t0RetZ67BDgoP298yCEJ1Vc5xaA5Kj/PVlYCvZelyXSUUJt9K65prnm0uOpKF
	B4Dz/0EtX5hwU3S/JNurVIOanRcYVR14TKSO3HCujfxrPlC9Sk07b7NThW4HYkJlzIhFcp51hBvoc
	CV9VRGrMx9KmkAqGgoyXwfdK19wDZ7XCJaFKDDU8v+CK7bifWeUI7nZlgO+jOY8XLMsbVdG5gkdEI
	Oh7v+DUQ9rgPJUgV0WLDuzXBhs3CA6MoY85DVAk5iXlKGF2GRWaJr7HBlv1K9wpZWc3NxEs7FHjPa
	2tvOoC2y5JMBt5cf6e3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWFnp-0006R3-CB; Mon, 10 Dec 2018 07:16:29 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWFnl-0006Pf-7j; Mon, 10 Dec 2018 07:16:27 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0FE1A897E95B;
 Mon, 10 Dec 2018 15:16:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 15:16:01 +0800
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
To: Lee Jones <lee.jones@linaro.org>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
 <20181210061557.GL26661@dell>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
Date: Mon, 10 Dec 2018 15:16:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181210061557.GL26661@dell>
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_231625_450303_9B2820A6 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
 matthias.bgg@gmail.com, chen.zhong@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018/12/10 14:15, Lee Jones wrote:
> On Sun, 09 Dec 2018, YueHaibing wrote:
> 
>> Remove duplicated include.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
>> index 02c67a1..5027ebb 100644
>> --- a/drivers/input/keyboard/mtk-pmic-keys.c
>> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
>> @@ -19,7 +19,6 @@
>>  #include <linux/input.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/kernel.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/regmap.h>
> 
> You are removing the wrong one.

No, linux/kernel.h is a duplicated include indeed.

> 
> Please convert this patch's main intent to alphabetise the header
> files.  Then you can remove any obvious duplicates.

I can alphabetize it in v2 if need be.

> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
