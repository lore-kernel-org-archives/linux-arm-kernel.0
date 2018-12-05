Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D94C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE93B2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdRyiWZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE93B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LgDOTyLjCleH8KyEc/LgzMblezZkQjrnaeom2Cw3R04=; b=jdRyiWZyWeCZi5Vci0+YWPgbU
	FSA66lDjZeULgAIxYVw9F7D5G6D4FWxW6++aaYvJO/opR1ydjcN3AUgcDv34Bq8SVg2f8sXz8rhMa
	4Zs4Kkzdo40FgFuqv/znae9PeWe16TOXtxDdT774q4beUndxbxTG3Na0pZu+ZNblmbMwmcsfm/8lm
	HfPkMY+jg6IQ+nzhW4FxtpBVRQJVaWDnC5tLOdOnKglAooUPvRtTQ5PKhA5XLI9P/B90WQuzbTSSy
	MkfohbBcxwMag3BDCNNeR+BaDjgXYhBDRbt32Xl2DFXEUZzIUbmiwkxfF/yiQjwsUeZ1KG3CZctDi
	pyHFTVFtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWqF-000399-OH; Wed, 05 Dec 2018 13:03:51 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWqB-00034D-9s; Wed, 05 Dec 2018 13:03:48 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gUWq0-00024C-Mb from Akash_Gajjar@mentor.com ;
 Wed, 05 Dec 2018 05:03:36 -0800
Received: from [10.105.2.145] (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4;
 Wed, 5 Dec 2018 13:03:31 +0000
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rockpro64 fix video output chain
To: Oskari Lemmela <oskari@lemmela.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>
References: <20181201100817.20688-1-oskari@lemmela.net>
 <20181201100817.20688-3-oskari@lemmela.net>
From: agajjar <Akash_Gajjar@mentor.com>
Message-ID: <09287391-d541-cddb-4168-55ca6fee3f16@mentor.com>
Date: Wed, 5 Dec 2018 18:33:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181201100817.20688-3-oskari@lemmela.net>
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_050347_337943_363A2F45 
X-CRM114-Status: GOOD (  19.65  )
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
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/1/2018 3:38 PM, Oskari Lemmela wrote:
> Rockpro64 is not able boot if kernel is compiled with
> CONFIG_DRM_ROCKCHIP=m
>
> Enable Rockpro64 board HDMI output to fix issue.

Hi Oskari,

Could you please describe this issue in detail.

I am not able to reproduce this issue if CONFIG_DRM_ROCKCHIP is compile 
in or as a loadable module at the same time hdmi node is present or not.

> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 5bd4d69914bd..be78172abc09 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -205,6 +205,13 @@
>   	status = "okay";
>   };
>   
> +&hdmi {
> +	ddc-i2c-bus = <&i2c3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_cec>;
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	clock-frequency = <400000>;
>   	i2c-scl-rising-time-ns = <168>;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
