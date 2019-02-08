Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A546F21907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NtmuhVas";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PkS72uz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A546F21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IBXB0E9DEN1PKkKpBYpz76SSTySdf8HUmWdYuHP4Zsc=; b=NtmuhVasoLmafy
	pVb12DWv+D090NPBnRGa/UI8DUTowzJyVCWU+D5px53ibv0KZGFU5SQKYtLI/y3/ghpOldQm8sEW3
	3YENi2kWgXd5Fg315wnVPEMcAjyOhEqJ5iDXTEMq+or6ho2HS4FrmO9TMfIL5QI7sVJj3C4NfhLdo
	LL+VJ3OZo7Mcbo9DdWBpoZndEfX7jamUmfNEfP0/5D8hkRuTRgClWWPiAbPcwlbH5guxVwLMTftLP
	GFAwIXAra6WReg3YZpn7rIMh+jzYkC5TBdGrDonIEYK9w/8qP0p6+fAulNKbL3CSL3jnYBivSsVGY
	DezRloktvBlEyFYvrG8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gruPX-0000pd-78; Fri, 08 Feb 2019 00:52:55 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gruPT-0000oP-47
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:52:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id j18so853093pfe.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=pna5PQ6isrBAB3aTHUhUZYVF371WUTwDp+BF/t+C/MI=;
 b=PkS72uz0uAWG9bbtkFXEezORMZnaKrTA2Cl6YK5aUB9E554Lxbc+YnhC97U0SDvUka
 ++Q5jT6FDVn5hCzD57z8pL/J7VW2Dy9Nh9Gl2UJMtt6vTYRjl+70J3vcSlkZr/nTDrzF
 K1JCDaVv6WYcOGRSwGxYNl66v3uQAc9tU/2bZVMwmeJ9HDCWs2Ezle0xY5fb4iKubKgr
 lkoU3uAjmxUEwHwE3b1Wb+g/wVOi/Ww6tOtMdIVvDbRm8UrMqPxPjQV5vrJfVvnpwE0p
 CvF/6tY/nAEjRSy6ocgIGSWYV61KO+70OtEa183CfX9J7nsabyz8eHCP1ecyZmH9llBZ
 NipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=pna5PQ6isrBAB3aTHUhUZYVF371WUTwDp+BF/t+C/MI=;
 b=PpaGsGfNZwYjrwPI9qGNWbrHTQlwK2B3bFibrC2Z279JfG2T6ehNrLXjxacSIMmrpO
 1HOiZtoWXuo+l4WmOeiThdWJWjK2nDBn1QVrE7DvmR1NS9o9uE6F0sUCq6bU4rHnCbOY
 upYJje1NuSEKW8kfkRrwCCfjEiULEc44nMBbdft/x8nxF0Ao6i/QrkD+/uSrmtvuBy8N
 ZI+q8OAth3Oz6fBBWkj/mYD0bNgCiDCx9+9xVeJuSPPv0bh+U/7cjqPHifqC35d4Szxj
 2ljF83GivbY8QCb5RETXxFXXVXYqsLsWHMGXI4QHKCL8msNA8eB9FAqCy1g3SSRnORgO
 ALiQ==
X-Gm-Message-State: AHQUAuZyok6n5nddzHVVX6xJujY99JATPwBPqZKl91bK/XwcaqYgMlvU
 1/QNEjyG6xl6n7phEoFrLf3twA==
X-Google-Smtp-Source: AHgI3IZtHELm0XiYrNwP8mgmR0kL4wFcUAoa43JPc9pnhrJ/OZ/bdUc6BdhffybgoCtHBrBlR1rkfA==
X-Received: by 2002:aa7:84c7:: with SMTP id x7mr10756119pfn.180.1549587170484; 
 Thu, 07 Feb 2019 16:52:50 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id g11sm414133pfo.139.2019.02.07.16.52.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:52:49 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/2] soc: amlogic: clk-measure: fix-up some clock
 definitions
In-Reply-To: <20190207132603.694-3-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com>
 <20190207132603.694-3-jbrunet@baylibre.com>
Date: Thu, 07 Feb 2019 16:52:48 -0800
Message-ID: <7hr2cjf6e7.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_165251_160985_BE71E4D2 
X-CRM114-Status: UNSURE (   7.61  )
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
Cc: devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> As pointed out in review, a few clock are not properly defined.
>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Fixes: 2a4c63e080cd ("soc: amlogic: clk-measure: add axg and g12a support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I squashed this with the original too.

In doing so, I noticed I (mis)applied this to my dt64 branch, so while
sqaushing, I also moved it to my drivers branch.

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
