Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A63C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEED20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qFXCeSa0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YTmTateG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEED20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JlWeAP+qr+KNvs3XKKt+q/d7i7FX4EKocJOoGOAY2ck=; b=qFXCeSa0tRfmCi
	aW/wF7jlVggsrhsuFbqzbLC5YkihP1w1ahJgmQ3SanV5CcgXmvfT/wQh3aHLRfaPGXXoF5rjrDeqS
	P+qgYOCLvbtdZG9whtSIL5uFfBc97soHYy6GkgbOBwDVpX9CXVmQU5tjCyFXt1mMs3kJ/cgcn+ESw
	bGCE0TFyiZgrQNun54WT5F4JG9LRsnkPrpqLHKZXyXlEPm9YFiF7UkUokZ0F6DZ6YM2i7rxDMBDNK
	m9vlhDnJNzgroyNWtZTlTYy8BzrFCnEt3eJPEOkOcGDxNdXaxjK5s7+LMHPDMZLhvTieBIg/G2MVr
	VYUvDTRfOq69g/mq0TEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCs1-00042d-Si; Wed, 12 Dec 2018 22:20:45 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCod-0007WW-U6
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:17 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so17716799lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UPS4NPC42CyKtxdH/OReQX5lRp30R/o/4xhdnIB214o=;
 b=YTmTateGJ0Lo07KMmQttqFF/v3COxEghdorx1pkf/TyyCV6XrFCMLvjeAM/Jklz8a4
 xefW0/IXWFs4d3YeqvS0gU1kCuL+kjxGxvh7y20egsPXqxnimeEdW6jKUHZ7eEhI/gL9
 z6aH2TOLQIZQNvv42izNFvS8A18vEcWWI5dg06VWuk+SiSX4mCVEW+FEZFmR+hJg8CQC
 kZ4XQYNQdfH6mQJZMX8YhSQ5jxg3C7ZzGIo+2A9mC3r2Su9dm3NI2uYBL9+4oDSSph21
 3PDy3oPqITzFqj1GAvOWwzrYDHidzP3BJ+tSPzPayXy3qPZ8TPa3ee0yokp7tPWi4VYl
 mkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UPS4NPC42CyKtxdH/OReQX5lRp30R/o/4xhdnIB214o=;
 b=jFWQ3eONwKOhEbTJr7keSOivl69LmtohxvAdO3rCDgdhV0XuWbC8jfCq1PJvNSnIK+
 fMNkBuMRXkHEwsPxx6+FWO96GDA1P9vgc0/+xF0sI0YlwVTEkaubhPsdOCN4fE/WPk/b
 0RAObIisCuK1j3/abzs6RHehZaDGpjzWfrXLg7vl8OmsQmc+d0tkDb2ZHJ74LtsVVpOL
 dlyX+Tv7DwuP+XxD3sPqPdS74rySpuWmydJw6wPuwZDi3pZCRRhaepJbUCDkLi+um7nd
 iSlKLjIIepsQa4ITHMinf6CLyELtSHKrLNUYwbvUhIgxwo8bnj/s5uFuJnUbQuLeqU6h
 gX9A==
X-Gm-Message-State: AA+aEWa87RpAaALjmY/IEinK4nXhWEY+xLMQj+JJ/w5FvL0jjPLO0STo
 SIFhy9Boe7fmtHAkeNs/l81QZg==
X-Google-Smtp-Source: AFSGD/XMlakGZQr9V4/3j7I1OW6T7Keqbfc5QBm/s9WKVoXtv7ulQHm+BZS3nmzGI5Sey75k2fjHpw==
X-Received: by 2002:a2e:9f56:: with SMTP id
 v22-v6mr12990269ljk.114.1544653024186; 
 Wed, 12 Dec 2018 14:17:04 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id k21-v6sm4246ljc.15.2018.12.12.14.17.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:03 -0800 (PST)
Date: Wed, 12 Dec 2018 13:59:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap1 changes for v4.21
Message-ID: <20181212215917.yao2orsyr6qqagi2@localhost>
References: <pull-1544638322-89579@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1544638322-89579@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141715_970852_2466F7E2 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:13:14AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/omap1-signed
> 
> for you to fetch changes up to 5a87809b89b64c0ccd82261de53c41f2fffb56da:
> 
>   Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1 (2018-12-11 08:14:58 -0800)
> 
> ----------------------------------------------------------------
> Changes for omap1 variants for v4.21 merge window
> 
> In this set of changes Aaro Koskinen revives Palm Tungsten E for the
> MMC and USB making it usable again. And Janusz Krzysztofik follows up
> on the clean-up of  ams-delta GPIO handling. The other changes are
> clean-up for DEFINE_SHOW_ATTRIBUTE by Yangtao Li.

Cool, merged into next/soc now. Is the kernel about to outgrow these platforms
due to binary size just slowly increasing over time, or is it still usable?


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
