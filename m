Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE68C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:25:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0A220666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6gEf3Oz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jJO4ZiAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0A220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j3hkd5JeTb0ZZqN11nytO4nkqjRqkQM+hx15cP1mEJE=; b=G6gEf3Oz7wXzEC
	8htZyn+ryAqEgEEH0CZ0poOzVLNFedfFXyEk/LVpjxgJUFQxQ2s78A7dIeR8gEZ2dnGWjdjcsVmCV
	PFkrzPBiXZ3E5IIzqRSrozheo+jL8FaVzD0sXJ7ohlebxYLuW7v2hwZtw/s9++tH58upECxyw73CS
	0Uc9o1NgIibYK65PidZt15zizXamZGhFgbnmqrzMP8LxLA6pb1+IYr3EKxRo1J+bxRQu4a4vwysBx
	EfqxTYlfcQ484zV22WL8GeIamKXwtIalZIs/ZXD1daVsdOENdGTLPX/CvDX7nCd2o8CJFetdm4rcJ
	6YRRJsb3hvxhFDpFTmvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTviZ-0008MQ-K4; Mon, 03 Dec 2018 21:25:27 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvb8-0002BC-Uz
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:18:18 +0000
Received: by mail-lj1-x244.google.com with SMTP id k19-v6so12791224lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pu/pFWhaBo+3nLDCEKgQbfprglXg8LSXWbXloXcMldg=;
 b=jJO4ZiAMhyS85dwPp1Pbhmo1sEAHHlJYkOuN9rAkIHegicKbILdFacG8nkZDUSbST/
 DOgvHvjYpp0wBpsvk5DYC5r5AgN6cyM1ugcoZiTbz6JGHeoHA84u9/dc/3csATnkg5O9
 FXuhLT9Kh5TFHH+ZemtsqanGDIOZl3QzDqSncHIBv++x0gFXaOOxv+MRRtJolVaW76I7
 ptZnK6ByFPcOp1ch+rGc9BxExtKMa7+nf0bHejL3ZvpY/Wp0a/XT+gw76iWH5+v28qEg
 zDLgAWpoH5VTBx/Chw7Ppomta9D4/OQblTUovUN7k2JmzomCYHkGUMEchS3aX4yqFQZN
 G+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pu/pFWhaBo+3nLDCEKgQbfprglXg8LSXWbXloXcMldg=;
 b=FUU1le9fNzFaV53CmY7q9cWDDTUIykqGphzWnXM4Cw9acl3ofEiXtS5EwwjupYlpRk
 SnHtSq3v2hd62rWfe52Yv4ohJQR9CE1EkU61e3z4hl9vOiasYQEvtv3qHfT8x7ZPp1Eh
 8MREocKF1LeBWk4nBlXUWHyrGwpqxo4CcBgJwrxiH1MiCpN1JkUSEUYUNIj0rEmZ1y+E
 wc6Y0eTIhbR4DvT/c9wzBBWWv2VhM8gTXdy1dAhoJ3M/ZUTXnqO+tBcgnp3k3QLyNBdl
 EdhSuUbXb6P6gIea0vffLgyhy5bdPK50qGdp+VSYqquPAi30fa0ACJMe/PzxpzDsBj9W
 oduQ==
X-Gm-Message-State: AA+aEWYcPwNL93r5k33q0bUNaTih24gyAum8azaQcG0qO7rIy4HB0tfF
 grqSUGkr00zr2bEgrc1fJ9l44g==
X-Google-Smtp-Source: AFSGD/U9nPwe1RTQjlSEG8E2PCvKgfwR1Z6oainWdVrW2BUv9PXRDG99d+zkghxutz4KiWtlbGe0ig==
X-Received: by 2002:a2e:4601:: with SMTP id
 t1-v6mr12046390lja.111.1543871859498; 
 Mon, 03 Dec 2018 13:17:39 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id h63-v6sm2713890lji.88.2018.12.03.13.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:38 -0800 (PST)
Date: Mon, 3 Dec 2018 13:11:54 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21
Message-ID: <20181203211154.kgwlcfrphxb5y4oz@localhost>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
 <1543865944-3591-3-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543865944-3591-3-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131747_416214_2E923A23 
X-CRM114-Status: GOOD (  14.53  )
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

On Mon, Dec 03, 2018 at 01:39:03PM -0600, Andy Gross wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21
> 
> for you to fetch changes up to b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> 
>   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.21
> 
> * Fix llcc license, includes, and error checks
> * Remove use of memcpy in cmd-db and fix API breakage
> * Add QCS404 compatible to SMD-RPM
> * Minor fixes for QMI
> * Add irq clear handling in QCOM Geni SE during init

Seems like a few of these should have been fixes? The error checks and irq
clearing ones in particular.

Merged into next/drivers, let me know if we should cherry-pick any to fixes.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
