Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20A120849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkHpij5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20A120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mj7nawP/tCwxNiG3k61NlPgcwN/9fhD8vjWHBbsZ+Ow=; b=VkHpij5EybDi4o
	3T+ooGklv1hxlGq+oXc4DyZRzGBhN8JkjWv4G8E9arWRiJ6luFAn7bcBI4ZptFXJ7e+2vry9I+tQR
	rGjI2OQ5lyf2ekqzxiEP4kMX42zFcpUht80islqZa/4Qk2dIM1XZilRBz9HP74qDJOIrJ+Qfl484S
	ZZbgBe3+BoM/5veW6UARj7P7ItSRuzav3O50wQaeup+7CnPP1E2sfobtpW4IOFv/f4CQ7vtWZGZnC
	9qTrV1DKU5/bl2MkJ+07WyyUWgkx2LGD/32zZMavyAEdcJd9KnWdP4b37j1zA0C67IwdID0M7UaSo
	V2d7WqrdPgS6okidNsvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhaX-0004kC-1p; Tue, 11 Dec 2018 12:56:37 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhaT-0004jY-7J
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:56:34 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9AF6413F8B3;
 Tue, 11 Dec 2018 13:56:00 +0100 (CET)
Subject: Re: ufs_qcom_dump_dbg_regs makes the kernel panic
To: Robin Murphy <robin.murphy@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>, 
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
References: <78a1b262-d366-a3d3-12ce-1a813444b6a7@free.fr>
 <0f4cac25-3936-adc8-d8b5-c131dea4b93c@arm.com>
 <338058cc-b040-3c9a-ec31-d15157535dcc@free.fr>
 <2aaa187e-c612-097c-cbb1-fdb46753eb8b@free.fr>
 <d63ae914-f71e-4382-53e4-b024abe84dc0@arm.com>
 <abb48910-00a0-3e35-be2a-446b8cef6d9b@free.fr>
 <3cdf06ea-e37f-bd2c-517e-f58c015e59ec@arm.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <bb662bad-d103-d51f-7ee6-f273d0b695e5@free.fr>
Date: Tue, 11 Dec 2018 13:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3cdf06ea-e37f-bd2c-517e-f58c015e59ec@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_045633_415853_87B104F7 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 12:56, Robin Murphy wrote:

> On 11/12/2018 10:48, Marc Gonzalez wrote:
>
>> Looks like the UFS debug code might be smashing memory it doesn't own?
>> I'm kinda puzzled right now. I'll keep digging.
>> Are there debug options that might help figuring things out? UBSAN?
> 
> Oh, that does rather look like something stomping all over the slab 
> allocator. I'd start with CONFIG_KASAN and CONFIG_SLUB_DEBUG_ON to to 
> catch any obvious out-of-bounds/use-after-free/double-free conditions.

Thanks for pointing out CONFIG_KASAN, which instantly allowed me to
pinpoint the obvious bug... in my own code!

Doooh! My initial "replace memcpy_fromio" patch is garbage. I'll send
a correct patch in a few minutes.

I am (again) in your debt :-)

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
