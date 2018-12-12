Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3CBC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5E42084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HrLesFrk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DMH1HkJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5E42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hqVP0x/mKPSZHw36fYGyvQ2UsajTMnAw2PUWa90JHk0=; b=HrLesFrkyWp/or
	XvM4q9wqk8DthCewcdfPUNxm+HtiovQSh6hJ7Gb8TonUZDpN5/gPAt2XOMXTl6xkfRzwiwZvkZn7W
	obcZu4yq27FUhSwiyI6R+buGMRqsgFfQkoK/Poygh6wb4cbBrawCU4aZyp5rBkwuiJMy7mQLSebIo
	kN9H6uUrp9jOFwbtAZke1v2q1zFLwh/NDZVzjgNCNlu7K+dl6XCVEwT4IoAohoPpvZfCRI9R2GPZP
	anRGa867bNq1a3rGAy4irw5ktJx6O2wh/bBU1ZkoPLLR642eA8d0qexpGL9LZ4mpy+rRP7a920ddj
	ThGZdod9E0JAeP5cwXvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCoo-0007ma-RI; Wed, 12 Dec 2018 22:17:26 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnV-0006IF-RP
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:37 +0000
Received: by mail-lf1-x141.google.com with SMTP id l10so14766079lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yLEO1DsjpXeYVZ7zxMXwbOWpuxDt0gUN2mLllm2Cc3U=;
 b=DMH1HkJSj2DLos8P3J/SpV6MQoHCcNTjqjtXxLmG61NE72fp3o5vHaaYzTvKGq+Pj3
 lWiK/a4IvAsZ0GDdGZ0JOLFI579TcssktcN/Y5lH/N7nHMK5YpTBtd4rNaAnXUL8G4Jh
 VIvplS/C6QYJ/NfPnfBtgRCg2P3LYoZC7Qi59/VGRz7BeHsh2frRc5Fa7TGoTSEhdEDT
 F+MnD8TGGMGa7eOOBTMyHeBGW8Q6XqmsoB6aMNQkBC9+ufmWgxLw2StKYoM1CBElOWnk
 BzzlHz/nZSU+xzVNvurdRNPO+BIq638iW8keJ8LfgIVwPp2NqiGvIfZ9INGuaTLxmWv6
 INAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yLEO1DsjpXeYVZ7zxMXwbOWpuxDt0gUN2mLllm2Cc3U=;
 b=RvC41mxm3KQn+DmVuAGu7oQaeIS2cHlyVRv9pgaihjQLldYr/BM3BYPirfbYG89/ER
 sXwMJycRv+evhCQDCuZzK+o7aue1yfk4u25GYrZ4TpCTz+isQahiVzsA8Mjp1B5qOyHQ
 4aNIHoWmFHgc4I5pdl2Zrzzwta3Cg9n2FBQg1V1ciMj2edSwdCpGY1Fsu7wioj2wFyr8
 Ww8Hpof846P9/2jiy8IUBlnh3iZyq6j1VJjIAO9NBjecm4IQvbht3fkfgiv0I6Sn1rM9
 U/dnH+P4nXImomhLoOMT02/KJSk4zy/R9NBpEWavq+G4Y/ODJYfJufZdM+2+w7nq3pAq
 HPyg==
X-Gm-Message-State: AA+aEWaCkZzm4x95Awuds1vnUIf/MprLIlj45l8fdBI7q5pY80FM3dNS
 U/fIOuCQ7b/5VciOdW6JdgDMbw==
X-Google-Smtp-Source: AFSGD/XXv0nzmsPN1K03xLyIFxXXGlFTVf86XBYyJyRHV0RxBhWwaqGS4dBsZAqzhpbwEHHXlUkt5w==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr12099733lfu.46.1544652954140; 
 Wed, 12 Dec 2018 14:15:54 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q6sm1551lfh.52.2018.12.12.14.15.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:52 -0800 (PST)
Date: Wed, 12 Dec 2018 13:33:18 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 1/7] i.MX drivers changes for 4.21
Message-ID: <20181212213318.jhl4zxlwko6mg4is@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141606_611979_9D837680 
X-CRM114-Status: GOOD (  15.09  )
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

On Mon, Dec 10, 2018 at 03:46:32PM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.21
> 
> for you to fetch changes up to b6444cf5fa607469d9a14edef2edad32773f4514:
> 
>   soc: imx: gpc: Increase GPC_CLK_MAX to 7 (2018-12-10 08:51:12 +0800)
> 
> ----------------------------------------------------------------
> i.MX drivers change for 4.21:
>  - A series from Aisheng that improves SCU power domain bindings by
>    defining '#power-domain-cells' as 1, and adds i.MX8 SCU power domain
>    driver support on top of it.
>  - A series from Lucas that updates gpcv2 driver for scalability and
>    adds i.MX8MQ support into the driver.
>  - Increase gpc driver GPC_CLK_MAX definition to 7, as DISPLAY power
>    domain on imx6sx has 7 clocks.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
