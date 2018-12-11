Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDBC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:40:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F15C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8DKH/md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F15C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EhY0ChzbQlEjD3hdhMK2bk8+NtOAbCVuBArxA89Oyis=; b=G8DKH/mdxY9x5VxJ9TZx3DlmE
	Z8vKrEcsJy6Q+g3gWfcuPEbb9EZBF/7Goj1Pa9o5vwyfJZHYul3Gr0xmcVxzf/LP3Ak0HLzgIIBAG
	oMFq4yWSTeNZckwqgZTPAD3Vf7RCEHNf5zi3Ehh9Oo4f6lkElcxpkj7pS3NxKyulpeznHmP5MQrEu
	gAafi9RLB1w6BDFXZ1LJhjClek+1i8SHHJaySqAVMG6fljQSPofYp0RUXZZ/56egnCaUSRTtOMaeG
	lj24+CBEEuvT8MHO5pwGlJaF/7UIttLxcC5PakxTRgdZYli1kCkQC9PhPuvzIxUX4J5vaNToMvKvD
	BoIYYFQuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWmwm-00047J-Pw; Tue, 11 Dec 2018 18:39:56 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmwj-000465-EC
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:39:54 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2018 10:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; d="scan'208";a="258646831"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143])
 ([10.7.153.143])
 by orsmga004.jf.intel.com with ESMTP; 11 Dec 2018 10:39:41 -0800
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
To: Vijay Khemka <vijaykhemka@fb.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
 <20181210200753.3018124-3-vijaykhemka@fb.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <584ddf6f-2e0c-5c1c-df06-bdd37ecd2489@linux.intel.com>
Date: Tue, 11 Dec 2018 10:39:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210200753.3018124-3-vijaykhemka@fb.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_103953_531020_BBB23738 
X-CRM114-Status: GOOD (  20.51  )
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
Cc: "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vijay,

On 12/10/2018 12:07 PM, Vijay Khemka wrote:
> Added kcs device support for lpc BMC.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index d107459fc0f8..1bd48655bacb 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -330,8 +330,35 @@
>   				ranges = <0x0 0x1e789000 0x1000>;
>   
>   				lpc_bmc: lpc-bmc@0 {
> -					compatible = "aspeed,ast2500-lpc-bmc";
> +					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
>   					reg = <0x0 0x80>;
> +					reg-io-width = <4>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0x0 0x0 0x80>;
> +
> +					kcs1: kcs1@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

This reg property isn't needed at here because kcs_bmc_aspeed module
reads regmap from the parent node. Please check below code in the
driver code.

priv->map = syscon_node_to_regmap(dev->parent->of_node);

> +						interrupts = <8>;
> +						kcs_chan = <1>;
> +						status = "disabled";
> +					};
> +					kcs2: kcs2@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <2>;
> +						status = "disabled";
> +					};
> +					kcs3: kcs3@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;

ditto.

> +						interrupts = <8>;
> +						kcs_chan = <3>;
> +						status = "disabled";
> +					};
>   				};
>   
>   				lpc_host: lpc-host@80 {
> 

You might need to add kcs4 as a sub-node under lpc_host like below:

kcs4: kcs4@0 {
	compatible = "aspeed,ast2500-kcs-bmc";
	interrupts = <8>;
	kcs_chan = <4>;
	status = "disabled";
};

This would be uses as an SMM channel.

-Jae

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
