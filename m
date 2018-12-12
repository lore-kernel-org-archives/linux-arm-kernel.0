Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2408C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A5A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ThlsasI1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MLr7LKhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A5A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=js6SCIFldRMX3n/yxxIYHnCmekRFPCk8LZfOoG4QEFQ=; b=ThlsasI1hI09u+
	o2f2WJNnnMOONGDyd6EjigGD0Dee/s6OlcsYgYKq/D0FZdiegWjPPhdwtZfLpkNcg1zfwe6qlXKOT
	5o+sRlvsVKqTsl68AnftqvTNt7rVKrB4bZDwS0N+1aY0hRFyhZrBt8OTmxMllqObnjB1HaJ62bKqo
	3RMrJrZ0V2EFomoalD4T03D1Z533l54Q76qcuqRmhiSa6G8+fKEYf5Vy2i0vpWahPwOiPiWT1YETc
	/LWFRLs8xhIwqbDSxFAubDpZefjV3sVVcQRBuHZmr1PtOA9TLKdPauLtgsPTqtElVvIHxXV8MBB3M
	Ew0Ezj1yXlUu8JJq8O7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCnP-0006J7-85; Wed, 12 Dec 2018 22:15:59 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCn5-00062z-Fy
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:15:42 +0000
Received: by mail-lf1-x143.google.com with SMTP id a16so12497lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1KyGI9LStunnpguDkO9wmoWiiYzCYpnJ2Tz2WLigC+k=;
 b=MLr7LKhfLsvZ/yhXhzL3l2H7xKFsIA3Vr9AnpOqX0NNyOvem+V3jYXQx9/lt6AuXAx
 lPhcd64J+h3WhtDSyOHUVNyOe7yFaQGIeKOXamw7qRMaY8g8cZd9ZLBnRfxNqV1Be0RR
 JjVX6gaTy3qQ8Sn8z4yPbAGYN0eRzSW9nlRJdu3lx7AS6MuqDWenz2T8p2CtRPtH+tBU
 tWTrw9M0/fTl1SLybNNwpUA0uWo8PhKRvmWlEUhQAuvXVDEX+e/ML9Te1YFEvwtqAh/n
 c9ZqPsnNWkKRtReRGAu/7y4BG23EPWyMb4RbLDOSEpcUgbFhEzR48hBaQTeaOCheuJxh
 x3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1KyGI9LStunnpguDkO9wmoWiiYzCYpnJ2Tz2WLigC+k=;
 b=Fn0uOn96KRtKbWtrvRogZdBtWPWbEClrV+62ckjeDszI7BdKkB9s23OEKUs0twXzNS
 aFXUDqO4g21QwA4ON5gcEFCFHxTBt5y8L8/0vVA1JK6ICHaOnN7LVls60ax7NodcLP1D
 mqUUNvxEOwQt4eoWZrkW4FEexTH1tXgPlw8Mznv8M5v03+6n2ourC42yZ6mSFKBU2oje
 IQ/yKg2QAC+VEKLVHMySdf2hl7wCDc4nqMd1hn8na47CoeblhlODLPxEKMZxyZnk6hRz
 VohgeSz9EDF2ywYhxzydjOsWh3yoirzIu0kZVWWRBipGrdYTYIITtMvQk5aStCzhX1rA
 B30w==
X-Gm-Message-State: AA+aEWYdy8ZkLkBMfSh63Qq3GgIdi8skrD5ufS5fmZcLJDfxsWctRlsD
 KEjcSi2DSWl3BcbT+u4d7+8ILw==
X-Google-Smtp-Source: AFSGD/VmXOOdT0M8CUvep+PZrPN0yPLegBc4gycbqo6o/tkS6yb074zn3VyZcFi/L5aPZRTdJRyBIg==
X-Received: by 2002:a19:a149:: with SMTP id k70mr12741530lfe.5.1544652927498; 
 Wed, 12 Dec 2018 14:15:27 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id o25sm3387lfd.29.2018.12.12.14.15.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:15:24 -0800 (PST)
Date: Wed, 12 Dec 2018 13:27:50 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.21
Message-ID: <20181212212750.aojzs2rzrnfnhnkr@localhost>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141539_809302_0B50768A 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 01:58:53PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC drivers updates for v4.21.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v4.21
> 
> for you to fetch changes up to 7fc4650cc2417d7a2907a000f6f88240baa42018:
> 
>   soc: renesas: rcar-sysc: Fix power domain control after system resume (2018-12-06 12:10:10 -0800)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Drivers Updates for v4.21
> 
> SYSC Driver:
> * Common
>   - Fix power domain control after system resume
>   - Merge PM Domain registration and linking
>   - Remove rcar_sysc_power_{down,up}() helpers
> * R-Car E3 (r8a77990) SoC
>   - Fix initialization order of 3DG-{A,B}
> * R-Car V3H (r8a77980) SoC
>   - Correct A3VIP[012] power domain hierarchy
>   - Correct names of A2DP[01] power domains
> * R-Car V3M (r8a77970) SoC
>   - Correct names of A2DP/A2CN power domains
>   - emove non-existent CR7 power domain
> * R-Car M3-N (r8a77965) SoC
>   - Remove non-existent A3IR power domain


Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
