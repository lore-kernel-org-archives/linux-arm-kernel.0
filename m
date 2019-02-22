Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906E5206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DWmCb8Xm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgEfWSaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906E5206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zDi6KH7bsrN+27qHg4XycnMGhcDlIR2x7yOmIWtfyT8=; b=DWmCb8XmLApL95
	scbGS0JFZACqZ7ea2RWhZsyqPf1JmhMNhVVjk822mVpoSuC1pMYXauwbYbhFnAdg82/BaWXUR5qrw
	MG2YvlvhSJHneX/KjK3QkTJpY1N6T36lTOKfC69j+k69Ta+qzTjmidXPwHXv+RMlO93IhUL+T9oL8
	y8JkpG4MopdvRoeEf3myh2/2FfiJQF4ed5FK98vD+/c+fHbp6NJv92My8y/iTDzOUpBl3rytzCUn1
	CdBy1DC3nu7P+klfweHFIbcCrYrXNbcCLB4cY7y/RgmSAMuW+1BGGsHrB+6N0nkce4rcULmsTdpUz
	0fS3QAdiY9jV0dqndzPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGkq-0007vT-0n; Fri, 22 Feb 2019 19:45:04 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGki-0007nI-GY
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:44:58 +0000
Received: by mail-ed1-x541.google.com with SMTP id m12so2738392edv.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ifgmbiF78nCDyGMffIIt4o/UXgInFLCICGdB5cP+ybI=;
 b=tgEfWSaSsSkoqcih+eYfXW1/DJHz1x7wpX4y9P8fW07dO0ildyZdXlSw1wuL18lrjD
 HQIPZG0ZsZCqGQQKV2RWmI0b96kNhbvljHHWznwpqog/PWQM7oQAfT219y6b1HZ6A/IP
 KZ54XlucdlQRJCJOA7T8BRCHRUV+1BXOnQRJ9E+fr9nLLz3Xs0EaTJ7R5spqu9cTd5q4
 9FgTQQVmbXl1WiqiVCeDU9sBBS9p66CeENNulBiDSYWXAHikru7683QOIPjItf38M0g+
 tSHKSiGLpAHHDwdIqsbH+1/07wh+RNTg5UQwxi8g1C5UTcBdk7noKmUkv+JlFkeigA7y
 c5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ifgmbiF78nCDyGMffIIt4o/UXgInFLCICGdB5cP+ybI=;
 b=Sh5opIeNVOABFPtWN5LUWwsYoCf2LmKgHvWnKBYPcFEm+jj7WsQOQeaPSP4F5VKpnt
 ju2Ms1lwpDWAEFuJBei3Iw4RngNnmIxaFHG/X5yWYaS1nm74ZS2vyEjeVN4blIM4EQ5X
 pfo7tktnCjWE00a8NfNIfnc0s8jjx5grHcode+Ack73PEO1GV8oy+2gL6AdsOHmuezCe
 noPgn1/pqrmLG+BeIVBNwDDXubbo1oOSWj7JM9pN9i1xuCf5MMpYYCk6ocKZGc0dohub
 IYAuUQfDlTDpI5iGZ9Xkkzu+9aHtyWAbo1isdr8CmAiAbBXQlCQa86C4rzotMFoKqMN0
 ejXA==
X-Gm-Message-State: AHQUAuYufcpx/cFKyznE/YIyiwqFrf3BIh7dhyOYLJqyY7xue2450VnJ
 Wjxs8CQmE4vozQdFA2kejmIW32mJeQbgihYt+KM=
X-Google-Smtp-Source: AHgI3IZ2xw3XOcDwKAU/1ubCd2CQ6/HP4O/xdEwblamZ7OiD2fnoauIiXlcF0LMsEoUY9GDTPknQWcLW9CgYXmr8hRQ=
X-Received: by 2002:a50:b847:: with SMTP id k7mr4455826ede.265.1550864694231; 
 Fri, 22 Feb 2019 11:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20190120015851.11797-1-angus@akkea.ca>
 <20190120015851.11797-4-angus@akkea.ca>
In-Reply-To: <20190120015851.11797-4-angus@akkea.ca>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 22 Feb 2019 21:44:43 +0200
Message-ID: <CAEnQRZD3YJqAUh+gh+PCpF+NMmyECiG=H8WA_hnKP7kPt2G8hw@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx8mq.dtsi: add the sdma nodes
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_114456_566130_6CEA7423 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 Daniel Baluta <daniel.baluta@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Angus,

What is the status of this patch? Most likely this should go through
Shwan's tree.

I noticed that I have also sent a similar patch to Shawn:
https://www.spinics.net/lists/arm-kernel/msg708424.html

So, lets coordinate and work better on this.

I am now preparing another series where I add SAI nodes and enable WM
codec on imx8MQ.

If you don't mind I will pick your relevant changes from this patch
and add them to my series, then send them to Shawn.

thanks,
Daniel.

On Sun, Jan 20, 2019 at 4:05 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add the sdma nodes to the base devicetree for the imx8mq
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index c0402375e7c1..0b9a9b5ae7b7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -336,6 +336,19 @@
>                                 clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
>                                 status = "disabled";
>                         };
> +
> +                       sdma2: sdma@302c0000 {
> +                               compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> +                               reg = <0x302c0000 0x10000>;
> +                               interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> +                                       <&clk IMX8MQ_CLK_SDMA2_ROOT>;
> +                               clock-names = "ipg", "ahb";
> +                               #dma-cells = <3>;
> +                               fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +                               fsl,ratio-1-1;
> +                               status = "disabled";
> +                       };
>                 };
>
>                 bus@30400000 { /* AIPS2 */
> @@ -370,6 +383,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART3_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -381,6 +396,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART2_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -432,6 +449,8 @@
>                                 clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
>                                          <&clk IMX8MQ_CLK_UART4_ROOT>;
>                                 clock-names = "ipg", "per";
> +                               dmas = <&sdma1 28 4 0>, <&sdma1 29 4 0>;
> +                               dma-names = "rx", "tx";
>                                 status = "disabled";
>                         };
>
> @@ -465,6 +484,18 @@
>                                 status = "disabled";
>                         };
>
> +                       sdma1: sdma@30bd0000 {
> +                               compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
> +                               reg = <0x30bd0000 0x10000>;
> +                               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> +                                       <&clk IMX8MQ_CLK_SDMA1_ROOT>;
> +                               clock-names = "ipg", "ahb";
> +                               #dma-cells = <3>;
> +                               fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +                               status = "disabled";
> +                       };
> +
>                         fec1: ethernet@30be0000 {
>                                 compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
>                                 reg = <0x30be0000 0x10000>;
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
