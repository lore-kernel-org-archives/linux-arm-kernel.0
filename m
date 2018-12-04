Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF06C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:00:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FD220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pj7eAgSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FD220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HqT14lc+ph798ZYCRudp7tEQtMGh2K57d9CBXu3QJrw=; b=Pj7eAgSEqVnkZC
	OjXJxnpCVcf5F2kxl1TvMjzq0lbPcADmD3dBrW1tHsWtvTwlvdrspWtYkqptpyz3jeEDmLdhs7Jc4
	sVX1wdqqBcLKTptfJAXNXfZNzca5Waof0eJjkMiSSHqaL7N3X2diTWRMwxjh+ZXgKx1Taupyjgyf3
	ukK9cK3m7ObdEE+dD2SxJc3zs1vUYYCmopEiQdSjAzzY6/OnFg8/bQTFaWTYpt8qb+AqsW4tCKAUE
	3TCtzCHEOMex6xvWWSYwG5qCfvUKusDSR0y7DbyPzoF/a5vrEwJfuve8JLAFXe9AcGycb/57UvDuc
	yDEG73I73Zk0P7HCn7ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIkI-0002qf-P2; Tue, 04 Dec 2018 22:00:46 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIkF-0002om-DZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:00:44 +0000
Received: by mail-oi1-f194.google.com with SMTP id c206so15758028oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 14:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RvdL6g82dBKJwWXQ6bJ1APyZTwb08zuWUhTlE2NkCcM=;
 b=Lp2ebcLD7Cu9h8g6VU8MjfmRjK628DcrjRphlSff98nia8nur5OjEJr0K4nMwFxDgb
 3GeN773EWpiuOB0GLyYHmQlEBWvgst4m7Cp8Yrp2cRo6OIL9WHfSWSvwfZ8xno06KSuB
 R1h0EE+0F6CO4lqEHidkCU9fMxNywPuJb+kDPYT/VriuCi9XpbszEa2DFW1/LqJ+sxtw
 yPGFsr/0FqYxcVuUxE1H/MCSfkXqyDi54NO3cifOTlMydn7k/Mno2I0kDBBstejrTVmP
 aoXboXBr9Xm2t9Ud9v326nwfD6ukHMox14SR0pMN9cHVkIdSMVk3Wd5GdbbkRPvF9l9u
 DJ9g==
X-Gm-Message-State: AA+aEWa8k7NjdPMUShiOm0ztmCxc8dYj9a2PGDS7Vo0psctH/UlDT2TV
 6sreYh+XMT1X3U3HgqPdFw==
X-Google-Smtp-Source: AFSGD/U28w09IagczE4CApxL4dJbWj+whe9cGCt/JVpHkFpUtthFKcFhgohMQom30UVqsH1SE6ZMyw==
X-Received: by 2002:aca:7581:: with SMTP id
 q123mr14031306oic.176.1543960830327; 
 Tue, 04 Dec 2018 14:00:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j33sm14752056ota.32.2018.12.04.14.00.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 14:00:29 -0800 (PST)
Date: Tue, 4 Dec 2018 16:00:29 -0600
From: Rob Herring <robh@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/3] soc: imx: gpcv2: add support for i.MX8MQ SoC
Message-ID: <20181204220028.GA22718@bogus>
References: <20181116154927.16152-1-l.stach@pengutronix.de>
 <20181116154927.16152-3-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181116154927.16152-3-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_140043_452763_68A9A7AE 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: devicetree@vger.kernel.org, Anson Huang <anson.huang@nxp.com>,
 patchwork-lst@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 04:49:27PM +0100, Lucas Stach wrote:
> The GPCv2 on the Freescale i.MX8MQ SoC works in the same way as the
> GPCv2 on the i.MX7, but only controls more power domains with a
> different mapping.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../bindings/power/fsl,imx-gpcv2.txt          |   7 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/soc/imx/Kconfig                       |   6 +-
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/gpcv2.c                       | 208 +++++++++++++++++-
>  include/dt-bindings/power/imx8mq-power.h      |  21 ++
>  5 files changed, 237 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/power/imx8mq-power.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
