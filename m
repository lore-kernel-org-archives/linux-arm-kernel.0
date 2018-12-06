Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697D9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D44213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l309AN/i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgFka1JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D44213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EtHh1DdgVWcuSPSspikU4lotjNGpy4xk+GQ9jBsKSS4=; b=l309AN/iccDqMh
	YK0Dx/knU4QFvTslXRRJYw9A27siicgeubnqaMaqaHiQe0KEI2OMyQojGMcxmHFpocs4k0rdKaVos
	6VbFKBuU76ehc/1Zn5KFcX2DBhu1EI/ad1C6cjcef+JHMB9HU2vP13AS5r2Bp9mOBySZkFj3MorAw
	eDYHQshN49o8GtETUhz7UDQnRUDyMYAA3kFjVxv9imPpM/603tyxPFfS4Dq5HiTHShzPfAI+OMKbt
	K+f0DReupiBCqjtEcophGT2Kb5+WBNjBNFJW4Y14YKr/eQjvHB66nli2JOn1POlqqx/E+VyTgFdee
	XgtTAfBMNGCnQyULLyqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUi7b-000130-Sx; Thu, 06 Dec 2018 01:06:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUi7V-00011b-ED
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:06:29 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 42A442133F;
 Thu,  6 Dec 2018 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544058375;
 bh=n0y/FePU5u0P26muBmNfdRLnEU2yU1MyrxUikW8Ok5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hgFka1JPRPFb0327BQKVKZNsaCMRz22/YyI3EX6Kjvpg5K/MqRxKy6+B9g/AWA1Lf
 G3VnszjGhTeh7yVf7Ln0Hxc6/d8UtLRuNz8XelCW6lmnpMw6XjFQBqxh73tLKVEBT0
 P7a6TyzWaqBDjDpU1Lg2VG2IDXjpkHUT37aJ8ARo=
Date: Thu, 6 Dec 2018 09:05:33 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v11 6/7] arm64: dts: ls1046a: add qdma device tree nodes
Message-ID: <20181206010531.GR3987@dragon>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-6-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-6-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_170625_494660_BBF6281F 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, zw@zh-kernel.org,
 vkoul@kernel.org, robh+dt@kernel.org, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Oct 30, 2018 at 10:36:03AM +0800, Peng Ma wrote:
> add the qDMA device tree nodes for LS1046A devices.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> change in v11:
> 	- no
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index ef83786..dc65318 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -704,6 +704,27 @@
>  					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		qdma: dma-controller@8380000 {
> +			compatible = "fsl,ls1046a-qdma", "fsl,ls1021a-qdma";
> +			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
> +			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
> +			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */
> +			interrupts = <0 153 0x4>,
> +				     <0 39 0x4>,
> +				     <0 40 0x4>,
> +				     <0 41 0x4>,
> +				     <0 42 0x4>;

Use GIC_SPI and IRQ_TYPE_xxx defines.

Shawn

> +			interrupt-names = "qdma-error", "qdma-queue0",
> +				"qdma-queue1", "qdma-queue2", "qdma-queue3";
> +			dma-channels = <8>;
> +			block-number = <1>;
> +			block-offset = <0x10000>;
> +			fsl,dma-queues = <2>;
> +			status-sizes = <64>;
> +			queue-sizes = <64 64>;
> +			big-endian;
> +		};
> +
>  	};
>  
>  	reserved-memory {
> -- 
> 1.7.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
