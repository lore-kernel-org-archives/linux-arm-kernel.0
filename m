Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DFAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5631B20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xa7glS/1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ap5amWt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5631B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=83d2v6eNeLIElsZ20gQdxijSm2AHHL0Z16OQQ7zBeTc=; b=Xa7glS/19gq/Up
	CW/30xm7fxtBS3bRemr9+W73GxUQz3S6BtYK86kiSJjgT26xP5Qhwwhlsl8t6x1BECu3tSpfKnfow
	HrffbNWAEqBubzn09+sZ43g+BbeLbcWEIC4ZxANJ/02rRc8nK2UFbQ2RcOsDj2njum8LbHbSh0o7q
	L26S2BFSIdq/SWCwsr63RdBZWRGwAX41qsBxQ/nKHNrvCrBXl4/bfAq5psAAIf/fbeq5EP1UHzoin
	V0dXow4B2mGjh+smfPc3UuN6E6lwuAciOVswLi6zxXcQnGzpsWucdmglo7Uk5GSTV+yYWOY7eoctX
	bZmiTsE4iJNkS+uz13Zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBsi-0000Da-L1; Wed, 12 Dec 2018 21:17:24 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqf-0005Bg-69
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:19 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so17597729ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NiD4KgQgS4YUKsU3rIOCvWwjN5e9x9j7RDyGwZYXTxg=;
 b=ap5amWt2tY0znwg1o36xk+CuQh4LI1WuamHR9mesmBqGyczGPGh6Q2Dqjqjul/JY3a
 2y6pJAd2KphF4vhoBAAZHfXldz/gw8V6skUVtsIm0v9akzNZRZkY+UpneCsbJN8KTq2F
 tBpT7aUXqoMrMgYqLz9IYdpA8SBuNY8KoFuoh4Ils/Dw3eY/iCE3yHFyUJwqJutysPer
 fVejEkeJu0YCy6M3hEvhz8EjvUGrQRvsA/xDduDFkRK6KNLhmy3JVlTmMbr4YzPcG2oj
 HlSYhT74PQyqBLbwMfSFajHRcv9sdUSUvPg9CdrY8sAO8x+yns+7PII77yUCakDgJdPz
 t7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NiD4KgQgS4YUKsU3rIOCvWwjN5e9x9j7RDyGwZYXTxg=;
 b=UXFjeXQnXLZb3OY+5Pztk7jkD5PO691rwy/4uIIqXMgTXnk4U5QNouI3s10bPu2RXj
 +pKxgzhzejnSP/XTPWTLLFMRs8WDJcUfNQVraJ5j4Ez+JlfE1ZtYfKXk4jRrjdbr7eDQ
 Q/0uBunF3VeNKhXmIhsE+bYq36Mf3wJHW+pXo5o5wP8m/yad62bGdFnT47MkBvgMAdlw
 AqkJUxO9H0gTdlljYpYSl/YyphwUFpHobhzY6aAmt2jKOMFDRSq94Abwos8T3cTYluFG
 8xLMdnLTceND+vqY+jvj9FMQ58ejzh/dAquHx6LloIdX0GTYV3YloJSgf3139uwByC9H
 wm3g==
X-Gm-Message-State: AA+aEWYwHl+2k87AJ4d9iMXuPbV25K298H46jjdGsQMIgCgmJxPN9hzu
 pDdpHGPlOLvDZr4SKvZxkG08Pw==
X-Google-Smtp-Source: AFSGD/XaqQ4CVaVGlUGpKOsB3pAKtmOrNH0Y3JzwbBK0RjiySgWJGq9UdifG/UlHzpKlF6g/2yupjQ==
X-Received: by 2002:a2e:8256:: with SMTP id
 j22-v6mr1001366ljh.40.1544649304788; 
 Wed, 12 Dec 2018 13:15:04 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e97-v6sm3511312lji.51.2018.12.12.13.15.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:03 -0800 (PST)
Date: Wed, 12 Dec 2018 12:58:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL 5/7] i.MX7ULP device tree for 4.21
Message-ID: <20181212205855.2j7bn2efcxfm6n4c@localhost>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-5-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-5-shawnguo@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131517_439029_D2103B81 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 03:46:36PM +0800, Shawn Guo wrote:
> Hi,
> 
> The series depends on Stephen's clk-imx7ulp branch, which is stable and
> pulled in here to resolve the dependency on new clock defines.  Please
> consider to pull, thanks.
> 
> Shawn
> 
> 
> The following changes since commit b1260067ac3dd5dcd40bcbcb2cc116a9f8b5016b:
> 
>   clk: imx: add imx7ulp clk driver (2018-12-03 11:31:36 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx7ulp-dt-4.21
> 
> for you to fetch changes up to a73900b826ce6faded48ee3e41aa890fbeba4068:
> 
>   ARM: dts: imx: add imx7ulp evk support (2018-12-10 11:24:54 +0800)
> 
> ----------------------------------------------------------------
> i.MX7ULP device tree for 4.21:
>  - It includes the initial device tree for i.MX7ULP SoC and EVK board
>    support.

Merged, thanks!

In general, it's nice to get a small overview of what new SoCs look like,
but the patch that adds the EVK support has some information there. Feel free
to include it in the tag description in future cases.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
