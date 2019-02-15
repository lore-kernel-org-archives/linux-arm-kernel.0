Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81112C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:32:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFF02192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rvogqr9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFF02192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GJ5qmsWbodfLf9uWgLIfUHrSPFObd1r4hxfDnKX2q4c=; b=Rvogqr9en87Yvn
	Ds4Kp/WCplcqiNTCjopnccMC0WGme7YwRC4bCE5cy0NBJ6cN1vr33Ydu+fb3lS2B9WpNmvlFl9nz1
	1mr3EdqFwxMZDhI0O3muQWMXWvbjEcakNutlS9spiw+3YfWhNXc6M+3jgJ6aLY0s3SxTIH6GeOu2G
	pmX4DEjgyiRf1eplZ1SyK4sjAYg9vsbNKo9a6xvlHBCLTgg9VSP8jBVbOiBIlziN9aPpGS9rhVrft
	PmpcKnZkKGsc+kMvgdJYAm3PSsK0B3EdbokjVgFIxY1gFpyZKbqI/VZmMTjhNBd6IAyFnvyGJFk3/
	c7DeENRmtrEATH4mCQAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueXF-00070m-OV; Fri, 15 Feb 2019 14:32:13 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueXC-00070R-DJ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:32:11 +0000
Received: by mail-qt1-f196.google.com with SMTP id y4so11014028qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZtlhZ6LSocXlByLhn167GyhXfgQhenriK+nVtq2zjsk=;
 b=IZPKwNgBHXP6N/GSwyo9NlPVPaNSHQmGOugHqqUWKrznVw3LhsrNYCciqotAxStX8f
 u2TxG67BlYZgBB3a8tm3TnWuL0/Ou0w3ZJlxJkD8X/L7LruFW82SUS1FLfuoJWq726Pt
 xF/MFMvhj8T4sMJQD/75M5luQ+2kePYYRBoIhpZ5c9ZhX8iu817xaVnSTrlzkdkHQlFV
 8ElwtFvboiU7QPM78duQu832R3EOBbaEiY8EuQ38MLQrOM6+COfpmaa/u+8DkJMKRZe1
 hGfxAyw+IDNMpIJm7yJKKE+Xy7mZojMAQC689Oy9N7f04cdmiVkvX0tB3lYLq5DYRq+F
 IWmQ==
X-Gm-Message-State: AHQUAuZfQiTCLUOZQWByfBEbU+0AQj7mTxREcTRBPbHtKXzAVDxKxLcd
 KGpvJ6eH8YYcZP2vfCTUvKtzb3DwBFUM0AOjJadKlQ==
X-Google-Smtp-Source: AHgI3IaFYltdMkUEXkvXSYpI25nwuy7iDfElsj6643H8vrc0HxjnwyZ4Z2m5SzsTS3DdxV89lkgtWiI0xKJH4QhgSUs=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7476694qtm.96.1550241129380;
 Fri, 15 Feb 2019 06:32:09 -0800 (PST)
MIME-Version: 1.0
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:31:52 +0100
Message-ID: <CAK8P3a1K+oUTrq903=8zfguJRXCQDvaXLT+TY-u6P8Obpr3myw@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 5.1
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_063210_449410_7C2BF45E 
X-CRM114-Status: UNSURE (   9.00  )
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
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 5:31 AM Andy Gross <andy.gross@linaro.org> wrote:
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v5.1
>
> * Add MSM8998 RPMCC, I2C, and USB related nodes
> * Add MSM8996 rpmpd node
> * Fix typo in MSM8996 pin definitions
> * Disable MSM8996 VFE smmu to fix security violation
> * Add I2C, SPI, rpmcc, uart, and WCN3990 wlan nodes on QCS404
> * Enable SDCC1 HS400 support on QCS404
> * Add a multitude of nodes on SDM845:
>   SD, UFS, USB, LPASS, SCM, QSPI, PDC, DPU, videocc, GPU, RPMh
>   bus interconnect, WCN3990 WLAN
> * Add gpio ranges to SDM845 TLMM
> * Fix regulator load on sdcard on MSM8998-mtp board


Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
