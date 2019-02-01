Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D3BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41890207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByT9Fdxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41890207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=do7RxKnuUQKBctUjSD4aKoaDXQh+7z/SZ9FzDQULEtY=; b=ByT9FdxdRohfbl
	nBLVZ4Rdj33M8WkYgSrSp+pHyXSfZ69SO3vWtnrxjgqjdMZ94cPLSR9JpvPX/bbKup/TP+aN0lp/F
	v/jnAip7znvTKdGNQPzglhTDwQBswZKT+cyKgTYYu3Bh6MzkM+19B5gsfRwQEsIwqQhsQAq0RlDja
	Fl6Gh8ym+s/+CNKsmw12X+XmU0ngTiSh6vA5woEJxbEFJK2vAnC9s6cmOqUxJuWQV5uPIGQT1z6Cu
	92B7B+t4XPaxOGnz6xOMqOQOhhz7YpQOYaJj3KT+Xb7HPN5TUELbontByOzFzgkSRxC0s2HvNdRy0
	Wji1JinCVHOkLFYd7vIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpblr-0006uZ-Tj; Fri, 01 Feb 2019 16:34:27 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbli-0006ag-96
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:34:26 +0000
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 24E9E7295E4DD4C1BD35;
 Fri,  1 Feb 2019 16:34:10 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml709-cah.china.huawei.com
 (10.201.108.32) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:34:07 +0000
Subject: Re: [PATCH v2] arm64: dts: hikey: Give wifi some time after power-on
To: Jan Kiszka <jan.kiszka@web.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>
References: <e944650d-514f-3727-2e68-b318aab9ee7f@web.de>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
Date: Fri, 1 Feb 2019 16:34:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e944650d-514f-3727-2e68-b318aab9ee7f@web.de>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_083419_142766_3B486E86 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, "Reizer,
 Eyal" <eyalr@ti.com>, John Stultz <john.stultz@linaro.org>, Valentin
 Schneider <valentin.schneider@arm.com>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jan,

On 1/24/2019 7:52 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Somewhere along recent changes to power control of the wl1835, power-on
> became very unreliable on the hikey, failing like this:
> 
> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
> 
> After playing with some dt parameters and comparing to other users of
> this chip, it turned out we need some power-on delay to make things
> stable again. In contrast to those other users which define 200 ms, the
> hikey would already be happy with 1 ms. Still, we use the safer 10 ms,
> like on the Ultra96.
> 
> Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
> 
> Changes in v2:
>  - set delay to 10 ms
>  - updated changelog
> 
> Who will take care of updating also the Hikey firmware dts with this
> change?
> 
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 610235028cc7..ba946543dd0a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -118,6 +118,7 @@
>  		reset-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>  		clocks = <&pmic>;
>  		clock-names = "ext_clock";
> +		post-power-on-delay-ms = <10>;
>  		power-off-delay-us = <10>;
>  	};
> 
> --
> 2.16.4
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
