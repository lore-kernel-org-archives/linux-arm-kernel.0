Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A1C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:18:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DDF20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uF/kcVnH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZsFTTKv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DDF20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ti10bJv5o+9q08oJqkgSs4zr3YiRQge4aThN58Hy6Ao=; b=uF/kcVnHWeXxLm
	qf2g8CSqnf58ptjhQ0fS93ga9GjWgNI3Vrh3UEBbxhmqL+59EsqQrK14BpZEWykKo44Y3HR2ttHii
	bdNC8uwqmckvquHMIboPVF+mhfQQhSBlD63mj5tBh+Z/mQchF7jqUFa1XM6Z0RskyCV4+z43O+aTu
	0iCiCtokHGYInnaeJa5iQ4nwYb/zJNUTHPIuoYmVZV1ZaAltSd+Q/Q+sI8mtHc9wuTdK4IoToyXjV
	t2BQ1MMfzoYauSaE5IXyBG0SiGQF17FNgCMWrmUYNMUWbU0SD8Uly5owm8k4zd9w63omUb52olXgK
	FvYgt25MQEBMII1UBYiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBtH-0000kV-7r; Wed, 12 Dec 2018 21:17:59 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqg-0005JH-Nw
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:22 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so17584554ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EOgv8KhmpvnsQPgqEmR7I+qtCDYKNh9ZK9ZmyiyYG/w=;
 b=ZsFTTKv9q93X3PrqK0FtP3dNO+ulSqMrfWQFdXqmYw91DI5i+tIY1oLl/EGyeU+fvF
 cjWgjdqx4IZNewYlQC598V55S3zfgnk7JiwQA0f0HVBIgliHdHAvYCQ3o/P7iSUgs20I
 VCTFJoFvLj9aW5IJI84c+Sv88q85ylQfpxOcB3zACxbkRHgQdKP3jgApL37l9yZERnii
 WoYev0tK7yQhP94hM6OuxbaRtm9m271DPNYZAa5pRADRRTZ2KN5tsmtteiXlYTOwk/Hq
 QCzisA7qb51eRUCVfM3ebSdjp8Z4Sni2dyHQUZCDK2Im1P2VCTXvxm/Rh0xPa4F4XJLP
 OvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EOgv8KhmpvnsQPgqEmR7I+qtCDYKNh9ZK9ZmyiyYG/w=;
 b=elF8KDWaEpcPmY5UrYBJeMpzolLqCJwRc1WpUncVqp9GQckw/PASzICuPC6v3jGSRi
 T3CAHuRJkNwPxbcn4XmAdaXnda/Z9b5WuZexMQN3NNUMPGFuRIB26Kgdt5+nm8zZggAR
 3wTQburd4KLBaLMVRcNxVm9cX22RX+bS2ByHXwUg2FNpD0ThbKazn0NhX4pjooAHTERV
 jbWr7W4Wi09q/YmiHoKaC24B2WdUwWQgc4ZRHDk0qs5weAFPoqmN0JqMRdfdxNWd6QeL
 rBXiwz6eXmfCwb3hLSDMcBac3gXuZQbqgsT66i+WHmBdYbYeY9p83jsX4fVziaNvFvyr
 t+sQ==
X-Gm-Message-State: AA+aEWaffDalqtzHCUxeG7LVDL2ota87HE9RBxBZy/1Gzue9RGdgG+Eb
 Kl0GLMVLXp5GnCKRwf9yh6DNQO5dG+EBoQ==
X-Google-Smtp-Source: AFSGD/VSGn52TVNPvbxYiYDPDQJNsD0roqf1hn5pht+ln9McZcDRIuaCAb9ZUBUogU1F4ukokmRcYQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id
 p16-v6mr14161293ljj.102.1544649306829; 
 Wed, 12 Dec 2018 13:15:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f16-v6sm602778lji.88.2018.12.12.13.15.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:05 -0800 (PST)
Date: Wed, 12 Dec 2018 13:00:53 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 6/7] Freescale arm64 device tree update for 4.21
Message-ID: <20181212210053.6bmu5nwxvs5ucyy3@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-6-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-6-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131518_959635_94CDE0F0 
X-CRM114-Status: GOOD (  14.75  )
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

On Mon, Dec 10, 2018 at 03:46:37PM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.21
> 
> for you to fetch changes up to 58f5fa68372505c8c6e57754a370f0e7e6004513:
> 
>   arm64: dts: ls1046a: add qdma device tree nodes (2018-12-08 10:28:39 +0800)
> 
> ----------------------------------------------------------------
> Freescale arm64 device tree update for 4.21:
>  - Add device tree for LS1028A SoC and NXP FRWY & QDS boards support
>    based on this SoC.
>  - Add device tree for LX2160A SoC and NXP QDS & RDB boards support
>    based on this SoC.
>  - Add qdma devices for LS1043A and LS1046A SoC.
>  - Disable PCIe device by default in SoC device tree and let board level
>    device tree to enable as needed.
>  - Drop compatible string "snps,dw-pcie" from LayerScape PCIe devices to
>    avoid incorrect matching.
>  - Move fsl-mc device as a child node of soc node, and add missing
>    dma-ranges property for LS1088A SoC.
>  - Update LayerScape SoCs' cooling maps to include all devices affected
>    by individual trip points.

Same comment here about introduction of new SoCs and a brief description, the
patches have a good summary though -- especially LS1028A.

Merged into next/dt now. Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
