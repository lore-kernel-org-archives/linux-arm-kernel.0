Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05052192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eIZk3NWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05052192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/7yzMIP4b2nf+hp+EFlnXmCSVpz3ZRmonoYZoPBGPt8=; b=eIZk3NWTOntr6f
	Md2aycO98BnRc3LlmN8J6rZLgc0nSO0n6BfolJhrZ01s5uUYb8M9/U9ZTM+Q3ugPsdCLTnoxz793R
	13898rlf22YZZjB6J6PwftUtT5JL2ysH9FLrY+yxsCqVuEh0iVQAy9MNrSRQYThrXsEDsB9GWc9AX
	lVyygzzbsI5ED3l7ed9G2VQpuLV3MfFPKALInNNc0LfWEMaUXHmvy8tGTv97cThlUGSWjDTlHiUyD
	/+uDA6qW+aKyI99ODzT9jhu/CzY9uWBFEsDN+THHPFlDsM56e0DigwfZseC8RtmTdwgzDJGYr7UN+
	lSpiGwhMWxOjnES3jxcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufc2-000780-30; Fri, 15 Feb 2019 15:41:14 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufbz-00077b-6E
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:41:12 +0000
Received: by mail-qt1-f174.google.com with SMTP id o6so11303928qtk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=84ArB2VczstXXMpCgCuiLz0rWHngCANZGBXY1IrXErg=;
 b=pSDgT3q2srYcs5vnl3nTNSo5CjcvCLZd7tlxAaU92mHP0Wkui89D4p5l1CP3ENIj/3
 nmqQcHKLT6qdrskdSfta4JyTmQdRxuL6/Z0HBzLlfxjWZ5I1R4WunboHrJg9pujqvq77
 /EXJVhpYNxIDiyDUMYDY1DHDkd8QNg3v+MBpC6DewQDHO6KxgALaghcyMrnI64t8m5m7
 lGxbwzH35K9VgCFU6YuJbSzhK6kAbyWHB1CR8WljeTJ/poEjf2UMUzkWc2cUjse2b+A2
 /uVJDIQnsp0QkWD2IJJDLpEU2rW9bOCc8G9I+cIYkgWunr54As0jt4F/I0snbT1i7Vnw
 7htQ==
X-Gm-Message-State: AHQUAuZW9HqQFqBDZ905YxylGnwV2krGAE6at0EXC3FWT1tTWvYBzJnU
 UfpQ99e6/5/fcULWCVS7O3WvDCvSbe/JCNOP3HU=
X-Google-Smtp-Source: AHgI3IbqEYPqLaRY+7ZyheTwejO4RhZCjObosiGXyY19vZ59kKvRq/cCem46iDwvsO5/Mu0NgH2XhLu7gNtOpEMtCsY=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7904660qtb.319.1550245270286; 
 Fri, 15 Feb 2019 07:41:10 -0800 (PST)
MIME-Version: 1.0
References: <dbd59d87-c5dd-b12c-984f-909987a21a7d@ti.com>
In-Reply-To: <dbd59d87-c5dd-b12c-984f-909987a21a7d@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:40:53 +0100
Message-ID: <CAK8P3a2gRdNVrE0Oq5G5DEw_683pheq6w5htN0yZtGh-Ltryew@mail.gmail.com>
Subject: Re: [GIT PULL] AM654x SoC changes for v5.1 (part 2)
To: Tero Kristo <t-kristo@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074111_229527_65E756B9 
X-CRM114-Status: UNSURE (   8.79  )
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
Cc: Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>,
 "tony@atomide.com" <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>,
 arm-soc <arm@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 9:47 AM Tero Kristo <t-kristo@ti.com> wrote:

> ----------------------------------------------------------------
> AM654x SoC updates for v5.1 (part 2)
>
> Contains a few DT updates on top of part 1 of the pull:
>
> - MSMC RAM support (on-chip SRAM)
> - Main system control module support
> - USB support
> - ADC support
>
> There is an extra dt-binding update included, which has been acked
> by Rob.

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
