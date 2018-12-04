Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A9AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FE9206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPoHW2zZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j3m/VnZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FE9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R+2fiFZDLzkvH8AMYmIJlTpGIv7IHo/mSCFBwH/oVlA=; b=ZPoHW2zZzrBjIp
	Wc8nXhJ2Z3qQbo0gGNnZ9bzgeqndXFF37Y9VDtEVTEGTZ2JmBwOvf+JOTY8HXiHDBmudtq9oKiHNx
	raFw9BiXTdZFzawJWANEwOshSqle25KOnFV7wFlZQD+dnOnDtB7vmzDdaOaI97TRAJdgOjeVmB742
	qVH3wRSCYPNp4EV9in0eB/YP09wiz/PR+YAslE950Tdo0tl2W5BtANpqsKsEMhs/t3uRvCPfVIWk/
	olsX3fFDL7qzs+FKRHPrYReebMuGGopi2CSvqF9rTGSZz4YnR9bAaOVlpzPhD/sxxgTkpQ/CkJfzM
	aBZ/QAyzg+SuNLIhYK7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCkI-0006k5-7H; Tue, 04 Dec 2018 15:36:22 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCk9-0006YD-CJ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:36:16 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c069ee10000>; Tue, 04 Dec 2018 07:36:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 07:36:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 07:36:02 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 4 Dec 2018 15:36:02 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 1F663407B1; Tue,  4 Dec 2018 17:36:00 +0200 (EET)
Date: Tue, 4 Dec 2018 17:36:00 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 03/19] dt-bindings: cpufreq: tegra124: remove
 vdd-cpu-supply from required properties
Message-ID: <20181204153600.GA26056@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-4-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204092548.3038-4-josephl@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543937761; bh=sGzrb8i7gRChGYGQN5yNmS1XhnKzAkfdiRx5WPnblqA=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=j3m/VnZPQcx2q+QDOs7rK79xv6A3NX+rBfxqsFggdnvSOwvTV5poUdDL6rBXPS+X3
 OMY6VuWgIxkMgAvaVlyDb3r4RgkiO0BXS87xCh32uAXUUVDPK4CsaE/b1UQ6ru/hrU
 QjGBh64/qJiTsZnmdCe7IejYCBIoPcEb+kszSAhj0u3s4ARb3yicrxBd7IuIgCIGf6
 GcX+WTvz1mji5fw9C4bSiRR++YFdweOm2/E4uF3WUgiovn81SE731ehEQWxDFHHCoJ
 NL2KqQbhm2Ag1kC8L0xERyiC2icrN9xulkY7G00KtOCpn4ZqFEILNBoOZSGEmywVTl
 jpL7PmIRsWudg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073613_778640_62017E47 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:25:32PM +0800, Joseph Lo wrote:
> The Tegra124 cpufreq driver works only with DFLL clock, which is a
> hardware-based frequency/voltage controller. The driver doesn't need to
> control the regulator itself. Hence remove that.
> 

I think this is required for DFLL controlled I2C regulators because the
regulator is queried for voltage selectors and I2C slave ID?

Peter.

> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt     | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> index b1669fbfb740..031545a29caf 100644
> --- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
> @@ -13,7 +13,6 @@ Required properties:
>    - pll_x: Fast PLL clocksource.
>    - pll_p: Auxiliary PLL used during fast PLL rate changes.
>    - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
> -- vdd-cpu-supply: Regulator for CPU voltage
>  
>  Optional properties:
>  - clock-latency: Specify the possible maximum transition latency for clock,
> @@ -37,7 +36,6 @@ cpus {
>  			 <&dfll>;
>  		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
>  		clock-latency = <300000>;
> -		vdd-cpu-supply: <&vdd_cpu>;
>  	};
>  
>  	<...>
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
