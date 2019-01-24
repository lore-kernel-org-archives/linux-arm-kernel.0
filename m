Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:26:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6F221855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ghhUc7gy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G75tBIm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6F221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Vd8lLq46fZNGt3+JZ9oJ0Q24MlVdYKYjsaLiiPlHyo=; b=ghhUc7gyzm3Z3g
	YnIr7b3xj17oE2KVCrpM8CCs8fwliJFdd7+mBVsqvzLGmfzvdkIBVfnwaskMjEpAtyQp3/I1Sg2wL
	V/LP3OM+W7jeLeAVyDH6LE7/M229xhTRp9sG5zxIb6VKjWLGMPIDEeB8lJtZ3CU/SbA21no0vGSBN
	Sq4LHb1PAW24/5UZCbSeDhIGdWCeZhHwKAfJRp29YQ7H4DKZRdWqv4Tzmxayh4NtNZmXxMk6nIilW
	vnNLNSpH/X0JJ67K4PO+g1devWuY8YlMv3AroEe7u/B8gIngfjsmPG59oeOCYxPR5HeJkxLqBn66D
	HlKa0poLdGe0icR1BWHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmaL1-00070e-32; Thu, 24 Jan 2019 08:26:15 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmaKx-00070I-HC
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 08:26:13 +0000
Received: by mail-vs1-xe44.google.com with SMTP id z3so3017828vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 00:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gUndCR9EZLRKT47oazL+YNDsX9+nAEw4+cyaNSj4UoA=;
 b=G75tBIm8PaM8u+qgJDv9dbSdC1qeLPIgVZDEsHb3RhAGxdbsOjtQ8ESDvCWdu3TQiM
 y9ablAVcz5Gw1rhD97Mz7Tn+YxKtSkQO6caYJDv94AiWwTA1ML3HYz0D8ub2BBxZFHtI
 bpm4RA0WZZdJtepznrsd9Ev3pA53gFRmROiuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gUndCR9EZLRKT47oazL+YNDsX9+nAEw4+cyaNSj4UoA=;
 b=ltcZwSpCvQHw/ytxhpNP/5DlkuKY9MMvDsLoG9qj8z+8ci8lLfQW3Xmcd9YnRqfLIs
 soo8cyt4CuSRCJKZHSJq8eKnNtqcAnyEwC8hRSw8TsAXxhBWZlQx24s/iTZdc+VT8zQV
 ct2DUebDoyV+23HruRh8ChqeWkwJmuG4gaQF5kn7jaLe6Z4osSf5qYr2P54s4kJIhPTB
 CEakIv/3+HNGJCI4u1uEgrlbdb+9o+PZSFNO9/goR77wMnAaKVq6khxrVrd5P81KZ5Wi
 /W+Rjj14lOiTn4eDL93o1Z1SMGmlSdAkmyzdyrYr2ZxHvRBQnoTvVIMp9jhix8Thvw3J
 8/0g==
X-Gm-Message-State: AJcUukcyZoBYoQ8wi+6eF/2smXyY23Jm0rZCkDVGk5yyKfEgodWyxH37
 MT84/fGpAolKGpxNFqpCcoGkt9M42bGx3I7j2APf6Q==
X-Google-Smtp-Source: ALg8bN7dIdPbFKBu3e0LeDv6hFYFe1Om2LsFra3RmCINI6E3/BHKo0irgUjBsZxP/pW+oYCrkt0t43MaHGNGlgCcrqU=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr2323525vsi.191.1548318369865; 
 Thu, 24 Jan 2019 00:26:09 -0800 (PST)
MIME-Version: 1.0
References: <5eace97d-1b6f-60eb-98da-588a485fce18@web.de>
In-Reply-To: <5eace97d-1b6f-60eb-98da-588a485fce18@web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Jan 2019 09:25:32 +0100
Message-ID: <CAPDyKFrp=LQmT-AsScnbf+ULkw80U1U3QzWCa1UuWPTYCDuw3w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zcu100-revC: Give wifi some time after
 power-on
To: Jan Kiszka <jan.kiszka@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_002611_583482_5DE21E83 
X-CRM114-Status: GOOD (  16.90  )
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
Cc: Ryan Grachek <ryan@edited.us>, Tony Lindgren <tony@atomide.com>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Michal Simek <michal.simek@xilinx.com>, "Reizer,
 Eyal" <eyalr@ti.com>, John Stultz <john.stultz@linaro.org>,
 Kalle Valo <kvalo@codeaurora.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 08:54, Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Somewhere along recent changes to power control of the wl1835, power-on
> became very unreliable on the hikey, failing like this:
>
> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
>
> After playing with some dt parameters and comparing to other users of
> this chip, it turned out we need some power-on delay to make things
> stable again. In contrast to those other users which define 200 ms,
> Ultra96 is already happy with 10 ms.

This changelog is talking about Hikey, while you do a fix a for the
zynqmp platform. Please rewords this accordingly.

>
> Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")

This is not the correct commit. Please change to:

Fixes: 5869ba0653b9 ("arm64: zynqmp: Add support for Xilinx zcu100-revC")

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 13a0a028df98..e5699d0d91e4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -101,6 +101,7 @@
>         sdio_pwrseq: sdio-pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> +               post-power-on-delay-ms = <10>;
>         };
>  };

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
