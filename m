Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB9F20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bdVBJ+tF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPwycXtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9F20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rF0+ZGtyhqoDNT3a7wdlXt4DcMyLTE7e9WfjMLZXEh0=; b=bdVBJ+tFxy0ouo
	AWyBCmbHUi7ALmWCzlBFMH+P5dbFAnVv1neuqBm7qoZCh4EC195ZexpGfl5TrcveOxXEN4plYd0Kf
	Pq7Y2+mmIDGwjJpluJ69+STMQwqbCOnPedwutIftsSd1jQrwxWfEneMzmidZdP/R7OeWpVjkV6LPb
	gsop3cy3uKzG1BhY7CqBwMCKpE4GJWXrTofWkFyQbD3ol+srwo/77taiErdLgFjcc1PtR5T7O9C3Z
	x6H7OU4Zx/Qz0gYff38XYwpCIogIvD+zxEg2+K/EXZQ8kSdaOffIRPF1S+gchX4FDpFXpNtyVxuy6
	CxqkrXqCYgiVwa9ogXYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPh3-0006rj-6D; Tue, 15 Jan 2019 14:27:53 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPgz-0006rO-SP
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:27:52 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FERiYP106652;
 Tue, 15 Jan 2019 08:27:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547562464;
 bh=lQFnyE46FaVj/+e+vZyU1ndUXVskqbFRRs/4Q8JdMeY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=EPwycXtYi+eP4DiQ0T1JwDWxPG8oSdfANmEM69RPMojkDbFA4IK7b6SCYxgxtenn2
 rTZ6qqkUzjA6rypx/TndvNVU34U5+MX0AeZ+R+V1Dn0uRCtLzQqHQuIgbN01HUaH/R
 NcVkT4mOkmiCCiGI1+DAw5BYsOtpTSwZeXn5kXXk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FERiG0022899
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 08:27:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:27:43 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:27:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FERhrT028678;
 Tue, 15 Jan 2019 08:27:43 -0600
Date: Tue, 15 Jan 2019 08:27:11 -0600
From: Nishanth Menon <nm@ti.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
Message-ID: <20190115142711.iwsx4p3gfa63dutc@kahuna>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
 <20190110073355.3382-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110073355.3382-2-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_062749_999491_3E28BE77 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

$subject claims MMC/SD, while the patch is specific for emmc and HS200?

could you fix that up please?

On 13:03-20190110, Faiz Abbas wrote:
> Add support for the Secure Digital Host Controller Interface (SDHCI)
> present on TI's AM654 SOCs. It is compatible with eMMC5.1 Host
> Specifications and SDHC Standard Specification 4.10.
> 
> Enable only upto HS200 speed mode.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 272cf8fc8d30..78e1bb56adee 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -191,4 +191,17 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  	};
> +
> +	sdhci0: sdhci@4f80000 {
> +		compatible = "ti,am654-sdhci-5.1";
> +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
> +		power-domains = <&k3_pds 47>;
> +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		ti,otap-del-sel = <0x2>;
> +		ti,trm-icp = <0x8>;
> +	};
>  };
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
