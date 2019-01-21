Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2495C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D7E2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pi4dcKKm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNcu8Ajq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ocKuM1reTj3/kd2bHTTpgKL4ZZsqXgN5V8wrF6a+9Oc=; b=Pi4dcKKmj6phyw
	9txm3zZcN+4Iepukn1aDyB6Pni2+FH+XcEnNn+pHLHKGe7cPDFD1V9ZjL6QBpwFzarNZWeRURU5VJ
	b91/yZT7033uG2S+6xfXwvQshZ32PtI7YAJcLHehG7mcgCgoEnGoOELqBF6V9JFkpH/zQYsV06ocE
	GeZ62PDaioRmDj/QSxzSuFqusaKJW/1QTEULgvG8BrJ0Oljvf1WWrlOk072aS4YfiMt9tYQgnjCKP
	UVPNF0IKUSiF+pUu4rPuJJTRAMCXsc4cNhoZPNibKr46zFy/lcrruiZWq4OQO7aXhOgQ7gZMSBzxX
	0lal6Y26FaNonYH7zHgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glddQ-0008LP-Qy; Mon, 21 Jan 2019 17:45:20 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glddN-0008Ks-3Y
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:45:18 +0000
Received: by mail-oi1-x244.google.com with SMTP id r62so15232783oie.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BE+SqTDqacrcr5HjVTlX4qc1vc1g44Z4pXp3l9YMwqc=;
 b=oNcu8AjqE27YtVz0SwyDJiJ5UDBcVWog3G4gdbnZF/vL821Rnl8PrRauHSO7xt6qv6
 GAEI1y+PLS1av+9LRdkF4KjvfOjQtkS2tAjODFW9S8ZJ8Fr+5R9Ot1lhh0dvaq8U+Jeu
 /jl8bMMHigdemq1yfi5jHHP+F1LTIOYQ6hvijdju1WlEejRq0WWZoVEtwl7I9aev4nuj
 q3x6lOLNqxi7k3cnri2Ct+vQlUS1vXzF/B7sbzm8XTJufMIphSOjn8eJWkhPeG1KeYod
 IIIpaB9Pq6BO1TIjfxl5dwzXTpL6opf45dGCbwfqgR7TovyEoS8L1A+zipM9lDeG6YFI
 KNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BE+SqTDqacrcr5HjVTlX4qc1vc1g44Z4pXp3l9YMwqc=;
 b=QPo10rGquQZFPdSmnGtag4XsigR4gmDtXPAWFutVGkrSWqnkjuOWnnZCF8zxIoSMJ9
 xA6uOY6iWq0vZEiXAyrXCO9goHglcxmnyOar1zIEVyUC/pTzb/7WsQz5Tr+eb+18PK2a
 bdIq9VR+hO4jp3xyZ7t/aubZfvhPInyrgBLwjNkpkwqedbBonSXfaur/dm5jv1rD36Qy
 D9zj1sqC/UUyxDwv7dWxL667fE5IQ62w8DXpBV077FRzC6vD8WV7qOP+XCYGlcM7RykP
 g9pnhvti3ovKyVpAE/29b+ieLYyVZUcfTMhWZv6cdg7qJXJdCle8ZZR3Ns9Ai0/5g0BL
 l13w==
X-Gm-Message-State: AJcUukc3oDT4BGni5GntdxuU4to0K5Q6ESKF0TQSIUhhkslNNYgYrC1C
 3WiiHChQcMlRZ5kIuAEKIQ5xQB5MitLYF+eTWRM=
X-Google-Smtp-Source: ALg8bN5wGi3oSKiYWERF2NO5TkTSPkTnhuFiyh8qbqSVktQ89tE03hoJ3zHOzXZwTXjRgNEAqly6AXeT21adqZKINsg=
X-Received: by 2002:a05:6808:296:: with SMTP id
 z22mr6466360oic.67.1548092715961; 
 Mon, 21 Jan 2019 09:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <20190115110446.19077-2-l.stach@pengutronix.de>
In-Reply-To: <20190115110446.19077-2-l.stach@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Jan 2019 15:45:10 -0200
Message-ID: <CAOMZO5CngJErMS-tEQ+W3wmrrkCm9Cj-1cHbMwjb02+fW7Z13A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: imx8mq: select GPCv2 irqchip driver
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_094517_158430_D31183FB 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

On Tue, Jan 15, 2019 at 9:05 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> The system is unable to boot without this driver being present,
> as most of the peripherals are connected to this IRQ controller.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index bb0d78d1ca4d..e9ce095af6c7 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -149,6 +149,7 @@ config ARCH_MXC
>         select CONFIG_PM
>         select PM_GENERIC_DOMAINS
>         select IMX_GPCV2_PM_DOMAINS
> +       select IMX_GPCV2

This one does not apply against Shawn's tree or linux-next.

Please respin it and you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
