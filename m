Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309C121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWPQlEUf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aQ4tCcsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TrJJw2dL/shOcJvuMrJeZi0ioAoY4hP/GSj3Q/b8cbI=; b=fWPQlEUfukNfs7
	8AFkla8KNECYfwy6I4QgxbOgSWfExW3GVQyyXVcqqU2s+Np8nrpbVXdhhy7KeqL+qltyVJdDDseCo
	I7mj+2JhobtuSrq8aEMkgJnkqmb/uxH+Ea/8nXXTB2BijoEz7jTlGX4snoMeeeqPgqCAVpKRl5X1a
	mH3V/3N+HhD0IWhItNiCuwzAl/40con9toWPRKb7Y8RClvkWPpjFP+X6shw8Q0ZOTTyynuonE3SJy
	Y2daf3Ut2LPm702PLzuaKokTr5WihM+Kcarb4MFTfI0LO0dsEaV/PWrXb4A1StC6hjLuMvmaUdxe8
	UWKZa1M7m6tLjp+5TYuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSseV-000250-GW; Fri, 30 Nov 2018 23:56:55 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseR-00022x-2r
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:56:52 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so6486263ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/U05v4x8kz7gyrldg3yn/ryCle6aZDE8tNaCodrHs/s=;
 b=aQ4tCcsmJjG3tHWM8PMF7EaBoawjZBVVQKjoGaUFxyiB9Q64aUbxspIYOtlTcI+CvX
 eQtq1HaRDokVDfRYflH4YNQ5spuOaqmH13n5I3gYvTJM5NvcEtbJBsMZdIbrkU4xhSf9
 L3SIbXc7yjFaH1zz/0xfa/aXFHa6ehg4MkXiLd01M6yO1JN2UdrPFjAjqt0CiewY906r
 X34npryhGM7fb2o2541nDo8+ory6ADheHVudYAkqAAPQzuJ63Sv1Dm14QdOZ8R6CpTzI
 lXox1OpG+MGeg4w7ewi85norC5RVYp7YnLCkQGswtRh8NRmQFEc6bDzaH2iur9S2clWH
 urWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/U05v4x8kz7gyrldg3yn/ryCle6aZDE8tNaCodrHs/s=;
 b=HSzO3pi3ft3B/S7amsKnRISXHIG089aVTnAHSv3WlOlC0FabMU1xnHW88gFzezX4Yg
 qXB6tmHU1PPsMiwLD+yniXQWv9T2Tw0Vac1G1Gm2xJGu8M2s6DSVwSj5CFaEYlyMd4yu
 D/EeRMdwH/a13OfzEp98yD/QVqDPiRfu1rMBNcAnGKr1aNI34PGx/LxWT0Hzj2nSj3Cb
 uGn2LpbCMmMpo0SpNU8NUXk5HwcbhWQ7HQyIg6ewmUpFH4zTj+7O3MZmqAvDwGZbVrPm
 4sHmAzlr054YFeSGjClRmAQnLnoNaeqd+77SMF/aQQMxaKaEPVpIUkCWeCMzbXwpZNAv
 8MUg==
X-Gm-Message-State: AA+aEWbcKrhPXwT+cHd31L3scyrJL54qV/JjvO+YFF9CFgVgMN8vOKye
 +0318krNyXyThVPT7BMdCsLm6SR4VDsFIg==
X-Google-Smtp-Source: AFSGD/VbE7l5TNWwTZwnVOJxaoei3kQdDyC/kV0KRS9COVFfBTIEAyPCtKDQm5aarFwVq4HZarowYQ==
X-Received: by 2002:a2e:9a84:: with SMTP id p4-v6mr5035622lji.73.1543622198590; 
 Fri, 30 Nov 2018 15:56:38 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id w9sm1037676lfc.66.2018.11.30.15.56.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:37 -0800 (PST)
Date: Fri, 30 Nov 2018 15:03:51 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 2/3] Rockchip dts32 updates for 4.21
Message-ID: <20181130230351.okuiq275nxonfsvv@localhost>
References: <49803144.2ZsBJmaiIN@phil>
 <14719034.CB54cPrm89@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14719034.CB54cPrm89@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155651_250220_2BE8DA47 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 11:06:38AM +0100, Heiko Stuebner wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-dts32-1
> 
> for you to fetch changes up to 99935bd4b5b4558beb069222e6d6143fe5830d64:
> 
>   ARM: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:07 +0100)

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
