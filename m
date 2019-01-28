Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73FC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E5F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tutlFfVn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LsDtzyTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kGXk6jm1urUIZ7dJ0iyFtdL8ZHy/j3/gfhOGs5ZXnE0=; b=tutlFfVnqmHJ0H
	p8fk8GabZEXA5nTHdB6Dqni7D1XxttK2NL94JFl0z//IqaW8JcHkuFOb6AZGrP7aY6QbassOo+VPo
	N/kMFs7+g6d+gh849qBZI0uaVL4LM87YOQBnhXA3JCSfgfEFfc1aqYuvl8kduQiJ16aNEns+cUXOp
	3JP6OMLIb/dC7H7CrPWFbfNI6r8r6sac/ArThDjRj0CPIFP01qTg82cz1QrCw1agAvhPN0RK2pNFt
	c5B7i2zmQ5rOqa1c2ZtehN/bWZU0hEVNnRYbfR6EvPqeRicmxhhogiOCIL1ZB7br8x+VsNqp4xWTB
	Z2gvQMytbgMbDqe97M5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7Xk-0006ZY-Ny; Mon, 28 Jan 2019 14:05:44 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7Xg-0006ZE-UL
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:05:42 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F09E925BE02;
 Tue, 29 Jan 2019 01:05:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548684340; bh=SJjg5ZFd1qjjVj5/GhmF6er0LTaRTfWOIpJW5OhRkaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LsDtzyTdU+1CVr9jbQSRk5HBfsaiAWidym6hBSBqn5kycXFqtU0oW1Wg9Jw+gOpci
 oqqBiuBm/2iF9+y6ZHO1Isa7AnI1fNQ1Ync4kty/MCE79STHfYkP83t595XoFs1oEr
 V/qUwzDoPgHFeHS78yQTSYFpk+YkrWDOCfrh5XZ8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0E9D69403E0; Mon, 28 Jan 2019 15:05:37 +0100 (CET)
Date: Mon, 28 Jan 2019 15:05:37 +0100
From: Simon Horman <horms@verge.net.au>
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add OPPs table for
 cpu devices
Message-ID: <20190128140519.wfbnpgznbkx3msft@verge.net.au>
References: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_060541_129346_39FD067A 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 09:02:42PM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch define OOP tables for all CPUs.
> This allows CPUFreq to function.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

Thanks, I have tested CPUFreq with this tested that with this patch and
"[PATCH] clk: renesas: r8a77990: Add Z2 clock"
(https://patchwork.kernel.org/patch/10783723/) applied on top of
renesas-devel-20190128-v5.0-rc4.

Geert, or others, is it expected that z2 does not scale
in this test?

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
performance
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
800000 1000000 1200000 
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z2/clk_rate:1200000000
# echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
/sys/kernel/debug/clk/z2/clk_rate:1200000000
# echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
/sys/kernel/debug/clk/z2/clk_rate:1200000000
# echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800000
/sys/kernel/debug/clk/z2/clk_rate:1200000000
# echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z2/clk_rate:1200000000

> 
> This patch is based on the devel branch of Simon Horman's renesas tree.
> 
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> index 84bbe70..936714e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> @@ -55,6 +55,27 @@
>  		clock-frequency = <0>;
>  	};
>  
> +	cluster1_opp: opp_table10 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <820000>;
> +			clock-latency-ns = <300000>;
> +			opp-suspend;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -66,6 +87,8 @@
>  			power-domains = <&sysc R8A77990_PD_CA53_CPU0>;
>  			next-level-cache = <&L2_CA53>;
>  			enable-method = "psci";
> +			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
>  		};
>  
>  		a53_1: cpu@1 {
> @@ -75,6 +98,8 @@
>  			power-domains = <&sysc R8A77990_PD_CA53_CPU1>;
>  			next-level-cache = <&L2_CA53>;
>  			enable-method = "psci";
> +			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
> +			operating-points-v2 = <&cluster1_opp>;
>  		};
>  
>  		L2_CA53: cache-controller-0 {
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
