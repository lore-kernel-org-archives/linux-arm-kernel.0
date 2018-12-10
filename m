Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B312C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:44:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504CD2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AHrU3GfO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo1314Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2kbyHLlMrDuyVls9tkfu94gVquTBKa9CYENMHNt8ZtA=; b=AHrU3GfOF48xYd
	AhQbkThlIou3KvpCAeRuT1Q7fjqVwbTeOtU7Qq4zhi7Jawkb1CjvkHn4WEdV+n9ti7jR4jb8c5YRU
	3LgwmZO/YASynUuxc9vb2QNSOXdTbc99FETGiRh5hEaRjDJhKRAEiEfGwGlVct8gGtj0HMHy8okAn
	effodZTkv/SKXnReNWsuSBR9w+WeNM5pd97WyACCWqE36HnlKwREJBG4dsmAEQoAwl9HWvcOMff4/
	e5mU51S75Z2y3cniczR8KrMOmvyG8D+x6YMSCF1gbhrOLu3vg3jyKZ5+L6e/EPSdt2RpWqTYSEBHe
	rGsYUvEhcr0EXpB0cpuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLr3-0006Ip-Cb; Mon, 10 Dec 2018 13:44:13 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLqz-0006Hn-GJ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:44:10 +0000
Received: by mail-pl1-x644.google.com with SMTP id k8so5267461pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qJe0lFdLiJyGkTG0oQdocR5mjS1UsdR4VanVd0I9Q8w=;
 b=Eo1314VoNon8bLdZlyfwfUAf1ykCo8qmhZGLSdKegOTdsmsRlb+PlpcVhmJti/SdmV
 iiLeXMGuBH5IDJlzSfsHOxUisOx3SVX/N2rfk2SZODlB6x3gHNvsQmKOyxZwszpZwsSh
 ARNmQNFDDJ2Tlm9gIb4WoGUGpuCnX5nieZOIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qJe0lFdLiJyGkTG0oQdocR5mjS1UsdR4VanVd0I9Q8w=;
 b=FA4kTrm1qVDR96kf0C1ITn9dW2l5zD1GJMYTkNy7O/Crpbw42YEGn+EWad17HAnOwe
 dnyGKIITReWH+yW7TmMzIMmI08hWrWMjBGabBxatbgrAkNnGuCJPncteHAlSHiU/Jc8L
 eM3XMGdUYgh83lmTim/cvMRxPwiBszgpxPrGHIjWXeJYS+vgk3PpMvYYB3JxZxUFOVtN
 cYGKBwSDChNiog4lY9gZNI/xlzzMG2VGgZJARc5l4MjcWVogNrFj90vpdXj3Lc56osar
 IAnOpTasGBA38cNohq3VBf57Q6FrGJ5D30ywrO+sFRFg90jG5EoF7+pLuN5/A3Pv1pwu
 fedg==
X-Gm-Message-State: AA+aEWZxmyAvBAoq6Di9gdGYliwOwaMtuyTO3+VKZT8ssg7+1vcK02Pi
 sRv0rJnyxfmFxTYrE1bWk+Lq
X-Google-Smtp-Source: AFSGD/UHb5IGpz9bGG8llAfD90QCB9DY7MrCtdfQS9mYFp/z8hgMIhSCbvWZQ4NN1bFXRAjiikY6aA==
X-Received: by 2002:a17:902:142:: with SMTP id
 60mr12556491plb.330.1544449438254; 
 Mon, 10 Dec 2018 05:43:58 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id v5sm22756891pgn.5.2018.12.10.05.43.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 05:43:57 -0800 (PST)
Date: Mon, 10 Dec 2018 19:13:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v2 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20181210134348.GA25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-2-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_054409_548231_992A7F65 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 wsa@the-dreams.de, linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
 robh+dt@kernel.org, linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 07:58:18PM +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-owl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> index b743fe444e9f..dfa1197e0dbf 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> @@ -2,7 +2,7 @@ Actions Semiconductor Owl I2C controller
>  
>  Required properties:
>  
> -- compatible        : Should be "actions,s900-i2c".
> +- compatible        : Should be "actions,s700-i2c" or "actions,s900-i2c".

Since this driver will also support S500 in future, the above could be
phrased as:

compatible:	Should be one of the following:

		- "actions,s700-i2c" for S700 SoC
		- "actions,s900-i2c" for S900 SoC

Regards,
Mani

>  - reg               : Offset and length of the register set for the device.
>  - #address-cells    : Should be 1.
>  - #size-cells       : Should be 0.
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
