Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:06:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ABE2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DqcV1GPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ABE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u2NOC2QxmZce4kqVEdcsF8CE5/FDSH3q624U0jYqABM=; b=DqcV1GPfgrXN9D
	fMnrLzIExHWyP1P3IBgjFZ5lbrcK3hldc7JvyVfIdHiPCphZ6DMRlnGvQIgdMkUdcg3eVlUmaWl3Z
	kSvs+aUBNA0obnkbD+sxfFHzHQtWl054UtZaoLXzVGRw5SGOC8WHzOT0q36nqS2X/9WdxvmCDzqJi
	76rdQlL7ZtWv8Kc1MsjIgUBMfuaFKrwksCPkzffYWIiaeA5uTJOzZd32z/J7PkhIkCJvBsbhyP1By
	n9J4qGGsZCCLMvHzp0FUalfrUtVx1c+KM98mBYpkENI01xMuGipHZimvgpFMTuvSBEm8XobvPlbgV
	1YNesUTS8+ntsrkbWkrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geztV-0001Ds-EJ; Thu, 03 Jan 2019 10:06:29 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geztQ-0001D5-SH
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:06:26 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x03A5pUP026214; Thu, 3 Jan 2019 11:06:10 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pp0pm2g0m-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 03 Jan 2019 11:06:10 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 23FB63A;
 Thu,  3 Jan 2019 10:06:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 023122D44;
 Thu,  3 Jan 2019 10:06:08 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Jan
 2019 11:06:07 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 3 Jan 2019 11:06:07 +0100
From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
To: Wei Yongjun <weiyongjun1@huawei.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH -next] hwspinlock: fix return value check in
 stm32_hwspinlock_probe()
Thread-Topic: [PATCH -next] hwspinlock: fix return value check in
 stm32_hwspinlock_probe()
Thread-Index: AQHUozFhUmwfXgVOYU2bQM/ijfjZWKWdQLyA
Date: Thu, 3 Jan 2019 10:06:07 +0000
Message-ID: <16205f0c-3514-731c-e948-38695e3a525d@st.com>
References: <1546498950-105456-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1546498950-105456-1-git-send-email-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-ID: <B213CA72774C404EA4CE4C6288AC3697@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_020625_197127_2922A5AC 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 1/3/19 8:02 AM, Wei Yongjun wrote:
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Fixes: f24fcff1d267 ("hwspinlock: add STM32 hwspinlock device")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@gmail.com>
> ---
>   drivers/hwspinlock/stm32_hwspinlock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> index 34a8e00..4418392 100644
> --- a/drivers/hwspinlock/stm32_hwspinlock.c
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -57,8 +57,8 @@ static int stm32_hwspinlock_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	io_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!io_base)
> -		return -ENOMEM;
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
>   
>   	array_size = STM32_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
>   	hw = devm_kzalloc(&pdev->dev, sizeof(*hw) + array_size, GFP_KERNEL);
>
>
>
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
