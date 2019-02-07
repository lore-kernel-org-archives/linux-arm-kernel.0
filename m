Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5ACC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCED2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlVm58T5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jwzrbNkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCED2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEJ+/9uQhN63z1ZcaWcN5ooMiuPC5eFbD/BJ1Gb2FIA=; b=ZlVm58T56dfiVo
	2s7rMofWFdToJOqILfNG+GFame+TgLwFG+aKeVdUA0GG87r6QOvfLh6QHBJL0gZglP4QykpAPxhv6
	msAJHKUbPlewWaotg/mnBQk0l5mybKdVgFlq3o/kHJ+drHMmFKvhsc8o1rsaNseLhwAmkVKaNMUwp
	yNm+jCkP86FiQYKgURf7EzfC7TQRZM+R2ZLgrae7LHbihoRr5dbaLZhqU6eTcFWW7+EEP/mDAoaFg
	d1Ie3GoEyd4a0UYs9md6dsnFmcrQpsgX44XPG7Zg18stlsiPcev/0FhBVjw2ayBcP0WB3vvw3L8ko
	lvF5CyzYwwXRzt3j+MZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkLT-0001nX-Av; Thu, 07 Feb 2019 14:08:03 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkLP-0001nD-OV
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:08:01 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17E7igA126386;
 Thu, 7 Feb 2019 08:07:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549548464;
 bh=iKQqQ4B2hwiH2hM0XcpljoPwFxXZdlbKWIjZ+SkptXU=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=jwzrbNkvPmlcAeXVHuhWz91QxubKLeCkiXs6II7PCwiYqnerWIjsQAFlwOsFOTKfs
 amdHhYeluNclrwKIi70e3cR+8qF/5hW/iWhPbSq0Q1jkofIyZCLlkUQuc5h5iR3YYb
 Ak/PL4CvfEg47be18Jcm0JI7vPwMVihyAGK9kXBo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17E7iwG105574
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 08:07:44 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 08:07:43 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 08:07:44 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17E7e8N000513;
 Thu, 7 Feb 2019 08:07:41 -0600
Subject: Re: [PATCH 33/35] ARM: davinci: prepare to remove mach/irqs.h
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-34-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <73e93586-5681-4a37-04f4-da8d666adc59@ti.com>
Date: Thu, 7 Feb 2019 19:37:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-34-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_060759_892849_849F7701 
X-CRM114-Status: GOOD (  18.73  )
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
> Since we now select SPARSE_IRQ in davinci, the mach/irqs.h header is
> no longer included from asm/irq.h. All interrupt numbers for devices
> should be defined as platform device resources. Let's prepare for the
> removal of mach/irqs.h by moving all defines that we want to keep to
> relevant headers (davinci.h, common.h) and replacing others with
> simple literals.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
>  arch/arm/mach-davinci/board-da850-evm.c     |  4 ++--
>  arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c    |  2 +-
>  arch/arm/mach-davinci/da830.c               |  2 +-
>  arch/arm/mach-davinci/da850.c               |  2 +-
>  arch/arm/mach-davinci/davinci.h             |  2 ++
>  arch/arm/mach-davinci/include/mach/common.h |  5 +++++
>  arch/arm/mach-davinci/include/mach/irqs.h   | 18 ------------------
>  9 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index b3a0148f7f1a..950e98e4eda5 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -488,7 +488,7 @@ static int da830_evm_ui_expander_teardown(struct i2c_client *client, int gpio,
>  }
>  
>  static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
> -	.gpio_base	= DAVINCI_N_GPIO,
> +	.gpio_base	= 144,

Why drop DAVINCI_N_GPIO instead of just moving it to a local header file?

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
