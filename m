Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A353C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CF12081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jA4hUB2H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sAXlZlHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CF12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bwz8qkgN1amCZaGewp6IVyoAdRqJwjKCBsnnRh5YK9A=; b=jA4hUB2Hmiywkd
	0vA/zEYUNkEyWxJvqid7rWPukDr9uBu83MYfW606q8AeHujAdVRG2XvklmPmV6jtf+nqDjSuhNNAj
	6T+PMArg7cggTAV3rgRmPPjGMb+rdfydvyx4UBqTMM+eygpDlM7m7ur+gVo3IbKQk+JIJ78U9aIpK
	kJZIaKd4/t4KeN5Xjtw9yogJtn5vCu3SG1j2/0V9I8TSmp5opwanPSZIS+qZH0/SQ8GW82d7oWLlC
	PLHKvmBsKCjAYOaUGQwHcmj5Y0BIqN/u94ILItobyraWUocQcOp4k5QmEdqsNtx4vecF+kiaz3pSE
	IG00pOY/IY9htbm+ZE3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAIj-00088E-Sk; Mon, 10 Dec 2018 01:24:01 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAIh-00086T-8w
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:24:00 +0000
Received: by mail-lj1-x242.google.com with SMTP id 83-v6so8086915ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8o07ufyDg8JCSlnmGVrz7Q59+zgV0N0HJzKz9+MMT4M=;
 b=sAXlZlHlkNDWhGUlo+YP6kFqo+u224oGrmqXKH1OKKi0PX478NAM36iGtWGClXlevF
 cmMGoh8EhHLq44ZynxSRBROR6adXtGvU4JIS8gss5jjQLsISNySZXYz7a39PFvbl0EEp
 pwj0yvPqFieU0vlkikbmvxPeDxZsoCo+924/jdBoI/NfTsWZnfG4MRqYg6iKBa3mH4PN
 D7vC1RPXgm8uM5JUJv7/bTeRgOfcoSP34wmIsAoSZl4/IRk4tklG/LiLIoKEqxgfeYff
 cgp/BZth6tk7UlsnROyjmyUgs8IIVLNZESpIvI94Ho0o49HeqbyKabKf8ePvRLfddJCr
 S5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8o07ufyDg8JCSlnmGVrz7Q59+zgV0N0HJzKz9+MMT4M=;
 b=gLFBx2dsA6fTjS2+BvQfmrBfFnTImtQLzZdhUEM/lwP62bjbAznHt47+Jm49tnurlw
 XYOZ1OfwCKtuxtxMdVFgPjYCZVlLbE5XQYCCnEStKH5/8QjuPHoxT2cTZXhGwZtVPTiF
 /Z4zPC9h/n86pVkwjPdlT/2rdD4uTcER2B0hPZQi3dfdLp0b4hXklOReo23n2dE3y/Z+
 fhQjU38vUx72+s2KsL8+6EYnFVURuCC2H4dpFiHV3+59NGBGECFXn8kM8eiAL66WAEYn
 ile6lTOvs1fxyo0UN4N6cIUmBdC53wmrQZqsv3Oq0bgUL8jkptDlLRdRTWVJ3CLmqap+
 NPEw==
X-Gm-Message-State: AA+aEWbfXDbRT6VlhdV+n1llCLcQ3d7XHw/AEIyzg7BZNWiwepbrnruG
 UqVEefJY5zkPZTGWZoj/DP9l8Q==
X-Google-Smtp-Source: AFSGD/X1VAVwzDdHRwSg+h3Ur7aqGWo423ZaJQymDj49d8VqOv8OL8/MvDL6RFK04h8q9lvChTtKjQ==
X-Received: by 2002:a2e:8605:: with SMTP id
 a5-v6mr5840910lji.145.1544405025313; 
 Sun, 09 Dec 2018 17:23:45 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p10-v6sm1880224ljg.19.2018.12.09.17.23.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 17:23:43 -0800 (PST)
Date: Sun, 9 Dec 2018 10:26:52 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] i.MX fixes for 4.20, round 3
Message-ID: <20181209182652.azccfismcurjnhme@localhost>
References: <20181206151625.GH12929@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206151625.GH12929@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_172359_315949_0298AD6C 
X-CRM114-Status: GOOD (  14.85  )
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

On Thu, Dec 06, 2018 at 11:16:27PM +0800, Shawn Guo wrote:
> The following changes since commit 512cab3e7e0be11234f965d9898936dce2325382:
> 
>   ARM: dts: imx51-zii-rdu1: Remove EEPROM node (2018-11-19 22:35:45 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.20-3
> 
> for you to fetch changes up to f15096f12a4e9340168df5fdd9201aa8ed60d59e:
> 
>   ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock (2018-12-06 15:38:28 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.20, round 3:
>  - A couple of fixes on imx7d-pico and imx7d-nitrogen7 boards to correct
>    the description of the Wifi clock.
>  - Change SW2ISO count to get a safer ARM LDO ramp-up time, so that
>    different boards can be covered. This fixes the ARM LDO failure seen
>    on some customer boards.
> 
> ----------------------------------------------------------------
> Anson Huang (1):
>       ARM: imx: update the cpu power up timing setting on i.mx6sx
> 
> Fabio Estevam (2):
>       ARM: dts: imx7d-pico: Describe the Wifi clock
>       ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
