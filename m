Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A0321939
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jUaMquR5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r5QhxR9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A0321939
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9l1YILvAqt+kPs9d7t06XRitxRT0XlPwW0CRmFmO7ao=; b=jUaMquR59+s6BA
	r9GLUycWJ2uadA6BiYaa9xgUtUVXkjLmrZ+mqq9F9JGdttNflEkcKAOUsTQboEk+aPnT+rI+kaegf
	/+V4/NMKPRxDgWuA8tmZ8MPCte5PAadTcVU76cHWhrabh85Ex8TOtXbkDjPBe1wy4JQATqjr3wR9R
	SuYBcL/cnjq0+IDjyLD65+wYd2ML+gL8wysPBKuA3baovRUa+n25udOmLYi+UyYyzjtIkK5ZiKFkf
	HW8wxc3bjSLPu7J6Ux+kT5X3u8KC1SKn6Kgp0gsh9IOtVEwmBGUWMxp57eqdFYYlj1hmk/ppg8ZS+
	TYrLeLwCIJwvH3ojBSgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gakkf-0008Mc-Ic; Sat, 22 Dec 2018 17:07:49 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gakkQ-0008A2-2K; Sat, 22 Dec 2018 17:07:35 +0000
Received: by mail-ot1-x341.google.com with SMTP id k98so7920218otk.3;
 Sat, 22 Dec 2018 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K39DZ/tNuiOgoTKEhunBwHj8o6t9D0Ccp0K9bHFYS2I=;
 b=r5QhxR9NGhKbvg+vbeKXtr4hERJgX60w0vPTRquSZQjBlaueHqgEISySE9YGy+PqLL
 I1Jjg3u126vyaa2PNsXsuF1K/edTCfmJpIZZU2QidaY0jKN5G4FotyAxlznyz0bsJ4NH
 14TH+UDjWroSO2J9AnwLZVL4IzweIYc5ia+jcJs0c3HNpbbrtCFzGhBaqQgtzFaYhJ3c
 HViJYjsld+2BK2xNm25nqlZ/x2F4oGvkThJeLCAo56LgjYKuWuVHFtp0jLhMCrvG0V70
 HvwXawN8FJsoKOToH8X9oO1rv5D0LjWVKqIQyTa2F9kJHByygK3k8EIUPqcbG7zmGkJV
 /yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K39DZ/tNuiOgoTKEhunBwHj8o6t9D0Ccp0K9bHFYS2I=;
 b=hi+llUllaA1uL7+1xCBEL3hOJQTv75KfP/hMAfBscr0rRzM6a/fI5MZEKScwAF0TsB
 n4j8bPBwjpbscP8b2ewuuzSCLHJvS1O+ZXTvHqd4S9wUJJzeqEc7/cOM8KxdicY0796N
 bnLdINXinbwX/5rOEMfAf0KZ73YeTIAaiC72NDCywybUvFHKeoreabWv8cIfbpTmIc7X
 HVYbmF/BtfnJwIi7r751coNN/i88Dno35OVUCt20rJDjF+xqofIpBCc5xDOWIeP2oi3E
 gJ7S4M08VKGbVQU1SCvrbV4d9/vQ86zFGMGdTZkyq+YfQUcRK0o5HuhkatOZYntsmEsp
 pQUA==
X-Gm-Message-State: AJcUukd9akfTqB1wloR8n3zrnMF1F92IyvTkGTveSybHxQygSqhM4FNo
 QBVpLM0HIAb/USX0+DLvPkMcxUdVl/I5zUKoqS8=
X-Google-Smtp-Source: ALg8bN7ltVqzELgL3yHYAconL5GJ9Nwk1nwCzH6ms0XRnediWweGNySRMtZjZPlrzXEtKCDnmXhaqcUWp64Ic8lnC98=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr4931145otf.131.1545498442989; 
 Sat, 22 Dec 2018 09:07:22 -0800 (PST)
MIME-Version: 1.0
References: <1545392724-6637-1-git-send-email-jianxin.pan@amlogic.com>
 <1545392724-6637-3-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1545392724-6637-3-git-send-email-jianxin.pan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 22 Dec 2018 18:07:12 +0100
Message-ID: <CAFBinCAeDtu-KTy=4bmAtBY9hGK8rRo=OW70tgEOyRBnQcdz1g@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 2/2] mtd: rawnand: meson: add support for
 Amlogic NAND flash controller
To: Jianxin Pan <jianxin.pan@amlogic.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_090734_109688_AEE7CD3C 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Marek Vasut <marek.vasut@gmail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 Liang Yang <liang.yang@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jianxin, Hi Liang,

On Fri, Dec 21, 2018 at 12:45 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> From: Liang Yang <liang.yang@amlogic.com>
>
> Add initial support for the Amlogic NAND flash controller which found
> in the Meson-GXBB/GXL/AXG SoCs.
>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mtd/nand/raw/Kconfig      |   10 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/meson_nand.c | 1468 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1479 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 1a55d3e..d05ff20 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -541,4 +541,14 @@ config MTD_NAND_TEGRA
>           is supported. Extra OOB bytes when using HW ECC are currently
>           not supported.
>
> +config MTD_NAND_MESON
> +       tristate "Support for NAND controller on Amlogic's Meson SoCs"
> +       depends on ARCH_MESON || COMPILE_TEST
> +       depends on COMMON_CLK_AMLOGIC
> +       select COMMON_CLK_REGMAP_MESON
I believe that "depends on COMMON_CLK_AMLOGIC" and "select
COMMON_CLK_REGMAP_MESON" are not necessary:
the driver should build fine without them because it's only
interfacing with the common clock framework.
the common clock framework is enabled by ARCH_MESON and for the
COMPILE_TEST case the common clock framework provides stub
implementations inside the headers.

> +       select MFD_SYSCON
> +       help
> +         Enables support for NAND controller on Amlogic's Meson SoCs.
> +         This controller is found on Meson GXBB, GXL, AXG SoCs.
you are explicitly mentioning GXBB here but you don't add a "GXBB" compatible.
I suggest to shorten this sentence ("This controller is found on Meson
SoCs.") because this driver can also support the 32-bit
Meson8/Meson8b/Meson8m2 SoCs with minor adjustments.


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
