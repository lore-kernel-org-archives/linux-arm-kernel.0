Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52DF20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BezsCh4G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sz9of71k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52DF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CsXGTU9wqkHXvuTbm4eDLouLR0f2RXzLQuMGPmKdah4=; b=BezsCh4G+PZiBf
	cILTA+HQy3wNDD3eHKMTwSdMPWrpKYttZFFf8Vl57j4OVb/N0KPfl5kRDEkiqOYc4o5YLYWt3DJZN
	V5IdxLFVZOw2ZJ4VSdqTdfS/197emjezTCh8LGjMVf1JzQI3j/oBnt/ioGiiM3d3EZpoH1titeWbS
	QiNgkpiI5NGcS8NKe7UnoxPzUkPS1Yx9QCbRm3S8eulvgX2dncTcGQnXQj3ZGCOjPFpL9y4w6s+Sc
	axOwEMrdiiCL9OosCZ0MTt69hCeIXhp3nHWMJPjIitbwAa9/1J4z2QyBbtRyubPB/FhQusbeh6sVZ
	SKoOH+CE+CYDUdcJAOOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvah-0001m4-1K; Mon, 03 Dec 2018 21:17:19 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvad-0001ky-CC
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:16 +0000
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so12834445ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YVNNaof1eFZqCRzt6eDYgHkbf2QKOGlKmPqPZc+AT4M=;
 b=sz9of71kZ3vCaTvxRMLbbhFDtytBL3HmdaV5d/hSdkHQ4cZ+eyU2myFnaL8IvCVSj1
 +nrAci1voLzgcOAffYRqiJNa976Bc9J+D8vhPqG1pfohoamESOYDxON5cLhuoGgqZiV1
 kmAqtB8l3rgPw7d0t2yr4G1WbgcAJw/1atA0pZZZgsM1qzghZGFwofkGxun/k/s16b0e
 AlteSUKNRIbbizodktOVaczhlIZDKXx2lZ6HiGl4TwOkoVhN8R4QeqqTXmWl/wJt1Egt
 iChPO2YiGSrErVd0+81QJkXi9FVxzTkpR2KMFl2tHt0HD89xHPw6QNj8XCmcVwhIFC8e
 1CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YVNNaof1eFZqCRzt6eDYgHkbf2QKOGlKmPqPZc+AT4M=;
 b=AdUOzJohiR+wkhNc+36n3AJkrvkYvkigo8+gO2zicZSu4FhlWKAIOA7gNBrP64OOLa
 GvtomwVHMPYc2nVABHmdX/aYxlSGB2A0BJv8e9Zn2X+bQH6ZrUDm1kTt4Q2xO5+Jqv8x
 guLBn8r6pChCbWlI6Fqv7qbqZ37J/y1PtrbFvm0HxuKr0H+WR+XI5htCcOGMPH9FjG2w
 //F1FmIzY1A9f8gmczVXPPJ2XXp6lDHD/nbe41jUs0SJ6BqhaGJOx6/Hygzx+z1gFE25
 M7Lm6FMBe3Qyy8nLEydN1fyCOH1x5XJxMZuQHqmruF0DzT1EXRtUdSyMNeQdmIpkEu+1
 EvQw==
X-Gm-Message-State: AA+aEWZZ9IXNVIMZmBXZuo0wI/QORTBdgrl2/UG3978UWtTQvskfTwxq
 layLvwrhfCLNpW7YR0mz4v82jYfQJq9j3Q==
X-Google-Smtp-Source: AFSGD/XqwjsVy8XT9sEU7/xL0GAMHbhwFyewOGT3PepXSI/3INlipAcTdTniQ+EGLzX6RSWCDBk0NQ==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr10594946ljj.1.1543871832250; 
 Mon, 03 Dec 2018 13:17:12 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y14-v6sm2687158ljj.55.2018.12.03.13.17.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:11 -0800 (PST)
Date: Mon, 3 Dec 2018 13:04:25 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.21
Message-ID: <20181203210425.vb372pgmhpw72ww6@localhost>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
 <1543865944-3591-2-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543865944-3591-2-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131715_420979_8DD7A804 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm@kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 01:39:02PM -0600, Andy Gross wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21
> 
> for you to fetch changes up to 70827d9f6bc4f481fafe790dd6654ba568526768:
> 
>   arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.21
> 
> * Add QCS404 base platform and nodes
> * Add QCS404 EVB boards
> * Add external SD and dependencies for MSM8998-mtp
> * Add default scm compatible for MSM8998
> * Fix XO clk name on MSM8998
> * Add prng-ee nodes for SDM845 and MSM8996
> * Add ADC die temp node for pm8998
> * Fix documentation on QCOM ADC sample

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
