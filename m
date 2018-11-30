Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EAB2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mJjfITH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EAB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CDFOczM4gPFvzwpY0+SCw53TiWcx4eKhpGYCVemYdB0=; b=mJjfITH54WMYDw
	MsqHdYEZID5Dh/7HqRgTUI57M/pGltFDPKjQ0bnWr1lWznuMUwomxMWx36Fbh8PP9f+86wTFfrNNY
	kPAoeX7CLyRVCFzA+p3sbGiUg3Vhl++PCrlwAKkdg6w9HBuUVWI23O0Hit/fycJnx1fFCrzYEEP3I
	MvqGh7mMHlbFXqepg2jfw/O01158+zGXd+HxjMdOBbG8cqn4y/+Xp3B6RkMmt/ylu6pcsnQc6Vpzr
	b0I6UimVrS8BNCGnpDkZeeuO5XkiXb5r4q8ynZ7PCQ1a5meFhm0tuF8LUtDgUWcqstwq1GpdddjVX
	meoO0IccyCiTjYdR43ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn4k-0005Pq-7k; Fri, 30 Nov 2018 17:59:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn4B-00056q-4a
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:59:07 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 897A920DA7; Fri, 30 Nov 2018 18:58:51 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id DFDC720745;
 Fri, 30 Nov 2018 18:58:37 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Ding Tao <miyatsu@qq.com>
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-37xx: Enable emmc on
 espressobin
References: <20181026115028.193203-1-miyatsu@qq.com>
 <20181026115028.193203-2-miyatsu@qq.com>
Date: Fri, 30 Nov 2018 18:58:38 +0100
In-Reply-To: <20181026115028.193203-2-miyatsu@qq.com> (Ding Tao's message of
 "Fri, 26 Oct 2018 11:50:28 +0000")
Message-ID: <874lbymoq9.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095903_689666_07D8C50C 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ding,
 
 On ven., oct. 26 2018, Ding Tao <miyatsu@qq.com> wrote:

> The ESPRESSObin board has a emmc interface available on U11, let's
> enable it.


Applied on mvebu/dt64 for now, but what happen if U11 is not populated?

Thanks,

Gregory

>
> Signed-off-by: Ding Tao <miyatsu@qq.com>
> ---
>  .../dts/marvell/armada-3720-espressobin.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 3ab25ad402b9..ee05aabbba88 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -60,6 +60,24 @@
>  	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
>  	marvell,pad-type = "sd";
>  	vqmmc-supply = <&vcc_sd_reg1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio_pins>;
> +	status = "okay";
> +};
> +
> +/* U11 */
> +&sdhci0 {
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,xenon-emmc;
> +	marvell,xenon-tun-count = <9>;
> +	marvell,pad-type = "fixed-1-8v";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc_pins>;
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
>
>
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
