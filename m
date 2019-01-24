Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FBBC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:18:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A89521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q5Nna+Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A89521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zy+/ZIfNS/65Iw9CJTf27OWPq1vPzzcaEDjDWqHrRhs=; b=q5Nna+VfV+foEOsENFhzMXtfC
	F2mb77s6B3STZUyQ2NlpZ2sFyPJ8Gac80UQaDciNXk7zHsEhTWJc9GBPdNY+cIOjIiDvwjhyODZJW
	AMwXsxnfxSCmzvMBOs3lmoFUWg9m9v4lsxLbv4+Jtf9lEbzUTuXYGe5LtPSIKDUG5WID2rLiThq1s
	26Z58n12tsmqd0NUTRGomJddeP5uV7njcNq7vDxHaEH9HklUGjoLfscJ28bFQiz5eRlT2fGIumAGN
	FGhnedR8AVHGnUBtQLI2hWwNgr2WglLq/HVvugcQRkfvl3RFLLZJDXq6GtiJlSmBxjxwjPvt4lPLT
	LpGIzfPCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd25-0004YE-TL; Thu, 24 Jan 2019 11:18:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd21-0004Wt-GO
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:18:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C56F1596;
 Thu, 24 Jan 2019 03:18:46 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CFE63F237;
 Thu, 24 Jan 2019 03:18:44 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
Date: Thu, 24 Jan 2019 11:18:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_031849_545953_E0B0783F 
X-CRM114-Status: GOOD (  19.36  )
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
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 "stable #4 . 17+" <stable@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

On 23/01/2019 20:06, John Stultz wrote:
> From: Alistair Strachan <astrachan@google.com>
> 
> This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> change was already partially reverted by John Stultz in commit
> 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> 
> This change appears to cause controller resets and block read failures
> which prevents successful booting on some hikey boards.

FWIW, you might want to have a play with the pinctrl settings - I've 
seen various flakiness with HS200 eMMCs on Rockchip boards which could 
be solved by bumping up the drive strength.

Robin.

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
> ---
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 6102350..7092460 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -300,7 +300,6 @@
>   
>   		dwmmc_0: dwmmc0@f723d000 {
>   			cap-mmc-highspeed;
> -			mmc-hs200-1_8v;
>   			non-removable;
>   			bus-width = <0x8>;
>   			vmmc-supply = <&ldo19>;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
