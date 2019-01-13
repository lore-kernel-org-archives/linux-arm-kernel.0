Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63554C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D0220873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrhF5Yd3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xE8yRFIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D0220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IrXjzxwA8rAHVkRBnpZki71kVTBtbZI1LACod7EwG3g=; b=GrhF5Yd387T4lG
	ZFWYXa21Lu2mAt67VCUE+5rHzpTcwPpxvUhYKAQ6fjzPPJTWmSmesz5kS9dghQ4N2j8Z1gbabDcZe
	lcsJL82YEtrW6rpgbgJ+tsRWFhvZLXVscvfufgC5cGBZ5DJ7Q2vErop78EigzzM4eHyYz6WGtwXgX
	1kFRvS9s3j58/kekOwztJ2G6bcjwn0lXQRl8TI38OWvyl570glgkTqW3eKUjsH6HOYxqwueOQrmao
	P7dL7FWwM453tThKFaSS/TdsTgqEZbW2g0g1gXLdBHAQtfY59WhZVkbPx4Qb7IfRymA/B34zMptwK
	1h6YE7bdBiUknwTBLSQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giZ0b-00054u-OC; Sun, 13 Jan 2019 06:12:33 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYyx-0003ZS-Bh
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:53 +0000
Received: by mail-lf1-x141.google.com with SMTP id e26so13497736lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ioACbg7QpjLJfsS/PURB+0U6u8kEEml8/KLflyT0nUA=;
 b=xE8yRFIq6wcEcJPeXVzJ6+k9dsk/tHKjaCDr9ZaKF0u30IG4XTK7TM2+6UkUkDCmcA
 yUh88Zq0AI3obHMGi4zEkMMifnazus29klj3xLFGrdO3pFJU+BlMiBnmxx4wpi1P2+Du
 v7sLw9DTivNPFjMp3ECAB3PKYbZc2CNHn4TTpykBZT2ANwGZMwwwqwrO8aleZ/iiTS6G
 cCAWJt5NOHkdgU+MMQ4CoHBptd/eKWKXeuhePEASVQpBJ4GJp6atWa8bqpcQeB4ZsNlY
 RStk7j+7CFCzbXdYFAAsedMs00V6KzN7NGxP5PPb2dZQjAjKnmTthRuIeNAVbE4WrFfg
 vhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ioACbg7QpjLJfsS/PURB+0U6u8kEEml8/KLflyT0nUA=;
 b=Cvzo2y3c88mFYulf8RqP4Tl0V7nHWdMO9Ob24m20p/SJQzg+jqSl08JNNxEcZJRaNV
 jSHKyunv0nfiEd+X1tM7CTZn9j/FEZwjJI5BSGNupfg8/Z3WaxvA3qKoDwgWiQ7Ud+AW
 n8ZyBsbQJdYpCtB3NC6ZdUT4zaeHht0Oo2bVmjOySde1F8jF3kRDGXfzmekfLEtbAWyw
 eyFqjzfRx7PH+KlX2KF2mjecAMs/rvgyuU9Ny3NcX4m0Igd72mKMbVD2NkeNcUUnJQix
 CUFd7NjvibS4bnycx2E8LvowhifyLEdFyh/NX+38NCu4hbX7PiVM9mCKbQFEfzwE6ZBn
 /OMA==
X-Gm-Message-State: AJcUukc126Hh6qrCpIv1u9SkKhrAQ0aV3WkYjHhlCl5jQhWwm05SSDQO
 2Oa/dj/qTK9vQLC0KXVjHBg/wA==
X-Google-Smtp-Source: ALg8bN5rkYh95SsBj48YUX8jMWcG8LxN+BD97ifjyC0B8uO1REys47D4xVaz1keFp7RwXmt6jidiJA==
X-Received: by 2002:a19:cbcc:: with SMTP id
 b195mr11710083lfg.117.1547359846459; 
 Sat, 12 Jan 2019 22:10:46 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id h3sm15348406lfj.25.2019.01.12.22.10.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:45 -0800 (PST)
Date: Sat, 12 Jan 2019 22:02:06 -0800
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Driver Fixes for 5.0-rc1
Message-ID: <20190113060206.6see7bbsj7pozjur@localhost>
References: <1547161921-32078-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547161921-32078-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221051_540823_BC7BD095 
X-CRM114-Status: GOOD (  12.20  )
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

On Thu, Jan 10, 2019 at 05:12:01PM -0600, Andy Gross wrote:
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-5.0-rc1
> 
> for you to fetch changes up to 2076607a20bd4dfba699185616cbbbce06d3fa59:
> 
>   qcom-scm: Include <linux/err.h> header (2019-01-10 17:04:45 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm Driver Fixes for 5.0-rc1
> 
> * Add required includes into qcom_scm.h

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
