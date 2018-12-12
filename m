Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD5C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FEB20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBPFkdWJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rahT0ctT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FEB20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1mLZkw4cMopiKpANL6IfBJZ3xRf5OLHws0iHew6zg4=; b=pBPFkdWJA1f0OG
	sFJ8EFfheIqWmu//dwyJYchDJB4UYlUX6s6w0SeP0ZGInjHd3J3BxUMQZPZB9o1xpn7sQJiNJBr2+
	3UQYrgu7GUsQadIkzHl7LPYj/RQIT6ziB9rGfT5NnUYqkj90/d1DDGhqtiQ1NowRv0JiB9U+aaQeY
	LAA7LOdNKgjBhs9B76et87bmE3ik6gXRp253qCouLrz4KRZg1lMchWoIu0RXe8QZ9hRekNXDGd7oj
	VomNfebTZGxfiq77ZZpXp3AqyuRPhu+LBXKlSzBsZJlWPuhI/aggtXRTPryeedIVyvrKYeAlY4Z20
	zqZPTM+/rnPURCa1ngTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBtW-0000zo-1a; Wed, 12 Dec 2018 21:18:14 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBql-0005d4-35
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:24 +0000
Received: by mail-lj1-x241.google.com with SMTP id u6-v6so17598041ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MQigXgLNMrVjdHttVM8h/wc7o4feonDOnUIY3ArgMWk=;
 b=rahT0ctTpIAKIZ+5HMOJMqMDEA14FV4PTEzWwaQg5Z2P3OQNLqxfOvokQWcUfkKqyZ
 mGjliqyj1xfQ26huoau1gVDUIaJEa9l71Y9KD4m7EghATFnAqTf3jbKmXxNyOm2lclC7
 RfoUtnsGfQUfzaL1g/uLTKLqWwSzo7Graa1gmR3KePtUDuXrx8GZDQ/vOWQ7rNkHqhYc
 PsWYtYXNDIuiJtpfWuUxwE3XM4ZVKYirZNnj62MTkHNahOSmotHkbsrFG/yaflTsAoZ0
 WpArhPUkfg+b3dtQr+Q+JHBzDcopaek8CCQ35pNLZx9uhbbEEb2OQNW17hG6JM1Ez/X0
 ytVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MQigXgLNMrVjdHttVM8h/wc7o4feonDOnUIY3ArgMWk=;
 b=k+JGGTuuRJBeLtKwi1AnlDnJLq4A0ofCiHCFt+rsYxT036D4NjHYbUAZdu9j/t8rcl
 7BtPfRSKTIA+QV7YwzQ3W9pklRZdvxoTgOiLol0d5xUmlE0Ks0rcuEkJNWEkKApY2SR4
 Vj+LJtjgZozYBde3NyEYe3RBs8qI/76IfdqlMuAgVsOldqrFFzYAn65oP+9t2NR0PXkn
 DtcVew4Hg0WBvEDk6PmF6C8cu+aN2IFTNIDCsdfE3eXUvEgobLN/UKfoRRbzSbu2yUwI
 YV2lznvryHDsSiplKs63Am+erxSTG4HsZsATaiYGs6bZxGMVCTPlOafI+efds/04UZn6
 eAsQ==
X-Gm-Message-State: AA+aEWYS9SPkMlYguK1zDivRkga/P0ZB3Lksa45PCNw1Rt1KtvwI0D8U
 Xh3jfc0wkf5FdZcQNsG7vRP50A==
X-Google-Smtp-Source: AFSGD/WmduvuYhc6qyfmMz/WEf2BuB9JQ0Zv+NuQEledrYXhPLmaHYN/yTHoy9/rPg1wpuWM6gR7/g==
X-Received: by 2002:a2e:88cf:: with SMTP id
 a15-v6mr12818047ljk.76.1544649311340; 
 Wed, 12 Dec 2018 13:15:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e97-v6sm3511354lji.51.2018.12.12.13.15.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:10 -0800 (PST)
Date: Wed, 12 Dec 2018 13:03:13 -0800
From: Olof Johansson <olof@lixom.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] ARM: dts: Amlogic updates for v4.21, round 2
Message-ID: <20181212210313.nusa2cf2yoravfo2@localhost>
References: <7hbm5tw1it.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7hbm5tw1it.fsf@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131523_147319_F4CCEFDB 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 12:49:14PM -0800, Kevin Hilman wrote:
> Arnd, Olof,
> 
> Please consider these updates for v4.21.
> 
> Note that this pull contains a merge of a stable commit from the clock
> tree for a new clock ID.
> 
> Thanks,
> 
> Kevin
> 
> The following changes since commit 7b141abe4aa137f362d7324de5a49fd3105f570f:
> 
>   ARM: dts: meson: add the clock inputs for the Meson timer (2018-11-28 16:49:03 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-2
> 
> for you to fetch changes up to c311552a8eadf1f9960e6126d23c4bf683ca9ae0:
> 
>   ARM: dts: meson: meson8b: add the CPU OPP tables (2018-12-04 16:48:14 -0800)

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
