Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D022C41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3201218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFZ2suQE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="avuv6uQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3201218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ZuM0FOtV3paxaQRTRuGd4cMa9j/SiC/geLGtKfYpoE=; b=lFZ2suQEq094TL
	0Iknnn7LxC7eW5nXbArAY6jZ3oKqPbidyGTWnskn9xqG3ykkXCNz/ZU+9RV43/Cv5R1Kvh82cRwwZ
	/rTx3o51VJcRZRyuRGePH0m0bMqqH9RFp30ChyhOfnKGtdUN/+HY9a98HsuG2e5SExBinZmYcc0lx
	FEswkf2kisJ5oyCzkYPxgs6VPKYD6I3n9PW7GLKkkEs8heBWnY/1ODxSR4XdLEUXGjccSFYjbhrmC
	NBX2CTr14kMKgH6kTuu6XMm1UEbyZy3QrlaWGu9B8FHZS7A/Bz36znZd9OcAMYQ79JI9C/kuzT0+G
	WTzo12tCL3q4ievsspFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz6s-0004CX-Oy; Fri, 25 Jan 2019 10:53:18 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz6q-0004Bq-3y
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:53:17 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4aea990000>; Fri, 25 Jan 2019 02:53:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 02:53:13 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 02:53:13 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 10:53:12 +0000
Subject: Re: [PATCH 1/7] soc/tegra: pmc: Sort includes alphabetically
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7a5419b1-3729-8778-17d6-5d2e23467387@nvidia.com>
Date: Fri, 25 Jan 2019 10:53:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548413593; bh=xSAVBASzXCEEHJwsAvAls+79K9S1aAdV+xLcFmMAzUM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=avuv6uQHRSQZewR/Zk6uai9//+wkc48Yv3kcQN7aD82IkV3SGcyOrKHIEocj6lvkZ
 VXV6ASq8nQJCmV81e5WW9AH5CuYGFwbO3KU5jaoWwEMkIFRecXB9aRZdzpSEutka+7
 TtXjSPgnYv6AhMBEJfaosjqPPD3g78RgVMF/GNlFX44QXYNAM0/Yv47wdUxk8zEGWX
 aWt+PnoabVJRsMillJIxzmjIOlzKxCS8PjT3a6LUIsO8j7WBwhwul/wA94vtp2VH0k
 vzCbh4jO1z5zPsJtgd7aag69jWxaAHaqa4Vwa66MHmHU0VfsF1d5+f3vJiZcpaJ74H
 qggrWdTAJrq+w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_025316_169619_6E46E7E4 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 25/01/2019 10:22, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This will make it easier to insert new includes in the right place in
> subsequent patches.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 7ea3280279ff..cd865be3b195 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -20,7 +20,6 @@
>  
>  #define pr_fmt(fmt) "tegra-pmc: " fmt
>  
> -#include <linux/kernel.h>
>  #include <linux/clk.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
> @@ -30,16 +29,17 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/irq.h>
>  #include <linux/irqdomain.h>
> -#include <linux/of.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
> +#include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> -#include <linux/pinctrl/pinctrl.h>
> -#include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinctrl.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/reboot.h>
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
