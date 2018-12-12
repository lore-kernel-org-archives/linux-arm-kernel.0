Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7987C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8F220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yhnw7vYt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vx9FWQ+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8F220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wUW3rifBb3Nuj1G2MWmImi18pm9Oz3pFr3qSZbmts+E=; b=Yhnw7vYtw7+7mY
	7/AKhZ205+r7cFtPvwzcUseXG+zH/LF/oZJJ/MArwYjk8E7oKAe+bVGbmfgYIuA2Nxa6iZFH4d2W4
	p/CZa4M2wG7LCNTVw8WD7dljlbYPvBfbxveL0hA3xsLiGF9HGuQrsXwu8dEqRI2qX4qSw8E0zxTem
	fTddxlj518xDTS7Q2k+15yMHZ4RchdWBi1kDII3aLHh+31D3ApBxA1K8LQ7FcX298OcC3x3ZUhQpz
	neewwGiwf9AsRp3WbV2m3lvExPJanW1klQI0h47o1dmW4aezRJBo0HLgSGXQOrgKBYJ7XhWdcVAHJ
	sn8Rz9JpYJ7Ll2Y8K5uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCzo-0000Ze-LW; Wed, 12 Dec 2018 22:28:48 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoO-0007Hl-HN
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:04 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so7643lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PzCQNydjYFV8qa2UITl5l8DVJtRvpAqEai7cgBY6pLg=;
 b=vx9FWQ+y6/nzhOFZJx7+jKr9eAT6Ur3n5elFRYNy3BFZt0rJcDxCP18jjE7geccpAQ
 h0MMYBazgJ22fp3613o617VUknNwxj8KA/0hLVauvyW1XY9d4HeDNcTIT+08haPg3k17
 dh3EkdLl17KF5xIzL0/U8cNOZmdrsK25pDSy1EMAFfW54/4XjGjK/RB/EfQXDwCiqItB
 rrX3jksQFWduez4GBVvdPEAzQn1cS06/OwFPM1LPIC8HxUxTuViesv76Ibfruo/xRt3T
 k1F04qrB7pcCxXDdcbxvOyu9Z8bwM16dYgGZTs54qpdFhv4z/I9kg3ivyFl0lZxx7BeL
 Lnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PzCQNydjYFV8qa2UITl5l8DVJtRvpAqEai7cgBY6pLg=;
 b=Oxkvzc9yufRdT3H53K+Shpozahd7sLdaWAvkX56CVzjU6n1bN9h4BdPLI/ZN3KJYe0
 t9ErmHG+Hm4J/FhQ3eUzuYDWbJtHukAGKHRfpa3N34jG2xLLisqcPzWPzL58swoWZoWt
 419sqYyxasqPN/oEpx7OJif8OR/4OO/4y25PD5WJG2VbjJaeZdsmipT/LjmN/uS6fU+6
 +olR9WT7YqdjioDaWlQqJBIk1mAnN+z9orhYZIG8ZSAO1Wm/ZZfin8iz8SkdCY5IsQVl
 rzG6AEFJa5ecd51I6QqlISQOeZe4E6ATknnfh6j7xLgonjQO3v/9vZzq1SqX5+N8uR0h
 +ZGg==
X-Gm-Message-State: AA+aEWbs9fmi8A6KalOUjL2Eb218+kTuXGPl6fAsDgsATpZOao0E1Q/7
 NIkrnHlvC60KYxICtjfrVO7tBQ==
X-Google-Smtp-Source: AFSGD/UtNHPVQyZaBNNLafxYvHxLvtYnvcph12uhaRHI2clu3qsnXMU+acnpN5KzokM+LG+RdYKzDQ==
X-Received: by 2002:a2e:8156:: with SMTP id
 t22-v6mr12827012ljg.32.1544653012611; 
 Wed, 12 Dec 2018 14:16:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q127-v6sm2304ljq.45.2018.12.12.14.16.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:51 -0800 (PST)
Date: Wed, 12 Dec 2018 13:55:22 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ARM: mmp: fix timer_init calls
Message-ID: <20181212215522.hbydhfpsdvdcshji@localhost>
References: <20181210204340.2269622-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210204340.2269622-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141700_749568_3A9D201B 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: Lubomir Rintel <lkundrak@v3.sk>, arm@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 09:43:01PM +0100, Arnd Bergmann wrote:
> The change to passing the timer frequency as a function argument
> was a good idea, but caused a build failure for one user that
> was missed in the update:
> 
> arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
> arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]
> 
> Change that as well to fix the build error, and rename the
> function to put it into a proper namespace and make it clearer
> what is actually going on.
> 
> I saw that the high 6500000 HZ frequency was previously only
> set with CONFIG_MMP2, but is now also used with MMP (pxa910),
> so I'm changing that back here. Please make sure that the
> frequencies are all correct now.
> 
> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc where the rest of the MMP material lives this cycle.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
