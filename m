Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B65C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E8D2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hgAeaPxT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GlaV8xMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GawU/ru2lUm/jUD1b8K4hGbUBmsVuQFfq1Zrs+gauqc=; b=hgAeaPxTZQuKjl
	3pXdO7U9QwNJoiHG87wZKde0NnDRX1vCQEMF4XV2WyE9WEbPk0hxqlgPduBWVQiAXVnPc6w89SYZS
	SZxQ/hEltmuG5pButdnuUTL9VUX8EvwdwWXBgjTDMPxtsze4xtiGIdUdJShaR8jfAABOCtrJJiN+Y
	yALKAwVqMOsXY2dL1hcvOqbC3TUOHWFAui/GsJT2ZdfFeMs+W78BJHuFziWLnPXBVey3R+h8HlmuO
	g8WcZFhC0JgFo4/e0w8H/jjFY4UfYbOz0f7FDnuTA/NEb/2zx9JjPSZIEyB78c8bwZRxYXIxkufd1
	zsP3wmH8a81wKxb9SpYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkh8-0008IA-GL; Tue, 11 Dec 2018 16:15:38 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkeN-0004Xm-HG
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:12:53 +0000
Received: by mail-lj1-x241.google.com with SMTP id k15-v6so13462834ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=h3nVCd9MA7Pa98C9lb3yIqAwzWThU4bM9tcgQMVp6Is=;
 b=GlaV8xMp55Z/njMhYBiOYrYMDYJzjs9ytxl+YaXefpJ+AF+ObLUgturz6Q/M16poXJ
 aLRm8+w3x020c9SGyVw5AVauO+dUQuy41ltUakYoKxLqweNK3Uu4CNDqF3EO8Q3KWi0+
 zrD6hnVzFH2de/Gihg0sgbD2KH7/h0VAI1SS1PfqA5gPMK5Bome7PBaMY1201DqPt+PU
 RPjz5lPlOEs3X597mTHLUSTsWdsxyCmD33MvNeN3P+ffbfGciG77vPwIFyoq0lSCdPBQ
 NqsYRqZk49FR75StysuQuYYfdnd5zilYJI6JpHSMZAWz9fUDS36Me15akRySk+hoq3ov
 r7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h3nVCd9MA7Pa98C9lb3yIqAwzWThU4bM9tcgQMVp6Is=;
 b=j7XWRQ7SmSIK5EPeQLQDULaRrC9zsofNi2+nSaQzymrL82zYlINFS+PHDmeAhmxZg6
 2vKLqbrpkqc6vVy5O5O8OgqJsgh4+LVsnbuMjK3hiPxy6nhsTGXlUQUUQQyewzRLllDe
 K4GtIaD6W+UDHG7D/xO5n6ckY+oBIbAYsoRRTblGwJN1olMSNaDOw+va1YE6AVde8sPt
 /GWnGb7ia8JFbUHM2hw+y6N8/4+55nw6giL4eXck/AH7bEezaUyXpWAXYSlYTdhKqr+g
 jtou1Pdscng54QgCvpwoElpV6Qpktzo9zf0DIvnZwn7z8AI5TGKAE3HAabBDxAHwVJbl
 jRSA==
X-Gm-Message-State: AA+aEWYhC0wGMQ0E+X1KySvdR1Em0NYhf25WR4DDODqo+TlllkSUPA7n
 3S1LiGDdwwWqsmcTMnZioQRK0Etvz/9lRQ==
X-Google-Smtp-Source: AFSGD/Wr59sa9mSIg0MuyYvXstoGKOQtvn6faseIj3BJ2FhD1Ph+F8PfccO5m9BJpbx7ZEMNVMchzA==
X-Received: by 2002:a2e:9017:: with SMTP id
 h23-v6mr8724173ljg.71.1544544755602; 
 Tue, 11 Dec 2018 08:12:35 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d19-v6sm2761587ljc.37.2018.12.11.08.12.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:12:34 -0800 (PST)
Date: Tue, 11 Dec 2018 08:11:28 -0800
From: Olof Johansson <olof@lixom.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL 6/6] arm64: tegra: Device tree change for v4.21-rc1
Message-ID: <20181211161128.yprdf7w54o5xx7iu@localhost>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
 <20181207141739.9085-6-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207141739.9085-6-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_081247_955823_95B5BA1C 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: linux-tegra@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:17:39PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-arm64-dt
> 
> for you to fetch changes up to 611a1c69f8ca85fc656f09d0cd56f5934e2af5fb:
> 
>   arm64: tegra: Set reg property for display-hub on Tegra194 (2018-12-07 12:57:26 +0100)
> 
> Note that this pulls in a subset of the code that is also part of the
> first pull request in this series in order to satisfy some build-time
> dependencies.
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> arm64: tegra: Device tree change for v4.21-rc1
> 
> These changes add a bunch of features for Tegra194 and Tegra186, such as
> wake events, on-die RTC, temperature sensors, HDA for audio over HDMI
> and fan support on Jetson Xavier to allow cooling of the device.

Same feedback as for 32-bit, but merged into next/dt now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
