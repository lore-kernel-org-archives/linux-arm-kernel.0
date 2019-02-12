Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA0B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxgZMr9v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GUTAM4/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA0B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ycDySgou0g8qmzLTvNqqtWwsgolK5HqTHOk5OlMM1DQ=; b=DxgZMr9vHLSj0g
	rHA6vtSkwrBTXtVryFlPZ4rqBM6c5QMDO+dmixxI5BqpLjacn0E9gZ76ZkOiPjxeY0Xc1Tg3gg9sB
	IGXnURRWustYlIDJwIVqiNHxJrWSY+g31ocBqANHIndVKa9CigVwnHpO5dj39Fyq90veDTFdDuoJA
	j/jX+mi25TCC8rKxfnV9P5GsBELcDjtzY2Mjxqb/xoVz8uLPIXtWKBRt/HKYoAl5GKDYNShXIIa6q
	kJ782neErtK3c51G+5+Q4aWf1P80YcQP9PHcIggUwICdVwoBzhviU9GaG2roywdDtOyUD64zGp8Ow
	DKyvlY2+5HsZ4L7yl6qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTVE-0003sC-Ai; Tue, 12 Feb 2019 08:33:16 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTVB-0003rs-IK
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:33:14 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8W4cN032279;
 Tue, 12 Feb 2019 02:32:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549960324;
 bh=Axvh0Rq6fFXHZYgk8AwVcglhNQjlBrZKQRI16zrgGF8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=GUTAM4/9Q70LYSEFNj8H/lNYHj3TS0jy6uYkGo4c8jPXvLgjXjwp6XSi4snvc5wOv
 wC/4U+tB27UirlhfvKDVhuhoKSPXN07Kj6EUVhgns86nxSdwGjiozCneClc3ubrzrA
 bnCbmbP5KAJVIR+bG1ig6bEj/j1bGHvq6gF1RqQE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8W41P006214
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 02:32:04 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:32:03 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:32:03 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8VxVN028341;
 Tue, 12 Feb 2019 02:32:00 -0600
Subject: Re: [RESEND PATCH v2 08/33] ARM: davinci: make irqs.h a local header
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-9-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <5bd7552d-a6fc-9701-beb2-5e76a295d635@ti.com>
Date: Tue, 12 Feb 2019 14:01:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211122606.8662-9-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003313_641990_AC9857F6 
X-CRM114-Status: GOOD (  13.33  )
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

On 11/02/19 5:55 PM, Bartosz Golaszewski wrote:
> diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
> index 9d4a58a3113a..cde72ba35dc3 100644
> --- a/arch/arm/mach-davinci/usb.c
> +++ b/arch/arm/mach-davinci/usb.c
> @@ -5,13 +5,14 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> -
> +#include <linux/platform_data/usb-davinci.h>
>  #include <linux/usb/musb.h>
>  
>  #include <mach/common.h>
> -#include <mach/irqs.h>
>  #include <mach/cputype.h>
> -#include <linux/platform_data/usb-davinci.h>
> +
> +

Drop one extra empty line here.

> +#include "irqs.h"

Thanks,
Sekhar


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
