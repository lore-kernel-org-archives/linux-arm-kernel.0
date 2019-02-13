Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE61222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o+UnwuAb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XYJLElqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE61222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HHG+2T5mN3IuRrC0LKnoRb2JQoloT6/Of/SSc3E9cBI=; b=o+UnwuAbNBN8vk
	ZGhe4cGKVyHarJVoL78KhREVXYAoI2Mf4CJkSGsuecCBGRZSLfGIZrtxEjf+WOE6kZUC6uzsWRNd2
	QM0VytUzCZ8ORFu8CCDkj1UwgX6f4XdW5a7BxDZ43/38ntvPOqZjHikKqs60z5Juh9RP4aqbrIVAY
	hq3B5OXK2fTCf5h5OlvPDrpuuCWU+MdsVLa9tACBUr0hYxguCYglya6zXDU/DnnNFWgG/ij+Bw/ZV
	xOf3iYPe7LiufJ/aUtN7PFJXUUDjpc4zwH47mhF6bBBZMrdAmmAeur8u/WJu8u9GVRVW9P3gD6ROw
	h/WUBNJoCUk9Mprb0IFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtq4K-0004LR-Rq; Wed, 13 Feb 2019 08:39:00 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtq4G-0004K8-Hp
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:38:58 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so1460295wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=zYPxwD3KaOIMYFSe9JlfKDwbgdzNPJqs8i8EAHw3GRI=;
 b=XYJLElqVy8VQFvf52aNhx5HtzGexhS3IDntGrRaZgHf+urtk0shv8h3OzWsXWacOtq
 SfS2giUxQEu0Zc42qeNMxkZzMny66vkKrY9ng45RzLjW1xbp7G1ABDz5h87Nz3qyiRQR
 HnrhnR2VmtbNLX36z4TLJu88Nfgod91voNUFO0LltSKvoQ5AD/dViQwTndHFmAnqmcUa
 ChWdwyOGO14SSfAU0nGw+D1Eck68L3TfAtb5PiggJ2rMZxvLHMHtmA1QMOC3D9Di/yIE
 kvrgHm27lp9L9l4HMeIflqfDQxIcfl7YHPtsDZeJxbbvzxUDvyO0WmKoAcZRyTveBRsG
 is5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=zYPxwD3KaOIMYFSe9JlfKDwbgdzNPJqs8i8EAHw3GRI=;
 b=mgF9lEtBwlN64J7l+WpXtu9xeOiCoRL2pc7UXSdhGAckjVVp2yp9mpcF4RWC6J8/O8
 MqmJwZvFXWUslgkeAhIysyzHGi32feqlP39saNcADNPX53ASVPkDvIZW8hcoVmFI0eYI
 hrTNxVi3sLO3C51YewP8wkZYpNeJQpornTeEgdrVSkfCN7dw5BtiUn404GyqZ/cEAm3z
 lelrSPUTAfTzN8Ncl9yUt7pfM52Jhta1FIp4vcNLCZMZIzqcUKndnByITiOZtza1p/SW
 p8q+ghiGJY1JFzLUwupUrQ3GxJQEykOK/txQTK/sGSujOSRPUHbPIqKjtQroHiPXhopN
 ayfA==
X-Gm-Message-State: AHQUAubhlThn1Czq02RRB2uNF/rGRPajtsceOxZCbyJdlcQoKjp70LGO
 n8yZ3KRkwPnfW+tv0NhVtE69iQ==
X-Google-Smtp-Source: AHgI3IbDETGS5T9Qe1wD6lousIHYmIbj/GWqPRmQwncCH/7oQdwkT4kZ/2HczP1Rd6/XpL/H0syYLw==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr2267610wmj.13.1550047134662; 
 Wed, 13 Feb 2019 00:38:54 -0800 (PST)
Received: from boomer.baylibre.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id z3sm10337785wmi.32.2019.02.13.00.38.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 13 Feb 2019 00:38:53 -0800 (PST)
Message-ID: <98eaeaca26bc83db1a8d1f1362b56e3a32073bb3.camel@baylibre.com>
Subject: Re: [PATCH v2 0/2] clk: meson: Add G12A AO Clock + Reset Controller
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Date: Wed, 13 Feb 2019 09:38:53 +0100
In-Reply-To: <20190212162859.20743-1-narmstrong@baylibre.com>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_003856_732639_FBAD37E1 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-12 at 17:28 +0100, Neil Armstrong wrote:
> This patchset add support for the Amlogic G12A SoC family Always-On
> clock and reset controller.
> 
> This adds support for clocks on the Always-On domain like :
> - Always-On UARTS & I2C Controllers
> - CEC Controllers
> - SARADC source and bus clock
> - Infrared Decoder/Encoder bus clock
> - USB 32K reference clock
> 
> This also adds resets lines for :
> - Always-On UARTS & I2C Controllers
> - SARADC, Infrared Decoder/Encoder
> 
> This patchset depends on the ("clk: meson: rework drivers dependencies")
> from Jerome Brunet at [1].
> 
> Changes from v1 at [2]:
> - Moved unused bindings ID out of the dt-bindings header
> - Added comment about CLK_IGNORE_UNUSED
> 
> [1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
> [2] https://lkml.kernel.org/r/20190204091331.9298-1-narmstrong@baylibre.com
> 
> Neil Armstrong (2):
>   dt-bindings: clk: add G12A AO Clock and Reset Bindings
>   clk: meson: Add G12A AO Clock + Reset Controller

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> 
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
>  drivers/clk/meson/Kconfig                     |   2 +
>  drivers/clk/meson/Makefile                    |   2 +-
>  drivers/clk/meson/g12a-aoclk.c                | 454 ++++++++++++++++++
>  drivers/clk/meson/g12a-aoclk.h                |  34 ++
>  include/dt-bindings/clock/g12a-aoclkc.h       |  34 ++
>  include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
>  7 files changed, 544 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/g12a-aoclk.c
>  create mode 100644 drivers/clk/meson/g12a-aoclk.h
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
