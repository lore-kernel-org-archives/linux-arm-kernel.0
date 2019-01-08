Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3870D20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gBjKpSJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3870D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=imoxaYVIMbJ/yRtIV9ALycoHQYAvzVjYjx9yc1YKy/Y=; b=gBjKpSJHaL9ionXGx9cJIGvsh
	8aL+HQu4009LmF7nuSu0F1EfxxAiWyermCT8SSf04CuRlyIkZjY3iuSxWBvZoIKIo5qy0VM+CoMmU
	CcFM0PWr9vxlkU2fG/HzCMB9u2ETwkswQJvC+SgTRZAYz7QhQXlBT8gpMXoBrD/+q+NfKpUPxFNm/
	CgCn+3b8I/IJfTos0R8e8+hb6Tp/JuMVXHK6okw7wqg1+0hTGf0EqVHu3/pvm7uNKnad6aXc9Txgv
	yrq+s1Hqxfp8vt5rFyJJzuhE1FSiStFp9/uparHFWCpRM5xBz2K8sNCSY+w+it84KsEeRZHCdjAzi
	qx0Aqn4uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh0hJ-0003W8-K3; Tue, 08 Jan 2019 23:22:13 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh0hE-0003Vb-Rx; Tue, 08 Jan 2019 23:22:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB86980D;
 Tue,  8 Jan 2019 15:22:04 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3E93F5AF;
 Tue,  8 Jan 2019 15:22:03 -0800 (PST)
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Fix nanopi4 uSD card detect
To: Heiko Stuebner <heiko@sntech.de>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <83098c7ecc471a77dd89564f5f98fcf30c1ed431.1546981251.git.robin.murphy@arm.com>
 <6925511.AQqqGbhmY3@phil>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c2c40662-f7aa-75d5-572e-c58b21170b59@arm.com>
Date: Tue, 8 Jan 2019 23:22:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6925511.AQqqGbhmY3@phil>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_152208_907310_3B6920CC 
X-CRM114-Status: GOOD (  21.06  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-08 10:42 pm, Heiko Stuebner wrote:
> Am Dienstag, 8. Januar 2019, 22:57:27 CET schrieb Robin Murphy:
>> For whatever reason, the sdmmc_dectn function isn't working properly
>> as-is, and microSD insertion and removal goes unnoticed. Flipping the
>> pin into GPIO mode, however, does do the job, so let's just handle it
>> that way for now until someone feels inclined to figure out what GRF
>> voodoo or otherwise is needed for correct 'native' operation.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> index 9c723038d8f8..2a183a6af150 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> @@ -505,6 +505,10 @@
>>   		sdmmc0_pwr_h: sdmmc0-pwr-h {
>>   			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
>>   		};
>> +
>> +		sdmmc0_det_l: sdmmc0-det-l {
> 
> alphabetically by node-name please,
> aka sdmmc0-det-* should be above sdmmc0-pwr-*

Right you are, not sure how that one slipped through.

> If you're respinning the whole series this should be fixed,
> otherwise I can also do that when applying.

I've fixed it up locally, although it might be worth holding off on this 
particular patch for the moment now that I've taken another look through 
the TRM and noticed those smoking-gun-looking bits in 
GRF_SIG_DETECT_CON{0,1} - I'll investigate...

[ side note - do you reckon there'd be any value in bolting a debugfs 
interface onto the GRF driver, or is the realistic answer to just use 
/dev/mem like everyone else and stop having silly ideas? ]

Thanks,
Robin.

> 
> 
> Heiko
> 
>> +			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>>   	};
>>   
>>   	sdio-pwrseq {
>> @@ -563,9 +567,10 @@
>>   	bus-width = <4>;
>>   	cap-sd-highspeed;
>>   	cap-mmc-highspeed;
>> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>>   	disable-wp;
>>   	pinctrl-names = "default";
>> -	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cd &sdmmc_clk &sdmmc_cmd>;
>> +	pinctrl-0 = <&sdmmc_bus4 &sdmmc0_det_l &sdmmc_clk &sdmmc_cmd>;
>>   	sd-uhs-sdr104;
>>   	vmmc-supply = <&vcc3v0_sd>;
>>   	vqmmc-supply = <&vcc_sdio>;
>>
> 
> 
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
