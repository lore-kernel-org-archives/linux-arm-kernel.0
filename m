Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D8CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D887A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJtJ0ZJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D887A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jO3/zWFZZVbB8q5NXIliesk5fWshqF9YnOcFq9eJKeQ=; b=EJtJ0ZJRIwQTKQ
	4Lo+lFCnkNwTW5eaLL3TFGE1mOFufcdiKla9KUwiEaoX4YfABclKFWxXCItg14zS053SOJypgfVQz
	QEfer8UI+XNUUxO0wmC3Hp1H9F6DzIt9rPEBl606eB6mRlRFqGOThMcFHoEkDdbNI07J0ulKfVmkx
	3lxLwJzvxoDMXfS/pVUC+3nk+FmP4UHk1VT8pfUQUlAzKQFwLQbktaVl6Shm4r5dMBUDemw8CXBZM
	IBhQsBYHhGmULf5m2EvVDeyb/VPqsPjUVxrae7Fmu4kdEb5LSsXyQCvKhfitupufCjEXmMKC0OJO8
	x8RHFELWTbKBpYA1rYjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon2T-0005zO-DH; Wed, 30 Jan 2019 10:24:13 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon2P-0005yL-Up
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:24:11 +0000
Received: by mail-qt1-f195.google.com with SMTP id k12so25572210qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EyHVW6wghgRZJEI6ej/a5UZ/nw7h3xBjS5Wrbfi5yok=;
 b=V1t+gG17FxNG34eCAlloIEz4oB8gabTDGX2MItQDPkCuE0aem1FvHNqF7NxPum/zIU
 Vidqx3V7bv/dCfwO36sKQE4+dtbS+l6UiX0NRpPRnCoB04izDUPRJaex8buTP7uYyijA
 u5HZvcWyx0pRRorFKJFc03t6gn11/2GCikqLO0Em9i9s7MS9NsHvS32k0iEHJhNQy2us
 4gLnKUbaOXROIQS5NBZvJFcXvbPrGYfI+47Foh2OwvecNd+WJac6KPbyg2TfEgOMfi68
 qSlJ51E0c8XHOBJImN+6jF5Mi5z/JaomGy2xsK0UQee2NY7lmV/461O+XHwYbEOI8hwt
 RNFQ==
X-Gm-Message-State: AJcUukeClMP+6qwc7AsBDdiIuO0YtRJyHby0nIv+u0Eh3Ugp0ryo04NL
 kb6/ophxE9ksEsbK0rr6jq68owVii/KVu3peZws=
X-Google-Smtp-Source: ALg8bN7Zzs2rvNDMTwvqhdPw4nsNK62PSeP/cf69tdFEs4uboJdECCEchE6qFZmYJJcm5xjfs6NsB+ZDAmc69Saa0FQ=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr29851971qta.152.1548843849065; 
 Wed, 30 Jan 2019 02:24:09 -0800 (PST)
MIME-Version: 1.0
References: <92cfdbed-70aa-97e9-ea37-7c06af53cfca@ti.com>
In-Reply-To: <92cfdbed-70aa-97e9-ea37-7c06af53cfca@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:23:52 +0100
Message-ID: <CAK8P3a1bLo0m6pE_AGppr_-xJfsNPPbghhCLSDvd5GAed6TvgA@mail.gmail.com>
Subject: Re: [GIT PULL] DaVinci fixes for v5.0 (part 2)
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022409_991100_DC1E2E7D 
X-CRM114-Status: GOOD (  11.20  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 11:46 AM Sekhar Nori <nsekhar@ti.com> wrote:
>
> The following changes since commit c25748acc5c20786ecb7518bfeae8fcef93472d6:
>
>   ARM: dts: da850-lcdk: Correct the sound card name (2019-01-10 13:32:51 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v5.0-part2
>
> for you to fetch changes up to e3966a766865da7ced1dece663697861dd5cf103:
>
>   ARM: dts: da850: fix interrupt numbers for clocksource (2019-01-17 18:29:12 +0530)
>
> ----------------------------------------------------------------
> This fixes a long standing typo in device-tree for DA850 in interrupt
> number for timer. It did not affect us so far because we use non-DT
> timer driver within mach-davinci. This was caught while mirating to
> clocksource driver.

Pulled into fixes, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
