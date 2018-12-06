Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B725C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C8120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9BC685H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsXFW2TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C8120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lLrgrOzGtvkOmiR0oidZCsRGieiVQNelGqauUIWGoQU=; b=g9BC685Hu2mDe7
	+JSrOvbcTrxqE8Y47CICONHMRF/hoBzAXa6Y6onRUJE5yw3QexD1TXip37toG3P2ptBkMxImgsZB3
	mPWIUlCM6dJB0EYop9gGcsZOzvlqFve9AO2Ry+qZpYGwwOziRLtIQtj9EAHuUSLkErRNmz0Qh/YHD
	bu2PHdvqJX8+FjyTIptOPs3fRz/qnwMVU1v218dK07KZ+BwcHinfDJpCi3QZGb5Mb56JVFivyym7S
	TlEGCxFWxoB431HKrP91DrhmGvUUPG3VGWi8LbSOE4z0QIc/j7+UN5T+S7seHL3qkU7KLSg3DEt1n
	5YzmZqIxOGSZO+m9WWLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUv3r-0005pH-5q; Thu, 06 Dec 2018 14:55:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUv3n-0005oy-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:55:29 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA42F20850;
 Thu,  6 Dec 2018 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544108117;
 bh=7gXGYXJHfL+OE8p2/nMMAPl8B1uMltZzx4WHZQY76+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lsXFW2TGyKQZtxU/2yTASmiRRPmNpRtrouDDegqYfGM2rx9HJhzf+F/qa+N4AdDtH
 2ejpTmHEn4aBcXq130GxRhMTrpHKFfilMbzaQ0F3jyFsYlv6xIEaShUevzTZcS0ogh
 PBhgdPcFEaeQv6qsgo/cCu3OlYd9LJhZaCW5DPNk=
Date: Thu, 6 Dec 2018 22:54:31 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V5 5/6] dts: fsl: add imx7ulp evk support
Message-ID: <20181206145426.GF12929@dragon>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-6-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1541862478-7839-6-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_065527_837988_44E07085 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 10, 2018 at 03:13:12PM +0000, A.s. Dong wrote:
> The NXP i.MX 7ULP Evaluation Kit (EVK) provides a platform for rapid
> evaluation of the i.MX 7ULP, which features NXP's advanced implementation
> of the Arm Cortex-A7 core, the Arm Cortex-M4 core, as well as a 3D and
> 2D Graphics Processing Units (GPUs).
> 
> The EVK enables HDMI output for simple out-of-the-box to bring up but
> allows reconfiguration for MIPI displays. The EVK is designed as a
> System-On-Module(SOM) board that connects to an associated baseboard.
> The SOM provides 1 GB LPDDR3, 8 MB Quad SPI flash, Micro SD 3.0 card
> socket, WiFi/ Bluetooth capability, USB 2.0 OTG with Type C connector
> and an NXP PF1550 power management IC (PMIC). The baseboard provides
> additional capabilities including a full SD/MMC 3.0 card socket, audio
> codec, multiple sensors, an HDMI connector, and an alternate MIPI display
> connector. Additionally, the EVK facilitates software development with the
> ultimate goal of faster time to market through the support of both
> Linux OS and AndroidTM rich operating systems, as well as FreeRTOS.
> 
> This patch aims to support the preliminary booting up features
> as follows:
> GPIO
> LPUART
> FEC
> SD/MMC
> 
> See more board details:
> https://www.nxp.com/products/processors-and-microcontrollers/
> arm-based-processors-and-mcus/i.mx-applications-processors/
> i.mx-7-processors/evaluation-kit-for-the-i.mx-7ulp-applications
> -processor:MCIMX7ULP-EVK
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Changed the subject prefix like 'ARM: dts: imx: ...', and applied the
patch.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
