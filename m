Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9467C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tz4m+SeQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfrBeh+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lVTtZyj11qkFZFomDq6qasjP0+5oMrlOxFMDW3ZxT4s=; b=tz4m+SeQNIaHaH
	S2f9TwenDd2LzmGknyP5hNMTpTcatII46GUrzpT6IAJfTThrFkul19N8pxvYcbAJD07DUdDMN2x+e
	G+xk7CClhGkO3da2l4GudC+HXLayfMYePn5zMxC4SkqjpnMQbZEDxblVU8dZE/V9wUtOxUn+FDkpS
	JJ41EiXbYV79bbF7q3Q4kyPnoqzfLHhJkhRWqShErHQw2JoxVfGHsKlE4LyTm+Y4woZOTLNl+ymj3
	mOJAJOX8uElQdU3Cayo9xsFRJIVzIi01miQfgyOf4amAWpkiR5t2cKW8HJ1L6hnu7gm27RECgEbdd
	mlnfbxd21q/Hvxswm6sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlMv-0003mV-SC; Tue, 11 Dec 2018 16:58:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlMr-0003kr-P4; Tue, 11 Dec 2018 16:58:47 +0000
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3E7C52086D;
 Tue, 11 Dec 2018 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544547515;
 bh=bYxvgYOBSwOSe0ZpRtqNnNn2RseC00i5nN637rwutQY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JfrBeh+j8eEAPLvVSW6yJvUWkli7phF3BEr0DDuwm7XUfMOGS5Lu6RIlNlZX5TvSX
 DdwkQjBcHBhzlNgH3HGqq4NyzW5hl96S+gbrnknyEDnXAnE4Rz6ZXj3eR0qQPoTECu
 TGQOGn3vqfYSQ6PsYW25w2ptPxKIFisHxbNW59YQ=
Received: by mail-qk1-f174.google.com with SMTP id 131so8994310qkd.4;
 Tue, 11 Dec 2018 08:58:35 -0800 (PST)
X-Gm-Message-State: AA+aEWaER1F0WvtN7J1zJaeV6SoV0EDhDN0L3gcbeuEx2w5QiD3QC3p3
 ikob57GEYCeqOJOcEqN9EGiuWkYrLYzhuTEVJw==
X-Google-Smtp-Source: AFSGD/V00bXWrg6CnLbWbb/ZNNU5UHouIAhgsI7YN0OZlNBnDMm8QwuZyoYDHvTrKHHE0ibF207knHklPq6ThEoGD4c=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr15556224qkg.147.1544547514495; 
 Tue, 11 Dec 2018 08:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210132227.29262-1-narmstrong@baylibre.com>
 <20181210132227.29262-2-narmstrong@baylibre.com>
In-Reply-To: <20181210132227.29262-2-narmstrong@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 10:58:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
Message-ID: <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-midgard: Add resets property
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_085845_830380_4B4FCEB9 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-amlogic@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 7:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic ARM Mali Midgard requires reset controls to power on and
> software reset the GPU, adds these as optional in the bindings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 18a2cde2e5f3..24d83ec952f1 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -37,6 +37,8 @@ Optional properties:
>  - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>    for details.
>
> +- resets : Phandle to the reset controls for the Mali Midgard device.

How many? Sounds like 1, but the dts has 2. There's also a similar
patch for Allwinner[1]. I don't want to see a different number of
resets and different names for each vendor. So first figure out how
many resets the IP block has. You'll have to find someone with access
to the TRM.

Rob

[1] https://patchwork.ozlabs.org/patch/1003654/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
