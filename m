Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E9B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yz2600ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E9B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LUzNssdVEaI4NUzJuFOdt/JijrCjoL170DqLgiG1CJY=; b=Yz2600akXdvpSx
	HJ+P1qyI2kq+t5Y/uRrbQ5nqGR8YBfDI0kmrd0yG6FwIY1gaVidtzD+wNrkGa6bonSrNrooNehhuT
	htlh/c/YboCw1Sqcvd1ckZJ1GMYpZdtcVO7nelWyWJt1HqeJvs5OLkOT1RfLwNnHfXTaRUsf9obAR
	zRprTSuWS8HPl0YRBVhaZoLFCmztxSNSU7lZSOHNSNp390OJx2F8b1e0TeY9N6JBsOzYiTxK9kniU
	eETMVok7uDqPWMlY4olqxnjqVRaQnSpaYHjwS3W41ffBHpVTCBV6YIlwu5nOYvpERJMipM+fl4VM2
	EnmOm+ZgJCy0YhkJCkCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvg2G-0002oM-LC; Mon, 18 Feb 2019 10:20:28 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvg2D-0002ny-Kp; Mon, 18 Feb 2019 10:20:26 +0000
Received: by mail-qt1-f193.google.com with SMTP id 2so18559800qtb.5;
 Mon, 18 Feb 2019 02:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fMASI8Kl0kMzNKT5pTFxdsz8hPoKLQaP8gNI7fXdG8k=;
 b=bIwSfIkgO/StKe6QUEaGAyAL+psRh5XdDIjRvOJRWh/8WMWJaWD3UeJS0xxOEyXDYJ
 uctzvhZxDZFriEfssfdQnXXuJfC0RclWr5cU4EX0eZwkqZ7yvgQNXV521dbjwcQu2n6R
 qqCeNkAiboZPJFDJIerCB9J1MMQhGyj5U46nONrhPKquUVksdl5LJwgVetz3B/6dd0LI
 1nrZm3DftD5BwqDgaZJL0ghLCePBNxe+CpFOmS8rjkkH5Yw8tPdaBeMrKP+Cu6wDjZJC
 04fwj+LO9sTNVHJLgOWpJI7bipKp3hDDxYHzVsPpJcBa4qr1F1FEE+8vSnpV6DrOmk/e
 +HWg==
X-Gm-Message-State: AHQUAuaUfa3gLqnXFRMj0tA+qW9WGirsbgq6EeJlsqNl20t2LU0ADRL5
 6402DIZ7Rn5AnLW1cjv04YB8BTSY0bMTgBk1qfs=
X-Google-Smtp-Source: AHgI3IbPsGNns3VcoTc5TvXODZ3zts5+lOXQ+FKNNIE7ylyafToQlzS/pEv/1cWxoA/aWA2GfSrx/pBP+g2/vp/fKTE=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16966761qtm.96.1550485224476; 
 Mon, 18 Feb 2019 02:20:24 -0800 (PST)
MIME-Version: 1.0
References: <1972197.JU0Au1QvNm@phil> <29818451.VkXVVsXLZK@phil>
In-Reply-To: <29818451.VkXVVsXLZK@phil>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 11:20:07 +0100
Message-ID: <CAK8P3a3mnfrBwCQQRReHRmOt_osr9KXC9svPT6AvEp8L81UhSg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip dts64 updates for 5.1 - round 2
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_022025_681395_C8C1A59A 
X-CRM114-Status: UNSURE (   9.81  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 1:19 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The following changes since commit 79164c99db284d07aa4e84e57b469d225609799c:
>
>   arm64: dts: rockchip: clean up the abuse of disable-wp (2019-01-28 10:51:22 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.1-rockchip-dts64-2
>
> for you to fetch changes up to 02260a619efe574d0f6c2a4420b8b76c6802294e:
>
>   arm64: dts: rockchip: Enable tsadc device on rock960 (2019-02-17 23:59:05 +0100)
>
> ----------------------------------------------------------------
> rockpro64 regulator improvements, rock960 improvements (tsadc, wifi, hdmi
> audio), nanopi4 bluetooth support and rk3328-roc-cc gmac improvement.

Pulled into arm/dt, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
