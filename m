Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BBDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37999207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNX1qAAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37999207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zk+DLHkoCPV+M6/7OYOFFxXSM/ZGTELZDJdTmVpSvV8=; b=WNX1qAARdkWidb
	ilwJ7p3YggAGrhGQLU56Es5TnrCDT3YeNTOeM8fK6wNHNAsOpxXy4IpJsD8PgCgSnRszqtbSZBZg9
	Yzd5ZpZXvStcYDseStqNowkM0zjC6MScdaYsxr51rRmOUaFf9Md4MJUoo1y1QY7Qrxkpd0BBgV/Pe
	pL+oQ2lXtj7rd/tow/DPemFhNgmMF+Z0DW7VGC4sH7cVxrW3TD465jURMO+SI3j00hNdZkWL0Z/j5
	VwcUpMxW63Pt3hlKNQ0Srbtu4Zo3FRTXuG7FWyuTVLWYY+mudHLhjvpNS5Yr6mohlfCp+KoHRxtVi
	NNkRMvA18QwyIekAP9Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcCd-0004nE-Id; Mon, 04 Feb 2019 11:14:15 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqcCZ-0004mq-Pe
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:14:13 +0000
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 16F9EB29205BDD3E156C;
 Mon,  4 Feb 2019 11:14:06 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML712-CAH.china.huawei.com
 (10.201.108.35) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Feb 2019
 11:14:04 +0000
Subject: Re: [PATCH v2] arm64: dts: hikey: Give wifi some time after power-on
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <e944650d-514f-3727-2e68-b318aab9ee7f@web.de>
 <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
 <CAPDyKFqYWGv7bWW7rcCYhc-PdmRCBdskUTycFxK25VQgd0TWeg@mail.gmail.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <6f4f342e-0b14-9344-c11b-e81f643cc45b@hisilicon.com>
Date: Mon, 4 Feb 2019 11:13:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqYWGv7bWW7rcCYhc-PdmRCBdskUTycFxK25VQgd0TWeg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_031411_975513_E4DA557B 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: Ryan Grachek <ryan@edited.us>, Tony Lindgren <tony@atomide.com>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "stable #4 . 17+" <stable@vger.kernel.org>, "Reizer, 
 Eyal" <eyalr@ti.com>, John
 Stultz <john.stultz@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ulf,

On 2/4/2019 6:06 AM, Ulf Hansson wrote:
> On Fri, 1 Feb 2019 at 17:34, Wei Xu <xuwei5@hisilicon.com> wrote:
>>
>> Hi Jan,
>>
>> On 1/24/2019 7:52 AM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Somewhere along recent changes to power control of the wl1835, power-on
>>> became very unreliable on the hikey, failing like this:
>>>
>>> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
>>> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
>>>
>>> After playing with some dt parameters and comparing to other users of
>>> this chip, it turned out we need some power-on delay to make things
>>> stable again. In contrast to those other users which define 200 ms, the
>>> hikey would already be happy with 1 ms. Still, we use the safer 10 ms,
>>> like on the Ultra96.
>>>
>>> Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Applied to the hisilicon soc dt tree.
> 
> Wei, can you please also add a stable tag to it?

Yes, added below tag into this patch.
	Cc: <stable@vger.kernel.org> #4.12+

Thanks for your kindly reminder :)

Best Regards,
Wei

> 
> [...]
> 
> Thanks and kind regards
> Uffe
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
