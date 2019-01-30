Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08080218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uz+jMBSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08080218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GzxK5YtrAOdTkIqXm63bGsBSgUpzfsVnvkTIco0Y/LA=; b=Uz+jMBSFWWJbUn
	+SDjKqQG3AWr4iKIEfSdOs1xf8uEhvofPtCRnnjuiKlYZN3TH8l++7RIbS8QB4H1Hxsae9GP/c7UB
	jRdjvTKl/FZ5fo8oTQAG9f/tj5lQGuktH3MfvgAwN+PgiCBVSfQ13AEHTOUvV3q6ZesInqEs1+FoH
	meXF1Q0jjucnsbUZVQ36ETm/eo7wsj3q0BTfbTtXbB2JUWG1KSNmRACwSx1TB2Phd6+QFaO6VGmle
	ZGERLLlztrlBq+HWqkdOeSMwjQlBnWzIlVCStl46RYlLFte4pjeYWHw0xNIRg71l3iEybOlsa+09j
	k84cCLGcLoNGWMQ/2QYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxJl-0007VA-Um; Wed, 30 Jan 2019 21:22:45 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxJi-0007Uv-RK
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:22:44 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 87E1143F6D6;
 Wed, 30 Jan 2019 21:22:41 +0000 (GMT)
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
From: Vladimir Zapolskiy <vz@mleia.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com>
Message-ID: <bd0b4bf2-dc14-2f9d-1350-25996a46760d@mleia.com>
Date: Wed, 30 Jan 2019 23:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190126142921.16041-2-vz@mleia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190130_212241_581902_2BB0845A 
X-CRM114-Status: GOOD (  18.33  )
/bin/ln: failed to access
 'reaver_cache/texts/20190130_212241_581902_2BB0845A': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_212241_581902_2BB0845A 
X-CRM114-Status: GOOD (  17.50  )
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
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob, Dmitry,

On 01/26/2019 04:29 PM, Vladimir Zapolskiy wrote:
> The keypad controller on NXP LPC32xx requires its clock gate to be open,
> therefore add description of the requires 'clocks' property.
> 
> In addition adjust the example by adding description of required 'clocks'
> property and by fixing 'interrupts' property.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/lpc32xx-key.txt b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> index bcf62f856358..2b075a080d30 100644
> --- a/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> +++ b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - reg: Physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: The interrupt number to the cpu.
> +- clocks: phandle to clock controller plus clock-specifier pair
>  - nxp,debounce-delay-ms: Debounce delay in ms
>  - nxp,scan-delay-ms: Repeated scan period in ms
>  - linux,keymap: the key-code to be reported when the key is pressed
> @@ -22,7 +23,9 @@ Example:
>  	key@40050000 {
>  		compatible = "nxp,lpc3220-key";
>  		reg = <0x40050000 0x1000>;
> -		interrupts = <54 0>;
> +		clocks = <&clk LPC32XX_CLK_KEY>;
> +		interrupt-parent = <&sic1>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
>  		keypad,num-rows = <1>;
>  		keypad,num-columns = <1>;
>  		nxp,debounce-delay-ms = <3>;
> 

if you find time, please review/ack this change before 5.0-rc5 to give
me a chance to push it through ARM tree, thank you in advance.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
