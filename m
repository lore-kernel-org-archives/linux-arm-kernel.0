Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:06:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E7220857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8w3yG6x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAxpb778"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E7220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wt2FKpBJx9PpVqXLQzxYI1aT7Zu/FYvi4kgACZusPjY=; b=E8w3yG6x7mEOo5pZq3CR+5/qNg
	PPuDxa5BKjx2MQoy4HRk1h/I9cMG3OzJED2mdRPzXfTmVZVPW7ed8JDz8M298aeiOd8V3NdiQHiXr
	QiuPHxgCVTNAZIqzPO5dnrnDH8ZNu221gbYsHjVFZ61jHUltzEjHxQDZ2qbFM7/TW/pCuVH5Hc/Yr
	O3ABclmctyHYi4pYFKm47Isjhj+b9+Iql1KlcB87Khxzr9UYqujAgCgHCR83npHQ0QptoTfzN5KP9
	/VAQQCDuF9DgehZdKUe6yaWnMUek3nY6687VlMLOEc3pqBbTuqcETB8aquQSSQc1E+AVhqXe6zN6s
	j/eY/aag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpR2M-0002xX-JY; Fri, 01 Feb 2019 05:06:46 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpR1q-0002iu-EY; Fri, 01 Feb 2019 05:06:23 +0000
Received: by mail-ed1-x530.google.com with SMTP id f9so4394101eds.10;
 Thu, 31 Jan 2019 21:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FSRSNi5MOw4SiSm3JrXZg7KNmGM0qHdGPP9HeFaxeis=;
 b=HAxpb778yYcFtlkN7jJK7AbXoUpGCHojq1b07yGYe8OlmoD+UgGLsAx0zEiWB3vQ8x
 la4LOGuAV3y4r8DypT4kCGgZufNzd4HWtURwsF8lr7E26PFN4DYS/Q9ZGDo8guQIi+tu
 kx8tMBeN13gelkWrwh5pVyYOeM5MrlftM+211daSQu2fC3zmS1dbSzmvxhCOPfEnOPqJ
 qSQ9+jMamjp+JOaCGFlh282HOGSBIwAoSDqIBRjw9Br3vHv9YG/0hZej5cc0A2nfn4OV
 UyhySSDndT5hJVZgGhpfWKD3ypW0ViSPyY40AEr8OVc9/UNfiGmAAa2DVIkwIOCn5DaX
 HHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FSRSNi5MOw4SiSm3JrXZg7KNmGM0qHdGPP9HeFaxeis=;
 b=LaVH7oJOI/jUub3fNRT0oA+JHdnm/Xt5UFmFNSB2QKyx/5emvoK7tyHsjBcsuJjo6n
 87eQnrZcmgCdvgv4A6WdiGfSLen0Y1rZVc+xgCeNH2tbAbHKS7+UqynwUyPMTdI0e4b+
 0Ukkn66omWnjE6XxkHmGLSGpgw/DkncguUUbf+mDY9NRfcAXb0mH8/gKtT+5IpokHEOO
 HmR0fnVdaCvvtuJr+R/qyEVhap7MfYpTGKKkrx9qCiJV7qQ91P8th+LxdAQGuTEWrbcX
 m4584Ulz6lTsatJ5kzwQO4+dopoasj30JARqOEy9F5IJUQVx0Rq1fEcQgs2pLFyOXqk3
 wikA==
X-Gm-Message-State: AJcUukdV7Nkltn601iQZAGLVapQIm6V/rMqdWJ86QhAWbmACOT5OIDML
 hLxw539pSNIR4K7BRaPhgpvn+bO+
X-Google-Smtp-Source: ALg8bN7u41zUzpyqld69uHpsxAzgboPoZwFTqYRRlcRjut7GpsHy/VMHNqNQ7jPnSYB/HP+/E2axlQ==
X-Received: by 2002:a50:c408:: with SMTP id v8mr36948229edf.144.1548997572449; 
 Thu, 31 Jan 2019 21:06:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id c26sm1791081edb.15.2019.01.31.21.06.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 21:06:11 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
 Wei Yongjun <weiyongjun1@huawei.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>,
 =?iso-8859-1?q?Scott=0A?= Branden <sbranden@broadcom.com>,
 Rob Herring <robh@kernel.org>
Subject: Re: [PATCH -next] soc: bcm: bcm2835-pm: Make local symbol static
Date: Thu, 31 Jan 2019 21:06:02 -0800
Message-Id: <20190201050602.27265-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
References: <1547617457-60066-1-git-send-email-weiyongjun1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_210615_397462_393154FF 
X-CRM114-Status: GOOD (  10.10  )
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
Cc: kernel-janitors@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 05:44:17 +0000, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fixes the following sparse warning:
> 
> drivers/soc/bcm/bcm2835-power.c:556:32: warning:
>  symbol 'bcm2835_reset_ops' was not declared. Should it be static?
> 
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to drivers/next, thanks!
--
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
