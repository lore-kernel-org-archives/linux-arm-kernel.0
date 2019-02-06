Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B036C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD650218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZsmofWUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD650218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pZxaVtlxKgN2VvI7bWSD4wUWsBuY1jGomu2/+MvRiCg=; b=ZsmofWUppYWa68
	c2z7Df6LEATcGQhLxt3cFe+PfciquK2Sg+OhrKKdgGPKGeh0jIHwWXIQCfKoNRkvIUg8ZaYlJ4ANH
	o8pSAS76FG9zrHp/lIWD/Si3ibz3FtN2PDyn7O2EpoynmrdVRm1+tzQBhXE1vnhTStR5QL/tBhH8f
	txSurpRvdos/SA941ouZTgD986/o2gWCrqBjczTIDjKMH2mhb1kafieCcBouYh/buPfbslKydoJEV
	HchLbXPhVMmEmCiIaXFWmcdZDBGkOZJ+hWGOZ+Y2XEszwrJxjXpSsNV9Sx6NH3JjnAyRouT+kZ7E8
	gmm/4i9Rbes3TbETZk5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grViq-0006CA-PD; Wed, 06 Feb 2019 22:31:12 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grVim-0006AC-By; Wed, 06 Feb 2019 22:31:10 +0000
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 16F57100005;
 Wed,  6 Feb 2019 22:30:57 +0000 (UTC)
Date: Wed, 6 Feb 2019 23:30:57 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: rtc: add device-tree bindings for
 the Amlogic Meson RTC
Message-ID: <20190206223057.GB4719@piout.net>
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_143108_574369_F0A99125 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, ccaione@baylibre.com,
 linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19/01/2019 15:43:31+0100, Martin Blumenstingl wrote:
> The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
> have a built-in RTC block.
> It has the following inputs:
> - an 32.768kHz crystal oscillator
> - an interrupt line
> - a reset line
> - 0.9V voltage input
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected patches from Ben after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> new file mode 100644
> index 000000000000..23df3cf2dd73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> @@ -0,0 +1,32 @@
> +* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
> +
> +Required properties:
> +- compatible: should be one of the following describing the hardware:
> +	* "amlogic,meson6-rtc"
> +	* "amlogic,meson8-rtc"
> +	* "amlogic,meson8b-rtc"
> +	* "amlogic,meson8m2-rtc"
> +
> +- reg: physical register space for the controller's memory mapped registers.
> +- interrupts: the interrupt line of the RTC block.
> +- clocks: reference to the external 32.768kHz crystal oscillator.
> +- vdd-supply: reference to the power supply of the RTC block.
> +- resets: reset controller reference to allow reset of the controller
> +
> +Optional properties:
> +- #address-cells: should be 1 to address the internal non-volatile memory
> +- #address-cells: should be 1 to reference the internal non-volatile memory

Shouldn't that one be #size-cells ?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
