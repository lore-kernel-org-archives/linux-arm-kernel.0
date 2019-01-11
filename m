Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B631FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FEC2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FewHUhAP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wq/c5agS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FEC2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e1G209OI8+spo7s/Jh/jIO1rB8ufgOpynfkyZBjOjpg=; b=FewHUhAPQwQ1oN
	yKPMAFwr3nsqfHForoCNCiD6Yyeg9K+i/V//dO1RNFaxhf57Q4Vy+izxJ9CByGjk+b5kKjPz4ztp6
	CR3ABHVsGkrw7eMaMNBX72tktTcEjDF0/5l2cpKRZDVw8+owUtH1n70nc8pE+sG0COsJopefSc54P
	68lI+bCyvkiHEAF++195/qS+AeUCk/8/0Qatx9v6zuSeDHA8NyADZbKb4tXvhZYrVMokOW6y6f3Ry
	1o2J+qDpOkPQAHPjPjAWWwslFG6e7tCr+mR1s/e82FxfzStUpOPxu8H7si2QdwjPvl+8CR794Ul8x
	sMKXzz1aSWBRPk/Poh4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuU4-0003nO-Qg; Fri, 11 Jan 2019 10:56:16 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuU1-0003n3-Hr
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:56:15 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BAuAn2072145;
 Fri, 11 Jan 2019 04:56:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547204170;
 bh=eR6eD6q/nJ45/trmkxExdoKyplDZBZ8qqleBxBVmRac=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=wq/c5agSPxlxQo0E61BpbQJT1k0ykDZasJRhoZap5x6b7M74w5m1bkBh4blwi1q3s
 W6UEeP33rHH4ea81ZYt+nCVlMHCHjqPn1yWwYOkBjpf62lMkXxCOKvrYg+I5BNEXt7
 Sr+ZSAgTel7E3zm8c+JTHsCWjWMv9nVqo0fX9qWQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BAuAMF075491
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Jan 2019 04:56:10 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:56:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:56:09 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BAu6h7012714;
 Fri, 11 Jan 2019 04:56:07 -0600
Subject: Re: [PATCH 1/5] ARM: davinci: da830-evm: fix label names in GPIO
 lookup entries
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>
References: <20190103151104.11839-1-brgl@bgdev.pl>
 <20190103151104.11839-2-brgl@bgdev.pl>
 <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <7d73f52d-e6e3-296c-ea87-6a0cf43afb0f@ti.com>
Date: Fri, 11 Jan 2019 16:26:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdapcG1bWCOk=SWHfKvpPMdBiEu0QOj4M+Zbx11Xhc59cA@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_025613_647828_BE8F0378 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Kevin Hilman <khilman@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On 11/01/19 3:08 PM, Linus Walleij wrote:
> On Thu, Jan 3, 2019 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
>> automatic base selection") the gpiochip label no longer has an ID
>> suffix. Update the GPIO lookup entries.
>>
>> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I suppose you will push this upstream through ARM SoC.

I sent a pull request with these applied to ARM SoC yesterday.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
