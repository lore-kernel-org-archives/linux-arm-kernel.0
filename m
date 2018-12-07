Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78BE20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yrv/R3Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78BE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+esZTHb73foZFMO6n90VtK7EchVPRiLKk1E/iZza2Zg=; b=Yrv/R3RlydZQMg
	1HxrF8puLwhue6AHILY05rleCApS+DjfAL7nPooXmLW2g4Nv4QLRiTQ2EcX8m7inhIHHlG3VL8Szy
	woN7jQIjiUSSxhQ9qkMpWaflw9Gh/PyLco6fKhK0wEwe/bV1TYkS7SCgjdlGnGP83VkGmfdWHSs7b
	7KcBDFTpmMmWCVlJuSTRqkI4QZI/CMuptiqxEhihlfL5mAiex7AzNSr1sOX5ojoaGTUqCTd6ynhwF
	kJIz2vQeLvuj+NN/RTh0PaArjqZOp2HIr61vmZV/zxGJdsvYQ9zKZyM5ais1Kg4BwjS74uGJG8zK3
	k6z5YHXUTGE2J9Y0agKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBVA-0007km-NA; Fri, 07 Dec 2018 08:28:48 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBV7-0007k5-Sf
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 08:28:47 +0000
Received: by mail-vs1-f66.google.com with SMTP id z3so1978560vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 00:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2nhO3gLhJjnnIsOq8z72QYoMZn+McVIjQW8cExMvlAw=;
 b=GhBgtcDJpQsjJC7nuXDj3y7ihrwa2pPUUZDQN2hgJHKE/8N4B6wMhEOVKJyUeM4IaH
 FsFQvBefUf/GMkUdl2dzb3l84XWj9AKuF3LghR4E2eXcG25dceUIWGycUGPrrX7VmReC
 ul41pcQjkcaIwnoM+eAc3WveAkHzqvYzfHSrjWEymlxGMGGhFQRKggN96LgLAhNbhx5K
 Rgpftc5mnJ+WsMDjxs3qc0eZWFQN+CJ/h0l5iW8Obvc/G/8+9C3JV0LTrB18vpgLZgaW
 W22owW2olmDR0yGz7ih385OU3SuyhTplJ3cqVFVT9OelBieAl07Mmnony2/omg1+iVXc
 koyg==
X-Gm-Message-State: AA+aEWbGaCOFK0jC3ZWxLbtPn5XIYTqWWtiVPkl23nl8jYSim9HZSdXy
 LgyN2VDeDvzLV/kpJjh/LMjLlolucDMeSObdcZA=
X-Google-Smtp-Source: AFSGD/XwIeXbusifMA7PMH5cQiieLRWZgnQwmy5a3UFrSo1/wkNG2UC4DEVnkoztLDJU32AWfgcWUlq3I4wEb/Sbjuw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr458297vsj.11.1544171314326;
 Fri, 07 Dec 2018 00:28:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544126077.git.horms+renesas@verge.net.au>
 <595096daf0ac9c1741b6182eb72d636802a21006.1544126077.git.horms+renesas@verge.net.au>
In-Reply-To: <595096daf0ac9c1741b6182eb72d636802a21006.1544126077.git.horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Dec 2018 09:28:22 +0100
Message-ID: <CAMuHMdUZSqaW_Vk9GjrtKjRUKdmbFMC5CEswGc_wDWQ-d515hw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_002845_923647_E416651E 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Thu, Dec 6, 2018 at 10:58 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Enable the scu-simple-card which is used by
> the R-Car E3 (r8a77990) based Ebisu board.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f88190463481..9d0b42d96f03 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -491,6 +491,7 @@ CONFIG_SND_SOC_RT5514=m
>  CONFIG_SND_SOC_RT5514_SPI=m
>  CONFIG_SND_SOC_RT5645=m
>  CONFIG_SND_SIMPLE_CARD=m
> +CONFIG_SND_SIMPLE_SCU_CARD=y

Shouldn't this be "m"?

>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_I2C_HID=m
>  CONFIG_USB=y

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
