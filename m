Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A0C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:36:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5843E207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwVLLjLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5843E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jxvm4MJYUCeuD+CXLeUtqvl11EInPdNzlSFfmYn9Ki4=; b=bwVLLjLLtoSJds
	fl+r40YCfzmKlMNmC61Bz44Z9dSjzPxefYYXKaobrgRqWPsQTbq1GU+8EIiYDX+ca+eCSGiwus210
	yB6u1bWHuj/HC6ZvRIPEzrAq2Nhryi7kymqC02Y0TvmiY72SvlQF8IEU2StorEeDPpVjkfyKm3KTB
	HttgOCvd8fp9GzNY1jtRH1EV+U3Lafm8hjq3AF9GEHUzqomIHAntv/Yxv2hHsn1ZHztv6cJBW+ks2
	dMCo04HB6auIg8H3R1vESA5Nfv6+pypxFCMgSXwvs7ZKMsX15BAbA1s+OPrOfLTWK5sH05Xk8mGHE
	ZKIsVle8ibdHRw2/Pfew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpboD-0000Dz-20; Fri, 01 Feb 2019 16:36:53 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbo9-0000Cv-28
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:36:50 +0000
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 235CDDE81A500C6CE2C1;
 Fri,  1 Feb 2019 16:36:44 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML710-CAH.china.huawei.com
 (10.201.108.33) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:36:40 +0000
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5be6f6d5-83e7-7225-914f-f61205ce6e7f@hisilicon.com>
Date: Fri, 1 Feb 2019 16:36:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_083649_355892_2C04EA3F 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ryan Grachek <ryan@edited.us>, Alistair Strachan <astrachan@google.com>,
 "stable #4 . 17+" <stable@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On 1/23/2019 8:06 PM, John Stultz wrote:
> From: Alistair Strachan <astrachan@google.com>
> 
> This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> change was already partially reverted by John Stultz in commit
> 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> 
> This change appears to cause controller resets and block read failures
> which prevents successful booting on some hikey boards.
> 
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: stable <stable@vger.kernel.org> #4.17+
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 6102350..7092460 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -300,7 +300,6 @@
>  
>  		dwmmc_0: dwmmc0@f723d000 {
>  			cap-mmc-highspeed;
> -			mmc-hs200-1_8v;
>  			non-removable;
>  			bus-width = <0x8>;
>  			vmmc-supply = <&ldo19>;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
