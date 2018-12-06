Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680FCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:41:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F91420892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izYCvGOv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgv9hHPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F91420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d2ZrMzYi8jKD9HNX5StmDJeP1hIhtXlviOsDTGqY/Vw=; b=izYCvGOvwW2Qts
	f+ovNVR6gheTxHiCfgUp+/ELLdMVft0DTC/NutmxpyA1DPPXVP5BR7YdPhdLghCQRHlp1g365oOZC
	qgjSzHhkGnV7o3NG/50FfsWcphOhb78UIsqz7HQPbE1WevcTU4+qlJXXRSp5Uz9LvJvjTjHWaXuDz
	OYrFQkSnmC2wtW9UEuXyhNl1N9qBIpbR/PP3rigNqgjdCzpG4Ks+AAS+4T9iv9xE1oxkl0r3UJs3E
	/AzqtPTVYkm6tsINiHb7Ps84zA6t14bIaRxT3dvxkt47W4KfcL1h+fKUjXVUScsYBvOBOtrhBVwt3
	NKF1xGPcZbVQjYnrYvZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUif2-0006ns-9g; Thu, 06 Dec 2018 01:41:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUieq-0006dY-Di
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:40:53 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3545D205C9;
 Thu,  6 Dec 2018 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544060442;
 bh=pWxeNia+YaLSnHDguFDAptVM0w1dUjSe1Qe4eXfmRsE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dgv9hHPL7qPEXEx2NUQqA3OpKWK2u/BZ/hueXsTZ7fMmnz/iTJ4vN6/0U/ey0TMFl
 46ZlrRx1KQBZO/GwxdjPaii5z6gt1Pdp+I6aKhGuAQ7aJZ5ehgRMXrbtqG9GXXT6pD
 CVEkNVMb66lgAyFlnx+rRYa5doBGjf1cmsNIpfSU=
Date: Thu, 6 Dec 2018 09:40:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 0/9] Improvements for i.MX7D PICO SoM and its baseboards
Message-ID: <20181206013959.GV3987@dragon>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_174052_473831_32BB4872 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 07:25:11PM -0200, Otavio Salvador wrote:
> This patchset rework the imx7d-pico SoM, its Pi baseboard
> and add the Hobbit baseboard support as well.
> 
> 
> Fabio Estevam (8):
>   ARM: dts: imx7d-pico: Do not harcode the memory size
>   ARM: dts: imx7d-pico: Switch to SPDX identifier
>   ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi

The applying fails on this patch.  Please rebase the series on imx/dt
branch.

Shawn

>   ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
>   ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
>   ARM: dts: imx7d-pico: Extend peripherals support
>   ARM: dts: imx7d-pico-pi: Extend peripherals support
>   ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
> 
> Otavio Salvador (1):
>   ARM: dts: imx7d-pico: Improve WiFi regulator name
> 
>  arch/arm/boot/dts/Makefile              |   1 +
>  arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 +++++++
>  arch/arm/boot/dts/imx7d-pico-pi.dts     | 180 +++---------
>  arch/arm/boot/dts/imx7d-pico.dtsi       | 355 ++++++++++++++++++++----
>  4 files changed, 457 insertions(+), 184 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts
> 
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
