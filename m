Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9ECC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:10:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236142086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WLdqYwaT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="K1ZFPS82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236142086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1YJcwmHfhEQTxI1XAWPkCBZvwqNQL+vBMrv9fWWTdfQ=; b=WLdqYwaTkHQJM+
	Tl4RzoTJe1oPGHRDWQFBZm2ha87BCfNXdSIYjpc1bnXrBxhv/QxgSOY7PT0dS1AZnh5Sn6GfsEI8t
	gz9LaVPyL6OgV6D2gKiGzPS5FUVGdQtO9vF/mFT4O/+a11DM13rbHeGOSWgmU3Ld8jtGVnTWqPLwY
	IHpJacOLdBE0rD5DY/Cdt8RIY9YhVdz2SRoPBXWMOt2Oryxodibss2pb2i2+nm9knwD5d+ht+Em0u
	uyP0540nCfUp60sWc+HjTiMGUkyq5BpJsDyqYy83CmjRII3/Ew/SeLqhftkgHda47mVsHQp2pAdFW
	jRvedsipwUIAOXFMl3/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giYyx-0003Zi-Hx; Sun, 13 Jan 2019 06:10:51 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYys-0003Yw-5A
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:47 +0000
Received: by mail-lj1-x243.google.com with SMTP id u89-v6so16295081lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=H4agmV3bjRSad/w8PhqtMOHGYEpCEnbgaZZbt7XYL5Y=;
 b=K1ZFPS82ikw3R6STPevCr9jcgSQMykm32Yxt+MH110aY58B5MVCzC0B+6IMHnENz3E
 fB+TT4uvezRELwh/l572XdF3x8+CCCvmXXEGD61dY5z7uCxnQIHAZbErIZU/lIn4j+qY
 No/4JamfwmeCcslSuNFmkOFCl449D8+v+4fzFM1e4ENUqw6CRdTG4yvkz5gHPRHr2uNB
 wTIC4VIJGpr7oCxvTug9FM9XiEqhKQP019Fv8cby2ZADvzM2L+kXD/2XTNuYTNW1fDAH
 IOC+MSvAJLjudi464zSWdtZEHRj2GS4ghzdhPOIOXn+WEsfSlrZ1Yitg0W/awJ//BJX/
 pP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H4agmV3bjRSad/w8PhqtMOHGYEpCEnbgaZZbt7XYL5Y=;
 b=dWRQd2GyYIb+GdOoOh9Z4ZvY5njy/TlpaGyie2rll0hMm3Xez0uz0v7HezfExjqp/x
 ThW3Pe2oBttoXQGUaBSdgHS0JfsfUrxF/uqzyxi6c2ubfj8kYqj0lPPbWgneRXI6KcH8
 s7TSM4CHwGZwwgaSlVgRVAOInnwB6RaqgYe3slEVlqTDltmxWpU6bktbWz2XUuiUVYL0
 lH8UP5lFvZ9dPstPZJJXURhl3Kt8BiYGSxNa9OZ+6i5MBaFZ2RjrW5DYGd9QNrf4EISM
 /h54BLhhiuD3DMNyAcTsN3SXXgeZ6DbJyugs3+npI+o7O4edLZTvt7Qf8qq7Ow+j+3vi
 HUlQ==
X-Gm-Message-State: AJcUuke9ew/wI3lhtVAAhzKnzTN9QI5hTc0xLaQsxsgLUuVMnRt3gtGc
 K2HZG7g6FLryo0zCljFQxafWOg==
X-Google-Smtp-Source: ALg8bN5to54KoSznaQWVKUq+0qdTo6IaWsa8NJL3BCtAkyHeOrZ4PksTBIfH+t/6cWKEQsBFtI329g==
X-Received: by 2002:a2e:a202:: with SMTP id
 h2-v6mr11705991ljm.72.1547359844206; 
 Sat, 12 Jan 2019 22:10:44 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id c2-v6sm16656074ljj.41.2019.01.12.22.10.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:43 -0800 (PST)
Date: Sat, 12 Jan 2019 22:01:36 -0800
From: Olof Johansson <olof@lixom.net>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [GIT PULL] DaVinci fixes for v5.0
Message-ID: <20190113060136.ijo5ukqbsh2rpybm@localhost>
References: <0aa5fc18-67cf-be6f-d0ba-a8a4514e70f4@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0aa5fc18-67cf-be6f-d0ba-a8a4514e70f4@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221046_237077_BBBCFA70 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 07:25:57PM +0530, Sekhar Nori wrote:
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v5.0
> 
> for you to fetch changes up to c25748acc5c20786ecb7518bfeae8fcef93472d6:
> 
>   ARM: dts: da850-lcdk: Correct the sound card name (2019-01-10 13:32:51 +0530)
> 
> ----------------------------------------------------------------
> This pull request fixes some more regressions on legacy
> DaVinci board support due to GPIO driver clean-up introduced
> in v4.20 kernel. These are marked for stable.
> 
> Also has fixes for some long standing Audio issues on DA850
> boards.

Thanks, merged to fixes.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
