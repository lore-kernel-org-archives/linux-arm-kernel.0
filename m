Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51664C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DBE20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cxR0lQH9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpNqPE51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DBE20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AmK/FITgEEpdMGhwMDeocfdI1hWp3s8VwoMAxzrNzio=; b=cxR0lQH9LTmAxL
	h7MpsQz4Df3pDjfQdjK9EktvDgvfMHdDzytVC+AwTwX/RVFg9N6HuCNYhfhlmZmdcmrg/6Og2j7gv
	NFG13jQ813FKjSrNuuUnSF3U2shiGKpMOrI8VWFJrZFWvcid4xzOOh4s5HmxHY6eGmtIIC8bGGTQg
	LU7XC5ld5g5msbswZKxNCkZmCtWvG/wapDdbe1OvR0ZZw7hnEGNqmaLlZk1AG7gCaKVnRHcsvrIqD
	dpqnmahn+2BqJ+ydiAwlaEFs+5DcjTRva+cIpCQMSrmGYCjZNhzJHaRnvYz6VuW3T71GpXh+1oEC5
	CR/9BO6MXWbq9W0xkGaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGMt-0006qy-Cu; Fri, 22 Feb 2019 19:20:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGMq-0006qX-M2; Fri, 22 Feb 2019 19:20:18 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B638E20700;
 Fri, 22 Feb 2019 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550863215;
 bh=Zir8+AgmPOQ7b5huwSNLe82SQfH4bXQoSPho4owU5AQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dpNqPE51vhh0XVSEJ9CEPRIbLXsVc5nTCZt2xA76pARmV0Ur2J28puD03JQYeEq9t
 Ia+69DazROBkFb4KFZ2aaLSdKb9EL2PT1YObLmEk27727ml0NuyUfLjbCSMQVRQa+V
 TRg2mVd4lZGdAbdVZPh2pKUREvUk/KUyy6oRi8sI=
Received: by mail-qt1-f172.google.com with SMTP id v10so3762852qtp.8;
 Fri, 22 Feb 2019 11:20:15 -0800 (PST)
X-Gm-Message-State: AHQUAuZJma1ei9d/gW0oye6AgX5qvrblQawkebEsanMiaErGavyL/83+
 0/VcafzBhtiNu8CL5lNBeKCduF8yiF8WiT0aug==
X-Google-Smtp-Source: AHgI3Ibv14C87kkUH1h+yaWSUpiaOTiXeO8xNObwnN8X2cyeecw4FMUAKWGO1I0GbAb4XN8s7S9yddtjNoo33qz7JaQ=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr4408248qvb.218.1550863204950; 
 Fri, 22 Feb 2019 11:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222184419.14469-1-aballier@gentoo.org>
In-Reply-To: <20190222184419.14469-1-aballier@gentoo.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Feb 2019 13:19:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLubJ2BwpgyzDFPUzyqjZZNO9spdXTuHHyTRsx_kxMfgg@mail.gmail.com>
Message-ID: <CAL_JsqLubJ2BwpgyzDFPUzyqjZZNO9spdXTuHHyTRsx_kxMfgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add support for the Orange Pi
 RK3399 board.
To: Alexis Ballier <aballier@gentoo.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_112016_740171_C67BB1F4 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 12:46 PM Alexis Ballier <aballier@gentoo.org> wrote:
>
> This adds basic support for the Orange Pi RK3399 board.
> What works:
> - SD card / emmc.
> - Debug UART
> - Ethernet
> - USB: Type C, internal USB3 for SATA, 4 USB 2.0 ports
> - Sensors: All of them but the Hall sensor.
> - Buttons
> - Wifi, Bluetooth
> - HDMI out
>
> Signed-off-by: Alexis Ballier <aballier@gentoo.org>
> Cc: devicetree@vger.kernel.org
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
>
> The board is heavily based on the Sapphire one, hence this patch is also
> based on this DT. This is why I kept the copyrights of the sapphire DT.
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-orangepi.dts     | 778 ++++++++++++++++++
>  3 files changed, 784 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
