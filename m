Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889FDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475932192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t0uFle2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475932192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yUGDelZhigfm4rYEZIkDlgYCW7/0dQsIxovYUOBsI10=; b=t0uFle2A3HJJOj
	IuPoeJx875WIwdsidh6BWHSCyUBzMygvjCWUAXsQzKLe9QVOsnpveymUsoErHM97uLH/+Jw1Lt3BB
	UztJsRCbZ0mLyRdVKb1ToEyIRC1N3ym2zwlbcu4AjT5kiF9Oy3g39dffF/QOuNPYZbE1cz74EkQds
	rmsDdy+DQcJAHvVzkROuaS1XIQYr8kiEglAoB7ncju8owQcXGULX2jG8HV4d0LqRadBLUjigCFXcB
	hlMHVVlN0v5/a7KONd3aVO4LReGSUDTB+rNFoflzohavGcUgo9RA6E36NhMxjXiGy075HAMfw+JtT
	6FyxNGU3XIYPgDpAnsSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugCA-0004zK-HZ; Fri, 15 Feb 2019 16:18:34 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugC7-0004y2-FX
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:18:32 +0000
Received: by mail-qk1-f194.google.com with SMTP id a15so6035797qkc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cHXF1hqw5qWjk70vK/NrFDs1YLkWODReZTBv/8GG2qs=;
 b=DYk6Hq2A+kudA1S2fjobO9aMIuaAalNiIlKqgdN9A3PmXPqk+jmYR8n1bdWfX6Bw/J
 EqnFmqGRIDbEvpDB/fVZNTNRG5hgvVzNKDj9wQ+fZp1sKS4cXO3iLxaUpjvyBTGXGa3d
 9vqZrXN/rr2bPvmh85/UhJqbZFfippz0cQb1uXq5T9HtV3HEWkuZIkzaw909cRzd5e0q
 IGg2BVTcVrkRLN9Ii9hs1NAkvPaxv+EvmmnkQlqkbgx6Ps2vr74mqjgo1AhGf5+tw4mp
 x0Eqeml8z+QNhqaZ0iZaCbULwA5DLY0T88XvCDxzjsxq8k2OL8dLpSbCpUD1XjtaZTc1
 N/0A==
X-Gm-Message-State: AHQUAua5gZHwQqlddfj/6EA+GehqjheD1aMQURcBJEaLGsizrr25LYMZ
 ZT5hTcvZBZVW26jRDNb7iI7VE1fEo2BkqZVFe4I=
X-Google-Smtp-Source: AHgI3IYHiyBqSXzPeeGIZGB+Ugr7dIhsqenhmTOfaKHa/7q8wdH2PSLAHfXXbCFOb1RA4MZkEKJrBKr9rAwBXeQIPkA=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr7444931qkf.330.1550247510167; 
 Fri, 15 Feb 2019 08:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:18:14 +0100
Message-ID: <CAK8P3a13xvpv+duM8xq1Byc=VGQMO50suNkhKv96yzufVTg70Q@mail.gmail.com>
Subject: Re: [GIT PULL 1/7] i.MX drivers update for 5.1
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_081831_523933_27B01A5F 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 12:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-5.1
>
> for you to fetch changes up to d90bf296ae18f26a18e572965fc0047fa1bd37a8:
>
>   firmware: imx: Add support to start/stop a CPU (2019-02-11 10:00:47 +0800)
>
> ----------------------------------------------------------------
> i.MX drivers update for 5.1:
>  - Do not get GPCv2 driver depend on SOC_IMX8MQ since the driver is
>    going to be used on more SoCs than just i.MX8MQ.
>  - Add power domain information into SCU bindings document.
>  - Add support of start/stop a CPU into imx firmware driver.
>  - Support multiple address ranges per child node for imx-weim bus
>    driver.

Pulled into arm/drivers, thanks!

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
