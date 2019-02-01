Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F1C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDB72086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i/90kYsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDB72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IPN46qC5yd/PbmVaYjQC0VFcgG7kbU0yuSZynmYFYPw=; b=i/90kYsjHFiEPNyNOmEawXYOZ8
	C2RwMAW6RP6ZuaDFS/9aqEPflRog1AyuN9qiTKoKVeUDBBPrS98atNBtnBCPV3lv+TqrvOL0NtX1z
	4V4eHeunS+tNtSF/aktm5F9DARi5KmOlxGrTjkhRJuMd96KJstg5fORueMu2Dop0VzTLD0c+Dhmaa
	5iTt18h5YtVaebY/nSMstEMdalDCnn3ar2oHI2q2DES27KQq+YRj4ilmvSkk5nr8wBRST+tngl6K0
	PlQI1yXc3c0dD1TmIu3bWCnFPaQnGS9m73ue1G15nUsxKJUDcs0npRmg21340D4K97rqj3YowG9vh
	SfkpB+RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcB3-00056O-1x; Fri, 01 Feb 2019 17:00:29 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcAz-00055n-Gn
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:00:27 +0000
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id C64D34F342B631B14FBD;
 Fri,  1 Feb 2019 17:00:22 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml709-cah.china.huawei.com
 (10.201.108.32) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 17:00:20 +0000
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To: Vincent Guittot <vincent.guittot@linaro.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linus.walleij@linaro.org>
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <3722223a-4f06-3e1c-86ca-542289c7c918@hisilicon.com>
Date: Fri, 1 Feb 2019 17:00:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_090025_706679_956D3127 
X-CRM114-Status: GOOD (  14.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vincent,

On 1/14/2019 8:24 AM, Vincent Guittot wrote:
> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Updated the subject as Leo suggested and applied to the hisilicon tree.
Thanks!

Best Regards,
Wei

> ---
> 
> SD card detection was not working on v5.0-rc1 but patch
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2 makes it work.
> Nevertheles, latest changes in of_mmc_detection makes possible to have 
> a correct DT config.
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 71bfe41..dc314e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -665,8 +665,7 @@
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr104;
>  	disable-wp;
> -	cd-inverted;
> -	cd-gpios = <&gpio25 3 0>;
> +	cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd_pmx_func
>  		     &sd_clk_cfg_func
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
