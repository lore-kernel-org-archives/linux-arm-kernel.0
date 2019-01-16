Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5920AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F85620866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ke/MqQ8D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k+icA/Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F85620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vcUZwEpDG6UMmVDHIy/9TByr5heWZlb1utKRN3jCbqo=; b=Ke/MqQ8D3/ob67
	f3W/NEsIuDBwbNGW+69erMwR+JEvSGhfH9ClnSPPLtPRNMvJVBFjIxiglCTKJzMpXx9Mp5OkeRFiX
	aoEXGDOk348x/Ig/iUoqx+zjjY2NoG46KpmQhSpukOTP0CsxRV0HiMZ0WN43/zdULI3BIt32HMRVz
	aHczs/T+0UHLvaZNzOkLlmmgRryH/9bzaLziyMP2XyNWbODeBC2yIVSSOxL43zyMwrpZ/LleoVt2m
	znjoWR9DLBbsdKb0RU/xdi7cXwOz+ZumLIuBYzLPJZaOxu06RjP0BKxXMtfkoGvZIEclkesPzVmGt
	WZJ8s4Zx4N1sF6E4DQzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhRQ-0007yY-2E; Wed, 16 Jan 2019 09:24:56 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhRM-0007y8-C0
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:24:53 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G9OgYk114666;
 Wed, 16 Jan 2019 03:24:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547630682;
 bh=zTEf94y7Pk91M30bP8XHMSqFsjsx9kY46i1CHS2lbgg=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=k+icA/Zj7QQVoYnzg3E7ICK3VMtIB5/3/Ixh5uW/+Ra4B11fG95aQDbyVYlrGSSsI
 tPU36SWgrLs9MCIkZfV3WPR5g79h+gsYWfEh8noVXBD4i75CSgzvJXUCjuTfE8EkpK
 pYpzXm0m2DT0n4JBeXKRKHjlvLVylCihx+4uun54=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G9Ogqc042086
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 03:24:42 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 03:24:42 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 03:24:42 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G9OcXd001184;
 Wed, 16 Jan 2019 03:24:38 -0600
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Andy Gross <andy.gross@linaro.org>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
 <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
Date: Wed, 16 Jan 2019 14:54:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_012452_452655_A2B5411A 
X-CRM114-Status: GOOD (  14.71  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Matt Wagantall <mattw@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 16/01/19 2:40 PM, Marc Gonzalez wrote:
> On 28/12/2018 17:05, Andy Gross wrote:
> 
>> On Fri, Dec 21, 2018 at 11:13:18AM +0100, Marc Gonzalez wrote:
>>
>>> The private copy of readl_poll_timeout is no longer needed.
>>> Use the implementation in iopoll.h instead.
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>
>> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
> Would this patch go through your tree or Kishon's tree?

I've merged this in phy -next.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
