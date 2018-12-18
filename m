Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0560204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+TN50cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0560204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pVKDu04aCQgop96KJH2HUYrHqoGnatAmGBOW4zbavIQ=; b=S+TN50cgV+CTr4
	U/Le1k2N0p4uVy+btkxtuvSW2/02zy1fL+C+n15Q/j116Dkp22TZSwNOv/EaZZcs504VisrxEFf4I
	dMQx+mybuMpJMugGsBuZBjlpsw5UMD/MDAp8bc44Gbbv6/NZkUwFoVv4vVJ/dSTKnEp8/X9e1TBn6
	Jlxr/w+O9zbsGdCyULZVABzdpMab2cbAWIjZJxUVMy2xLZ7FIUpYv9n6XREbAuCVT+XsgeeR34bf2
	XzkkQzbOLtEjhksQw5Z/i12mh64r1nOpHwjpQURicmCHrw9eVHydsCN7B6Wb3TcprUeN+3NoBs1Le
	VclE62VrPBOVQ0E2ZWsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFnB-0006oi-Pa; Tue, 18 Dec 2018 13:52:13 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFmy-0006Yp-Ey; Tue, 18 Dec 2018 13:52:01 +0000
Received: by mail-qt1-f194.google.com with SMTP id p17so18192931qtl.5;
 Tue, 18 Dec 2018 05:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LAmHWC5m3+BzfvmFaoVDZqSBTTFMzpVyTUIeG9Pxoic=;
 b=ZBCI7ZWDTOAxBYqZzMwkjg2ALb1g2yy1pSV1FIQkZMG4sw0KUDSK4OOOmCX0foDUad
 bMXnYeddgvLhz+fNdEZTcpTUJJhJdem+o3XkGrhUddzwpxExyiNpY2snEvXBV7pot2nU
 QhAOcG0TdHzaBUUDCQh1zCfQGW1nUJhdrghIDZhKzNZ+MeqU+eZXEfybJI+QKQhMgsZs
 vwGdeHV/V6he25UoetiBf+wED2omgAKB6hw8Y5S7/tnGOo08wF+3KaVLO2+W00g4LlWQ
 9GAeomJmp79GhEAHWproeH7pICFNsvRdewZa8ADU8JsoD4bJEARnbCaFajLAaU7BeQsK
 00VA==
X-Gm-Message-State: AA+aEWbLqy1w7fTMZu3UL18gQmm74/gUoqkLgRwjpKsH4gM2GskoiI6y
 N7KFyg4NDfs0VMBrX4Df9mRGslD6LS3wTj3x2n0=
X-Google-Smtp-Source: AFSGD/XTQcPAIaUGAF/nZ6n7tGNcZaDFf9X/Q/LIIFoOeXyKkIjelnOp+NUCP9WsZURPwXegKJNLGoi/eizllmInz6A=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr16731590qvm.149.1545141108624; 
 Tue, 18 Dec 2018 05:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
 <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Dec 2018 14:51:32 +0100
Message-ID: <CAK8P3a3h8upNttd15EfBTAAP_EQEbQ0fsqtjjzYy9QZdzj=jmQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] ARM: Prepare RDA8810PL SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_055200_606953_6FC32A13 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: DTML <devicetree@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, linux-unisoc@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Olof Johansson <olof@lixom.net>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, zhao_steven@263.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 4:42 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> --- /dev/null
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -0,0 +1,9 @@
> +menuconfig ARCH_RDA
> +       bool "RDA Micro SoCs"
> +       depends on ARCH_MULTI_V7
> +       select COMMON_CLK
> +       select GENERIC_IRQ_CHIP
> +       select RDA_INTC
> +       select RDA_TIMER
> +       help
> +         This enables support for the RDA Micro 8810PL SoC family.

I would drop the 'COMMON_CLK' and 'GENERIC_IRQ_CHIP' selects here,
as they are implied by ARCH_MULTI_V7.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
