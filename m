Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B967C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6008206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tuwiEvQM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aJL0qX9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6008206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7wDOdsXrkaBY3uhlmnJFIKbXefWTvRglZbczX7Q+rk=; b=tuwiEvQM/Emqps
	GFsJHNC0tXI/7SuiKw+MIKPWWlrebwYRsfVZRZIFPNQ7chYPKYlYkCcOhO7RMaOg9l+eMFP52013Q
	yfC7gJld0/FHncwQ9CkpcB+X5sMOLGf5X951OlTdG6NMuvjO4mXbJVYmH/v+dSjnAK6G3DfOlXPuQ
	GxTjvqIG2ok8CJB/rUz0yiyEs9UaisMyfoEbf0/CVjZnqr0G4Ob2sxz1nf8UAiBWNOHNGj/LZMu2v
	AqY2jMWJCyg2+wz3ITMz08a+Ej9LkpDieOJf80oiNMOvznGu/kXQJtnCfHCKew0H9zlhr7wDYtJc/
	sVZ8lLEAHeHv8T8tL4Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjqW-0004mk-9s; Thu, 07 Feb 2019 13:36:04 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjqR-0004mM-L0
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:36:01 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17DZhwD126071;
 Thu, 7 Feb 2019 07:35:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549546543;
 bh=HVZABGzY+/mzH9sbu3mK4ofM7dbrE9QG/dVMSoGapvo=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=aJL0qX9Xy74z+4daMeSxe8uhUShCfm62C/gmdjnPIzdrCjhEBGypvqBwID6g0wTMy
 l/U8TxfXBtrznXg5fBTtgN7s9a6NYEQ2VlOET/yRcQr6xirSyvBXzHjieYCYbyrYxs
 kHSbtA9FgJuxQWOWSKVa+V/EAFX5fYaCdvQbCYng=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17DZhPW012287
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 07:35:43 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 07:35:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 07:35:43 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17DZeRc003242;
 Thu, 7 Feb 2019 07:35:41 -0600
Subject: Re: [PATCH 22/35] ARM: davinci: cp-intc: add the new config
 structures for da8xx SoCs
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-23-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <fc43b6de-c53f-e2ae-9c8f-6f479dd21126@ti.com>
Date: Thu, 7 Feb 2019 19:05:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-23-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_053559_724711_39490276 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the new-style config structures for dm* SoCs. They will be used

da* SoCs.

> once we make the cp-intc driver stop using davinci_soc_info.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da830.c | 10 ++++++++++
>  arch/arm/mach-davinci/da850.c | 10 ++++++++++
>  2 files changed, 20 insertions(+)

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
