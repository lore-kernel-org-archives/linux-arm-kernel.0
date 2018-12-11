Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6422B20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D05f03FT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zXrbRjyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6422B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eRmWXH0mz9eGwgh+oxuDq0gyeZS0Gl6sD+p1vaEGOgQ=; b=D05f03FTdd99U0
	YlPlFqHaDm1sehwWDdLZVvRqE6BxUuTSB1go2cm8vXyXnFJBDEdE02RomVcGK+/dvE2a9DwLDuzOB
	lk15DkwGKPaUEjkNN54OQagbEJoEce2g2fBDOGNc0fc9bvZnI3fBotvYyEZix8drK+pz8gFLXqN/A
	j3lyu38e9QOlxPxxMpgBTDXHngo9uQuCmGABFX31fhbM78YNg2ItGgUhP/2nhxkf/uSz9/55XcD33
	v8XPdhi6hDn1+R2c7Ag8BA9ZxrdURVz0KDqYZVSQbtmZNjFNBgwuWk43NY0ENeJna9IKnCuF0PBWE
	Bm4T+StU64JDsL8sl/PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWmWv-0003Ei-VA; Tue, 11 Dec 2018 18:13:13 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmWr-0003Dj-NL
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:13:11 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so7277510plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=pT2whDOmBW/Okp7OjEGSRsFNRFC0UEQR4Gv61kcBsns=;
 b=zXrbRjyWsLwaMEUKrTMpnGKkHiecDb1b44rg8zMenwgaCmtwJeuXUiGcUvQ+OB4OZV
 ZbwOIVIfgbPPHkRXX92CtQpUTEP1X/2RA8+jydDtdX3fDIgfwD4xvkQJNOrkOZy3n/7K
 00azzdax/53RSnxmi0vjy4wefttUOJeGi42dY7YwIG1rUQJ/g/8YjXcaIAT7/OtRS3vZ
 1j0q7bQeIXq8UZvUaiHZkNBvoKgpV4XpoR2cgT07jmnEaznzeMFmNCtGVz3jgsny0lDE
 blpAMvKja21q47bEqnMiGRcB7NS5oE3A3G57hbYshRLRdmKp6bq7LyE3x/gMwvtOsX6D
 FOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=pT2whDOmBW/Okp7OjEGSRsFNRFC0UEQR4Gv61kcBsns=;
 b=S3WwjzuC0Zb9T/oypsu2Td0BWjTkKLRLjYoX89ScbdM2nUE0VqJv2fv93kzm++iAwR
 x3/yebGhPva0qBIH0nWnU0g0FqCCUGtqihC27jCXnLkCuJwhoDf+MNtiTTAdv+/b3mDH
 ryyUGDC1B7gcYZHKfwsRAZKZJ4YWkS5MlBrsiXJauvgOAbQZaqkD1nvzPO9T8GJTmRJ6
 olEvoXwogxYMYgoaAiAR6GLkLCVN4NmslxbsQkP5AIXbppwxFp7HZiXm45mpl+wS99s+
 +PnQ6HPIcMYyPvjGxlxCKSL6kcmBkyLNU4cMi5alErB7xl3GagKbZuFRStWx0zqjbBGT
 gXgA==
X-Gm-Message-State: AA+aEWYAo+aQYVLBr8jo3ChEcqQNmaIh72Y13BMM/gperkuaEdZS7FK/
 HjmQW61AZKzVNY/16EYkUrX9Yg==
X-Google-Smtp-Source: AFSGD/XAwhD8if9V+9G0iZ73WSXdZcEO8xOoEVTvVllOTltGPS9aDxLI42qna+5CzPxEKckNrAqGtA==
X-Received: by 2002:a17:902:8f83:: with SMTP id
 z3mr16471574plo.328.1544551978831; 
 Tue, 11 Dec 2018 10:12:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id 84sm33973130pfk.134.2018.12.11.10.12.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 10:12:57 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
 Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
Date: Tue, 11 Dec 2018 10:12:57 -0800
Message-ID: <7h1s6oue3a.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_101309_764231_ECD244B5 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> The function am43xx_suspend_init() references
> the function __init am43xx_map_scu().
> This is often because am43xx_suspend_init lacks a __init
> annotation or the annotation of am43xx_map_scu is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
