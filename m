Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69622C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3202086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uAW/SEGL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8fHVDKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3202086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZAO/K7iTzCW8styJ6qEBZRB5mxBYaBKcm6glC+p5DXE=; b=uAW/SEGLp5HfPI
	6z+qEortTJdlFWfD+ncjuxkBIhg/ELm2gtwaXQFsaD4VJ0rVBa52jfx+Zwp6GbGNq+25WPxMUkFPF
	vexUb8SfNcKzWMawrHimP165+6AHeffpuUia1vpBtFAZipw5cxEY1i5IEskmtL6rYC4umeYJevjsA
	TFH4cLNRFKEqzlIvUv/hkdamlOSqs52ZIe6jX8CuJmkifINs9+BAlQqybxfVWNA6/C6BptXFoJQDG
	kcYc+qo9jDDxWizFJQ1di1ID507fyZb2W96tRM8DXllvXAnhoZ2AlhyooDWhUIthisRWOQ4MTqCIu
	qClR0zwFrC+uZCs8l2Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTlj-0000vm-Pv; Thu, 13 Dec 2018 16:23:23 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTlg-0000uW-Jl
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:23:21 +0000
Received: by mail-ed1-x541.google.com with SMTP id x30so2541096edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=biFtWIouHeCmptld8RVPX2GxDksaLA98OTNXtdMOMs4=;
 b=U8fHVDKD6RqtM+HsGaU4cvJtgA9haCGxlU2N961lZbSm7gkRoGj+eQ18F8MnhZlISe
 rnJo7uFXf4y0knNofDed0LZ3jAj9msr1zOzdTytqDnmI90055I9OH/+8wxZ4ZBzWiTVO
 RjB7ZLxHMiGounA+WjZTOqyOvXG04exAEtjBNcx2m+RrbMIVd2PLP3z2f7wrbkTLiqO5
 zgZEBc/93dW+W46Y6C0fct9qMWzWuiegipsM13aAvTkilfUBEQ/PE0c1YuoHY3/l0ELJ
 3rt5cyp9edjNRa9NMI5WJRa1kqZI+7IrxzsxmBQbAYCiUGaewUOCdKZ2RpUn/VaoHP7l
 SYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=biFtWIouHeCmptld8RVPX2GxDksaLA98OTNXtdMOMs4=;
 b=MSaPE3rm3PMmEIdRG/TFYbS1nnjjdUaXdBAyaun0AsEYskss+qhkXIhj7Sp62wvVc+
 a3jWXz3LXV9Ao6wcC2tt0sGbJer0jhWGObirE7p2ArL01CZnsBStEw2ANEsCuCcO/fc4
 rT+rZZrWWKoBMslMf2TdUsJMOGTgWV8GB9ox/HZYkyL5JHlovSNSVFlCJXyaV096Ck8/
 hwbncPsr04DaWyEMctieTQ4ODmHPL+Lnsk+XFT65PRrBdtjTIGjd9q6uVq88RW+ghGwy
 FoPuYzOe0rYc2NcAMQvZ4Xv7xTuCXVkvk5V7TVH6f8zWScgu3JU4DGMTqgcz4DKpiTvP
 93jQ==
X-Gm-Message-State: AA+aEWayJwXKenMW6m9pvGnUlv+3T3FSS8bIUIJcfRbbtLmenOxUOmq4
 s/zKpS4iioGiNgiBUBkZ2gwdOi0zMYenaaRpngs=
X-Google-Smtp-Source: AFSGD/W5af5RWJYvaBalAKI66xaG1YFc52LJRTwXGHbkKqAht2Fjk/+Nzkh/oqcC4PXp8bnpRWwmrrnmXlUvdMict+I=
X-Received: by 2002:a50:a125:: with SMTP id 34mr23133661edj.175.1544718188302; 
 Thu, 13 Dec 2018 08:23:08 -0800 (PST)
MIME-Version: 1.0
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 13 Dec 2018 18:22:54 +0200
Message-ID: <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
To: abel.vesa@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_082320_654916_E00C50EF 
X-CRM114-Status: UNSURE (   7.32  )
X-CRM114-Notice: Please train this message.
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
Cc: aisheng.dong@nxp.com, sboyd@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olof@lixom.net,
 dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>, shawnguo@kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

<snip>

> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +
> +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o

Nit: Do we want to keep CONFIG_ sorted?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
