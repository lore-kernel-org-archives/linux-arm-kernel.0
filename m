Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B82C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BC220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeF3arL5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhp202b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BC220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Px9cmb+bgm1Ykk2+By/BLBq5KJ8TCNKuv7+ZVXD5os=; b=BeF3arL5/Gz0d8
	NkCFpjN2jQZQ9JMApq8UmKaybHwDsXAR9EwNfI49onCO6v7X9NdYC1lZU5AIqtGvP7uiR5fM4DwGT
	kdIZj/XWiH9P/R9wiqFCQypNhWWiwMDMSBQ/tlKkElHhDds8ofS+ao9YY2J5+2Y20vYNDENbvvKkP
	ugLm5zg3n+1EFy3mnJVlnpF6UaawKDNZ3agNCPCxFJkVUgGqCWsECtVxtn+SbyHSeC5q2FtDHHbQs
	f73B9dcw54DWlmT7Sy6s0hyJBx1aOcATzYHz36qthSyY2Igkn/gPiHyC4b+GUgUEUKzCECyKvz4Vn
	wZ+ZqrpKpoPDX163t4cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUidF-00057L-SK; Thu, 06 Dec 2018 01:39:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUidC-00056Z-Lc
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:39:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD0F320892;
 Thu,  6 Dec 2018 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544060340;
 bh=o4bOxBc3/RpN5Q/XLLq4S054I3d8KZ5XKytIr7MDJdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uhp202b7f0jY+xyzwPSRsOhjF+2GdqwqveVAUV62CK5+KzF+mGkFxzxbEOtRuhVe8
 n4kZKeXiAGuSSULLtUIzZVCQtJyYE2WpA3etB7BeTkUebW4MbB6Cqm6/bJUUEwdCRT
 eZTBPlg3gzR2aMSVx9M5X8wySzD9SEqSdQGvyNqQ=
Date: Thu, 6 Dec 2018 09:38:19 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 7/9] ARM: dts: imx7d-pico: Extend peripherals support
Message-ID: <20181206013818.GU3987@dragon>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
 <20181202212520.16650-8-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202212520.16650-8-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_173910_724959_58A08247 
X-CRM114-Status: UNSURE (   8.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 07:25:18PM -0200, Otavio Salvador wrote:
...
> +&uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
> +	fsl,uart-has-rtscts;

Use uart-has-rtscts instead.

> +	status = "okay";
> +};
> +
> +&uart7 { /* Bluetooth */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7>;
> +	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	fsl,uart-has-rtscts;

Ditto

> +	status = "okay";
> +};

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
