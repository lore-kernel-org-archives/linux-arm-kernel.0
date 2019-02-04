Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C7AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:59:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CE4214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UXfVOVx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CE4214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=umsgmMx2jDDbNVWw9DEemvyR+MXhElhV8VGwp1Nr7UY=; b=UXfVOVx6ZQdbVN6qJQhqbSKEv
	SD1ZdR8BtIROoVOCkMaA4GFX3hCUnMs7dcS/9oBpByEqXmJUNin4Hm+w6SoT/+jM2sWdLhhQLpBBF
	dzaysJgGxJ4lqqCuX+eVQR8glUwwb+mmP+I4HPsA6dSvW0HbwNuSdthbMM/c01RaHEYeGtzK5haGd
	DfpvBV34/JFzS0dkTplz5GvyLq4FcKEzJXuLK/CABnQsEQ0U07zxFQNbqfZvk9GbiRIrAC/3Q7GzL
	tc/Iia7ZBBPBDl43TFOog6VOHxdLneooudEjPyDMc3h1283ZC160O9ZazO+Aop/n16tjXOPlfz8qZ
	ubAn3wh7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqdqp-0001T9-2i; Mon, 04 Feb 2019 12:59:51 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqdqi-0001Sg-SK; Mon, 04 Feb 2019 12:59:47 +0000
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x14CxcCM039741;
 Mon, 4 Feb 2019 21:59:38 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Mon, 04 Feb 2019 21:59:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x14CxbVr039738
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Mon, 4 Feb 2019 21:59:38 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To: Heiko Stuebner <heiko@sntech.de>
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
 <1970132.3b67tCGWFf@phil>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c4ce7f7a-c791-ae0a-ad3d-02b2efa41709@katsuster.net>
Date: Mon, 4 Feb 2019 21:59:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1970132.3b67tCGWFf@phil>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_045945_150548_2FCDA373 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Heiko,

On 2019/02/03 18:06, Heiko Stuebner wrote:
> Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
>> This patch adds HDMI sound (I2S0) node and remove dma properties
>> from UART2 node for rock64.
>>
>> The DMAC of rk3328 can use 8 channels at same time. Currently, total
>> 7 channels are used as follows:
>>    - I2S1  2ch
>>    - UART2 2ch
>>    - SPDIF 1ch
>>    - SPI0  2ch
>>
>> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
>>
>> UART2 can work without DMA resources, so this patch removes dma
>> allocation for UART2 and reuses it to I2S0.
> 
> I don't follow that description. How can i2s0 re-use the uart2 dma channels?
> Looking at the dma table in the TRM, uart2 has channels 6+7 while i2s0
> uses channels 11+12. They should just run concurrently?
> 

Sorry for confusing... 6 or 7 is as ID number of slave DMA channel.
TRM calls it 'Req number'. Req number 6+7 and 11+12 can work
concurrently but TRM says DMAC can transfer 8 DMA channels at same
time. So all 16 Req numbers cannot activate at same time. It should
be keep less or equal than 8 numbers.

For details, DMAC of RK3328 is ARM PL330 (or compatible IP).
   - Local variable 'chan_id' of of_dma_pl330_xlate() is Req number.
     This is from Device-Tree info.
   - Array 'channels' of struct pl330_dmac is DMA channels of DMAC.
pl330_request_channel() allocate DMA channel that is requested from
other drivers. Local variable 'chans' has max channels can run
concurrently.

Current setting:
   channels  chan_id
   0         8
   1         9
   2         14
   3         15
   4         10
   5         6
   6         7
   7         (not used)

Best Regards,
Katsuhiro Suzuki


>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 24 ++++++++++++++++++-
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 2157a528276b..e21645aa3fa5 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -68,7 +68,8 @@
>>   	sound {
>>   		compatible = "audio-graph-card";
>>   		label = "rockchip,rk3328";
>> -		dais = <&i2s1_p0
>> +		dais = <&i2s0_p0
>> +			&i2s1_p0
>>   			&spdif_p0>;
>>   	};
>>   
>> @@ -141,6 +142,12 @@
>>   
>>   &hdmi {
>>   	status = "okay";
>> +
>> +	port@0 {
>> +		hdmi_p0_0: endpoint {
>> +			remote-endpoint = <&i2s0_p0_0>;
>> +		};
>> +	};
>>   };
>>   
>>   &hdmiphy {
>> @@ -256,6 +263,18 @@
>>   	};
>>   };
>>   
>> +&i2s0 {
>> +	status = "okay";
>> +
>> +	i2s0_p0: port {
>> +		i2s0_p0_0: endpoint {
>> +			dai-format = "i2s";
>> +			mclk-fs = <256>;
>> +			remote-endpoint = <&hdmi_p0_0>;
>> +		};
>> +	};
>> +};
>> +
>>   &i2s1 {
>>   	status = "okay";
>>   
>> @@ -343,6 +362,9 @@
>>   
>>   &uart2 {
>>   	status = "okay";
>> +
>> +	/delete-property/ dmas;
>> +	/delete-property/ dma-names;
>>   };
>>   
>>   &u2phy {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index 84f14b132e8f..374b5da93a35 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -665,6 +665,7 @@
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
>>   		rockchip,grf = <&grf>;
>> +		#sound-dai-cells = <0>;
> 
> please make that a separate patch
> 
> 
> Heiko
> 
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
