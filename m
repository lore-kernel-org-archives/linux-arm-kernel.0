Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF2C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256E62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmKqAko2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="StHqyOBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256E62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=McihB5LyyI5HnBto3NUqH0njoc3ozfbUNdpd+QoAhJ0=; b=hmKqAko21ndsQG
	cY6CJAtEvdaOIPqO4PrAVsVlrEERs9SWx2VDPrikbfwQ/DhmUt2usO0lWR0cRIUVscCMl9UQGShSM
	m/4Q+AVrdxB7Vj0uqF0mPWPtc3Fd6m+6zO5auj+uByarBHevBBqrFGTX87GBch2UPz5sUZLJ2vj6w
	TYYV8l9hZJ2WPMRdmmjsOX9+FPvywZSSXmUP2ivYHIiUwWG4I7GN/q+dEiZrmDAXFtnPpZx2r3UBC
	nfc5Bj+39SRmCVmlXGouvDE7Urt9ooPdmeA8H5lZqrD/j0Jg2Vq/7rcAsOBg04LMZ9LaC6veJPJw/
	q4uqJkV0uCRRHao9uz6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBrU-0007Jv-P7; Wed, 12 Dec 2018 21:16:08 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqR-00051e-Th
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:08 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so14665980lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YdpuePiNLly0vguTv4Ppdc8vFHV//iCHE1xer6ZfKIk=;
 b=StHqyOBP54EQNOJaywsRX1P3HoEeJJHfr6sCddI6IZvVa+7ffWsckakzPCAfVllctD
 RLOOmupJJvDmS7PVSfVPPCj3olLh/kkYzF8hgVrNNqYQlxIppmmUuYtVVPTVberaC6kf
 kmK70XOhFGQHA/yUaNLPuxkcEw2UVp6k4RkM7C39nb4IeeS9xXfS0TJuHcIDr7+Bim3Z
 JLIpDZa6Zs0zAOtQ6cu0OUVTpZfZ/HvTuYMW1E3VnVoWKnZ0HGdXxz4ahNDEST+LSyWk
 w/USdhArUBQT/CY13fPoUJ64jVtH9j58Sn0YNdDEYhhOLlpI9/5O61gHKf9vUIcl26hr
 FjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YdpuePiNLly0vguTv4Ppdc8vFHV//iCHE1xer6ZfKIk=;
 b=MTvNOO5rgI9d+XY3p8R/c/uFnL+g14BMlgrapxAIybaVnF+D/eisyMECNF57o+ecEw
 bs1c65SN9I0L4MBvDanKKVpAYnL63OzRz4DEuxfJEgNcKj4+OeMWfz8U2kjrR0EHQuqp
 qy5ei/iai4ekkRBWIAlArYappx6aaTqc9NbG1dPehSGCj/EwTvYcgRw9YiMcPY3v6/UF
 eBTdssiNHN8ufQSUN2zdewdrNdwK8Tj8YTIS4nEH9r/ETbpKOjoLZ2LsOfR9ETi0qKG/
 Bw0kfFUY1i8w2vxVIwUEuiFX4OLz4ur/53lJlfOv4VO2khTLYMubKlBfmvUnoUOFILyY
 Lkug==
X-Gm-Message-State: AA+aEWaaaRf+ntaHBF31XfxntBuL0PdMQXrMCwHEyl1al5kWZMA8QBSd
 gBuMl2q9hrjZAQajQ6Aaol5l+Q==
X-Google-Smtp-Source: AFSGD/W+DWd36hSnRYzjoIYuu/RdNw4VAmkXmaVi/ujrfQeuq/hveQugD1nBmGJwbtkSUupg7VRtIg==
X-Received: by 2002:a19:d58e:: with SMTP id m136mr13653233lfg.70.1544649300588; 
 Wed, 12 Dec 2018 13:15:00 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j18-v6sm3439250ljc.52.2018.12.12.13.14.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:59 -0800 (PST)
Date: Wed, 12 Dec 2018 12:55:05 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 3/7] i.MX device tree update for 4.21
Message-ID: <20181212205505.x24znoxjjcqvhi2w@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-3-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-3-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131504_356371_0BF2A3EE 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 03:46:34PM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.21
> 
> for you to fetch changes up to 79da07dec740a42c70963ebacbd2bf8866af9e20:
> 
>   ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1 (2018-12-10 10:03:19 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree update for 4.21:
>  - New boards support: emtrion emCON-MX6, imx6ul-pico-pi, imx7d-sdb-reva
>    and vf610 based Liebherr's BK4 device, ZII SCU4 AIB board.
>  - Add flexcan support for i.MX6UL SoC, turn on stop mode wakeup feature
>    for flexcan, and enable devices on a few i.MX6 NXP boards.
>  - Enable AUO G101EVN010 lcd panel and Goodix touch support for
>    imx6ul-ccimx6ulsbcpro board.
>  - Enable sensors support for imx6qdl-sabresd board: egalax touch, light,
>    magnetometer and accelerometer sensor.
>  - Switch more boards to use SPDX identifier.
>  - Fix memory node duplication in i.MX device tree sources.
>  - Correct GIC PPI interrupts mask for i.MX6UL and i.MX7 SoCs.
>  - Drop 'snps,dw-pcie' compatible from LS1021A PCIe device to avoid
>    incorrect device matching.
>  - Add the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, which
>    are now supported by the freedreno driver.
>  - Add DCP device support for i.MX6ULL, which requires explicit clock
>    enabling.
>  - Add '#thermal-sensor-cells' for thermal device and '#cooling-cells'
>    for cooling devices.
>  - Add missing clock information for EPIT on i.MX25 SoC.
>  - Add PWM and qdma devices for LS1021A SoC.
>  - Update cooling maps of LS1021A SoC to include all devices affected by
>    individual trip points.
>  - Random device addition and cleanup on various boards.

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
