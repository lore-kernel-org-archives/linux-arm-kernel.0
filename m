Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E48C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B5620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jzvwGq+w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jWPOrWni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B5620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=brKom86ZLB5lMgUhXlHV9YGwKSMe+KfsMpQUBLNsivo=; b=jzvwGq+weqMoJF
	ejHvVDrh2a0y6+aB4Iawa/+ZWBIOUsH1YQc4ZJ8jmMCLNVX80JGOLtt9HCProyYUpvWO9VNdejbdq
	QCoqlnxXqz2lKE0mS9npJ8UuJWByBlMX/keCxLxoIbnxG7FG2dLod1laa2E+5t04B+N6JkoZb+p9Q
	YyRUSiTOOhmwsAzAEs071mILZ7wkX0+IfxQ2Bif1mUrK9ZjH154U7bgl5nSJZm6PevAsoE6YLmm6D
	17AZqWn36jxJAMtuPejVeVQIPz3XfG8f4mS8Gr9nbd5JbFV+ZkS1JIOgi6JuaSKe53PnP75ytSQBC
	tLThg2VXmlNkZHnAwAkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQma-0000yi-AN; Thu, 13 Dec 2018 13:12:04 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQmX-0000xR-2r
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:12:02 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c125a930001>; Thu, 13 Dec 2018 05:11:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 05:11:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Dec 2018 05:11:50 -0800
Received: from [10.26.11.125] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 13:11:48 +0000
Subject: Re: [PATCH V2 18/21] arm64: dts: tegra210-p2371-2180: enable DFLL
 clock
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-19-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <84fbfa0b-553e-72ee-23c6-e7772e75aaa8@nvidia.com>
Date: Thu, 13 Dec 2018 13:11:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-19-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544706708; bh=71s2bZj5prrCJrAmhvNXu+5fUiyJfmuwkYkDURcMNaM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=jWPOrWniPzHRjehDwRLTUSTMxfDu2+h5VUlLp92eYf+xZODGjd305HDIXXZ3UDq3p
 ADkgT+Kwm2sw0dGpJ+N2nRHCmRjlMK+yu905ICV8be+k0rNHFiirFvqF+KRZ6Wpp7q
 aHxWffmcRpy4cHD6c6ujkKIRlq/qVKLzY90VWpkkysRk1ZCydzH5NpVRGYe4PGRTjc
 ZG3GDwxACEBvYJ0SQ07zebkFCqfeO8ijS18syUTyay1eX46byF2BhBsD86y35DUuO+
 DFWLUrOxeKSoEaTAFeCcIdKxxRSCQ4EJxvOBxtpv3Sa2xisSOBntskuGAu21JHFstL
 vHX9Sc59dnSMg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051201_136591_5BD72057 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 13/12/2018 09:34, Joseph Lo wrote:
> Enable DFLL clock for Jetson TX1 platform.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - remove non exist DT bindings
>  - update the PWM DT bindings accordingly
> ---
>  .../boot/dts/nvidia/tegra210-p2371-2180.dts   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> index 37e3c46e753f..99c016bfc601 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> @@ -78,4 +78,25 @@
>  			};
>  		};
>  	};
> +
> +	clock@70110000 {
> +		status = "okay";
> +
> +		nvidia,cf = <6>;
> +		nvidia,ci = <0>;
> +		nvidia,cg = <2>;
> +		nvidia,droop-ctrl = <0x00000f00>;
> +		nvidia,force-mode = <1>;
> +		nvidia,sample-rate = <25000>;
> +
> +		nvidia,pwm-min-microvolts = <708000>;
> +		nvidia,pwm-period = <2500>; /* 2.5us */
> +		nvidia,pwm-to-pmic;
> +		nvidia,pwm-tristate-microvolts = <1000000>;
> +		nvidia,pwm-voltage-step-microvolts = <19200>;
> +
> +		pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
> +		pinctrl-0 = <&dvfs_pwm_active_state>;
> +		pinctrl-1 = <&dvfs_pwm_inactive_state>;
> +	};
>  };

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
