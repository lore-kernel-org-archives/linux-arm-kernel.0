Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D531AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5D420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F5+u7dmp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MOZH/c+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vVNLRoNyktEr2JC/VUj/F+U6Q4Te/vsueOfFMdDFiXI=; b=F5+u7dmpKqeBWl
	5wyRQp1rASvoPwi9Y2A1nJWoKgiDw+zW3T6fiZE+6M3/n6LSS/IfRNXUSugRW1ddrClhw93WQrq9R
	zZyIGX1xoF5r6eAgnHJvM23dyKE6rgUQwKMwgNDvu+36pQRUhWHcK7le9Am59TS9khWVX0ZmoD3mM
	zvEy2+qHiJFf4o4DCyZwL9mghJLl6N0LxBQnCsLHvSacj1Tz2yoFbwSHNnwSkGMWK6mr5SFMriU4F
	cU/6IWjmjpMh3WKh/nVwTyYRUVA4E3WOGP4tJwTdO3FIzVBN5WCiFDDrQ3AGszIEuQmtut4cf4+C4
	V9BfRpfhffE3F1+kqabw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBqo-0006eU-2a; Wed, 12 Dec 2018 21:15:26 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqN-00050T-51
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:00 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so17613543ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ntCnQrC5o56oFBX8LX+Gle88ldNow5jNV7KIMtSsi1k=;
 b=MOZH/c+sTNwzSkYijgZfnqhuSByOMmCiWH3/byX2f8bzq1kBGT6ZhC8qr6DsVVmqLs
 KT2URz065NfjmcAadsxjRdJyWp3yJebngQCGpSiFxNnengZWX0NcbrGEBX+WNtUSaOng
 C6kxuM9SfAipL7BgrSZ+LV0xoACw9VUXmzFba3qEnwaW6tntFOB5eAqoLLY8WaLamcF/
 kcRhPX6R+Vz6bWtUM1pyI6OV0n94ZZERo5r0hG4OrZYA3fdOHNljtG+EdL4BQixGi7HE
 Rup8PSkUtDNtKExgCB1VrpPIcScyEaVmw1a6BiuPARHakjdgTCNh+7tsyvKKioICsHTU
 4oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ntCnQrC5o56oFBX8LX+Gle88ldNow5jNV7KIMtSsi1k=;
 b=S4lYEk51eB6+2ZfT7MMZHdCVfi1dR/f4oD6UQeMLT25CrhenZdpCT2QOh7CALUgEy6
 0MK+JAmLss+c0C0M1oeYbhoe8W19+e20UbKvHJCIwrL1pCsHhSvm0Hg+P2RvQALni3N5
 XlCx4wb17v8koAZ3NHhHihe4wnlgyJcwDhQmKjeS1sK2e3U9Em84fYfcz0kg/rZOtkq9
 OSxGUYvcGabIuJ0zM/gkIZKYk2POw2mnjQRWkOT2DxY/8yxrWwNxoumHBXZRGgC9fxtK
 V+bzyZiZe3hU//RahDIk/BEBKV045Js7zcNwCqnbpXJ3UoTLLQklYiKGS3w03Ia0tot6
 x3jA==
X-Gm-Message-State: AA+aEWZ+PrEYdNw/GoTn+h5Q3PbyanECNncw4cstMgwRPKtWTmWqY4FL
 fCM5BUJ6BSidJT30VymetTyhcl9kk6Nn2w==
X-Google-Smtp-Source: AFSGD/VqkhRFGIaNI2lZKk9hL98KH/0cm703gewP1tEs12mxft2ysnBIABiOZEATY0Z5jM9ytrjMag==
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr12832897ljb.153.1544649286969; 
 Wed, 12 Dec 2018 13:14:46 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f11sm3389728lfi.12.2018.12.12.13.14.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:46 -0800 (PST)
Date: Wed, 12 Dec 2018 12:50:16 -0800
From: Olof Johansson <olof@lixom.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [GIT PULL] Allwinner arm64 DT changes for 4.21
Message-ID: <20181212205016.lzhgl5cuflrwxvmg@localhost>
References: <20181207144401.mfrfb2qj2sdno2at@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207144401.mfrfb2qj2sdno2at@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131459_186999_37AD416B 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:44:01PM +0100, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> ThankS!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.21
> 
> for you to fetch changes up to 44ff3cafcd7f413e7710a58ac40cfdc3a9380097:
> 
>   arm64: dts: allwinner: a64: Fix up RTC device node and clock references (2018-12-07 10:23:39 +0800)
> 
> ----------------------------------------------------------------
> Allwinner arm64 DT changes for 4.21
> 
> Our usual set of arm64 DT changes, with the biggest additions being:
>   - Support for the video decoding engine in the A64
>   - Support for the audio codec in the A64
>   - USB Support in the H6
>   - HDMI Support in the H6
>   - EMAC Support in the H6
>   - New board: Orange Pi Lite2

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
