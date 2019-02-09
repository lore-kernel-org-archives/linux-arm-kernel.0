Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C47C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C3F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="snIaxxd0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="kbzM1SZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C3F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=znrfs3bbYqWzkMdCvZpAOBnQQCD7HwvlRYpwz32WgGo=; b=snIaxxd0mYdqsK2rIC6yhVe6l
	46H0RygDEq0fvlFXz7JcklCqjfZ8/PXfrbtrsLbwfWoOTvmDvxq65Kucergj2TZiwyJ816cv7U7S4
	llKjlKNjUcKKjQHBAQr1Ejt4f6IKTjwVnihDGsf/dgb77d9PY6+eRak/ySoS4ylb3Jy5gyVCOP2tR
	HzbcbMQVDHJXeegGAToTQXFveFM9Hmwag2AslMI63XPxXijCFHUgdr+1z7U5/wb+++aNrwDtyVmH+
	n0qVxQDb8bczmIpaWy3vyPq/NPJHZEXpDKJNqyaNeQh2KRZTMU6y/EbCiLlGAeIagUhZkMYsSf5tE
	zvxjaGohA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsZxC-00043i-4Y; Sat, 09 Feb 2019 21:14:26 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsZx8-0003sF-N7
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 21:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tI6HtZ+cou49J3I+feGLu6QXsuZ0+P4Rp4ag5PuTizc=; b=kbzM1SZB6JTJ4SIrpchZkS0mAR
 onR1a3xSr3vbcAf5fswa0PNBk4Q9jE2iUwGPgR3/ZRZrJTB2Ih470w4PPsSkMCvBI/nB7fMkBrX8G
 M8fvDXYkTiBk2vAA9UIzAxyseg/NzfVCru8hMYPO6gwqeiasNUmDHjsQMTUQgm7sdBHWav0wG1+n7
 ARTNay87RiqeMzRvUF2rVi8CTQuHSdZ8EPHXGbnVA1QD37riSurxus3loXiiDVFZMZ7rzp4u8+orW
 n/rEuq9zvKfsEgnPEr9OCXiCjLO4IZSIz7d/E5QKll+z/Jh/Hb2NdwnT2KAdbAB7tm97cB9ZPamcu
 c0BGTu0w==;
Received: from [38.123.241.2] (port=60095 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gsZsd-0000CR-DF; Sat, 09 Feb 2019 16:09:43 -0500
Subject: Re: [PATCH v2 03/33] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190208173458.4801-1-brgl@bgdev.pl>
 <20190208173458.4801-4-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <c9dbec4e-8738-e2bf-9011-1cc1ac5f44dd@lechnology.com>
Date: Sat, 9 Feb 2019 15:13:04 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208173458.4801-4-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_131422_842640_A6BB5AB2 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/8/19 11:34 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to support SPARSE_IRQ we first need to make davinci use the
> generic irq handler for ARM. Translate the legacy assembly to C and
> put the irq handlers into their respective drivers (aintc and cp-intc).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 07d8ef8037e4..3ce821a06e52 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -29,11 +29,13 @@
>   #include <mach/cputype.h>
>   #include <mach/common.h>
>   #include <asm/mach/irq.h>
> +#include <asm/exception.h>

Alphabetical order?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
