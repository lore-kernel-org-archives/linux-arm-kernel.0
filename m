Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187CDC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADA5214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QaOTB0kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADA5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6QqRQIe6m4R0NXnkDFpyx+6pYYTP2HYK1l8b3beBIRE=; b=QaOTB0kVJW0+ap
	vcmeYHq3/44iRM1kEKSvm8Bx5OLUr4a9ZX5QzllWOHnYVOh0AaEZrWAHlg+F219VabuYwX46HufIl
	/MO9u5aUNxhUXybUYTXto6c4kX00cMsXJ6mB3tDrmKdnusjHyeXxg9SxQTTOpk4P7CnK38oaRcNoO
	HQ8daHXKWPI6h8SMJ864eeBxdygaaiSYtrw26mwmIZwrq2XXNIedlUwhiO6DvUFkLyjELZ2i0Qal2
	TAKOY9hFVxRSbfbCgP9PyNTEcjSj/f9yefcisrdo2E0ipHpPTF6P568XWCbEah0fLzt/+hpXpVItS
	aPzhqIA4O2HLbhvgiLzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4I0-0001co-0e; Mon, 28 Jan 2019 10:37:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Hs-0001VA-Ae
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:37:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E69EBD;
 Mon, 28 Jan 2019 02:37:06 -0800 (PST)
Received: from [10.1.32.197] (e121487-lin.cambridge.arm.com [10.1.32.197])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA9F3F589;
 Mon, 28 Jan 2019 02:37:05 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: dts: models: use list instead of tuple for
 mmci interrupts
To: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20190125175606.6607-1-sudeep.holla@arm.com>
 <20190125175606.6607-2-sudeep.holla@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <246b5569-efac-b229-2949-c6916b852c63@arm.com>
Date: Mon, 28 Jan 2019 10:37:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125175606.6607-2-sudeep.holla@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_023708_895483_866EA0EE 
X-CRM114-Status: GOOD (  15.82  )
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
Cc: devicetree@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/25/19 5:56 PM, Sudeep Holla wrote:
> RTSM/FVP vexpress motherboard model MMCI requires dedicated interrupts
> for CMD and PIO, which obviously should be expressed as a list. Current
> form uses tuple and it works fine since interrupt-cells equal to 1.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index b25f3cbd3da8..102e93744edc 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -86,7 +86,7 @@
>  				mmci@50000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x050000 0x1000>;
> -					interrupts = <9 10>;
> +					interrupts = <9>, <10>;
>  					cd-gpios = <&v2m_sysreg 0 0>;
>  					wp-gpios = <&v2m_sysreg 1 0>;
>  					max-frequency = <12000000>;
> 

FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
