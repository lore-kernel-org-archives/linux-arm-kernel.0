Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073EBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2B921720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rfxqe4Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2B921720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FTjy409vcbXd/PTWh574M2lixlnjXxaTTmErQ5A/6Yo=; b=rfxqe4Ep1uaIRq
	IR52FU4Sovmz4LLpkT0oLtsatMpRVwEFVgL1ZQe4RmW3mwNoqkmN5VmensZZVQT+E3GBurobJMKLO
	SDKf9br7esCtibzqAJTQuCopxTH19fv2oXKxre8xSiZeZI/1jRhNtR1rEYYlhXP5WszQwO8DEraM0
	8RL4TL8lNLm5j5ZGVHtcDpe+zAasQhTyQZM37IT96SLkPu7b1lvpLcbCegS1Xm3hsjYfdRs57Mmx+
	XQSKdW6HWOPbwX+R08dYyMqsqTkIH8jQPU1xkpcN7h22Oa/AhWj+GfQAm8WagH4Jh955UsQGqvhXt
	k8dlgYI1GCh52tDfraIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzvP-0004rQ-B4; Thu, 20 Dec 2018 15:07:47 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzvK-0004mG-0n
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:07:45 +0000
Received: by mail-qt1-f169.google.com with SMTP id e5so2093093qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hJElS7sGpJx+u9OPG5mlPiK4L5Co2k/6kQEIowSugLg=;
 b=sayaEwUQPb8Vm9N1tOD+Uwuzp9j8FKVg/Klcdtucgn33qjHxTyXjNpA60WQWAsLkmX
 XIrO0W0NXydpqKaNFf5MM6xdYz8EfFRweizykiSgZgACLOFygAoSav6UbZSB3VLqDxVu
 31+vPj5sDE+LuAg24pzo1gEOf/f0VvrpNkxBhaokDA8IAbY/2U/R6YUsey3/1lzev/Pq
 63Xt7a6ITmPqMcUDKQGCQTXfeNNhZP9i605u3nrHqmKibabW1RbhunpkSjIzd1q5PEl2
 YQHR2lGC02SagsGHWS2aoY/rrSt8fElGD1u7hx4aMPgGxO2lcW/koV9mD8fcq7M2vtzO
 nI2A==
X-Gm-Message-State: AA+aEWbR1PZVpMtWeqwbu9ERDQWN2/gKRGsOpOrgHQiTyrGsNVZ8S2C/
 iopW77zh26EGoMnLs4RNMXheaGskMQjVeDbvSP4=
X-Google-Smtp-Source: AFSGD/WkiOi/7+grAhrG96dfyzj3EcIk5YqXuUoxOhOvOnuyF8zwvytX5gb4w82Km6WofqOQSXOAzMo6qkbsmowsOdA=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr26863112qvj.161.1545318450778; 
 Thu, 20 Dec 2018 07:07:30 -0800 (PST)
MIME-Version: 1.0
References: <7990b20f-0152-135c-0d0a-7d16293bd5cd@monstr.eu>
In-Reply-To: <7990b20f-0152-135c-0d0a-7d16293bd5cd@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:07:13 +0100
Message-ID: <CAK8P3a2DOcKH075kuLeB=AoH3r3hhsMvJWFuL-LzngeKZH=QpQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: Xilinx Zynq SoC driver changes for v5.0
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_070742_056694_A26F7508 
X-CRM114-Status: GOOD (  12.65  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 4:18 PM Michal Simek <monstr@monstr.eu> wrote:

>
>  The following changes since commit
> 651022382c7f8da46cb4872a545ee1da6d097d2a:
>
>    Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>
>  are available in the git repository at:
>
>    https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-v5.0
>
>  for you to fetch changes up to fee10bd2267868f2a3e7ba008ef7665aac5e4412:
>
>    memory: pl353: Add driver for arm pl353 static memory controller
> (2018-12-13 16:07:04 +0100)
>
>  ----------------------------------------------------------------
>  ARM: Xilinx Zynq SoC patches for v5.0
>
>  - Adding pl353 smc driver


Pulled into next/drivers now. A more detailed tag description would
have been helpful here, but otherwise it looks fine.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
