Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404A420872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mXMTBNbY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+K055ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=muGhB6SIM8gNN7FIPE3/YgXdblr8dLLjmgVcB8aUfX0=; b=mXMTBNbYexkvy8
	/Itmc/gmBZLKpFnbLqf/v/hok+G8IYxy+l5lwH8UACetdEBWdO4zFQWH8/hqndxzgCd9gJ9W3papd
	toT319j1GZfP83zVfFKuBsB4KpOXsNmFLYQwzT1SHmat/lMEUzBza3bVXjM1vgA4q2lHhmBOHgGSh
	qu0GiE4lH4Oogr9wNmOceAjduqrfm3SWpqGhI7pvKsPaiWjqXz3Ohmz5nLthm26GLguxDlGAPkVMo
	E18swGEE8Go/cgghZUs0GGFgk5WyjFcVDQ9x/5788iVHPDeoFRIwsJ0yNM8me7f3kGlLBxNKibZVP
	isL6J5a50ciCzmRA280g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsMS-0004Gl-83; Fri, 11 Jan 2019 08:40:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsMP-0004GQ-94
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:40:15 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B42CC20872;
 Fri, 11 Jan 2019 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547196013;
 bh=Ir5LcYORTVmfAHbEccXx7YKVzz1BAY2oSkZeax4a+rg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y+K055acjsd+osfRXd3VL20996e4HLNlZ6HN6nw/LRUcBUEPGBPIOqKxPsS5cXk/c
 /KjczyNv7WCwE6yypk3f1NBarYV8ZJOxqcP16POLGJF2z3FaqhKHn9n769P2MOQW4x
 Ns7YcMjyHsQGXXezHlcCkKL/YmEACwQPdnhy9qMw=
Date: Fri, 11 Jan 2019 16:39:58 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
Message-ID: <20190111083956.GF32649@dragon>
References: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_004013_364875_AB98E958 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 04:51:58AM +0000, Nipun Gupta wrote:
> This patch also adds the iommu-map property in fsl-mc node, so
> that fsl-mc can use iommu.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
> These patches are based over:
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git,
> as there are couple of changes related to fsl-mc bus in this tree:
> https://lore.kernel.org/patchwork/patch/1021020/
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 92 +++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index de93b42..dec0c2d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -576,6 +576,7 @@
>  			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
>  			#address-cells = <3>;
>  			#size-cells = <1>;
>  
> @@ -641,6 +642,96 @@
>  				};
>  			};
>  		};
> +
> +		smmu: iommu@5000000 {

We are trying to keep the nodes with unit-address sorted in the address.
I move the node to where it should be, and applied both patches.

Shawn

> +			compatible = "arm,mmu-500";
> +			reg = <0 0x5000000 0 0x800000>;
> +			#iommu-cells = <1>;
> +			stream-match-mask = <0x7C00>;
> +			#global-interrupts = <12>;
> +				     // global secure fault
> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				     // combined secure
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				     // global non-secure fault
> +				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				     // combined non-secure
> +				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +				     // performance counter interrupts 0-7
> +				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +				     // per context interrupt, 64 interrupts
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	firmware {
> @@ -649,5 +740,4 @@
>  			method = "smc";
>  		};
>  	};
> -
>  };
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
