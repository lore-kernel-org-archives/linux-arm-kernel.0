Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:47:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D542086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eO54oJSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D542086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iyR3PjWlAKcddVzRrRKmZYGR5j2p0NjaJqBQbbsPaxw=; b=eO54oJSokZmrPf
	7D2oxD3BRXRImcWCdTlF9hF07wqCanJSV0zWC7LBfxMfYq1Mu2xaTS3TWmH9sRFL+QX1nyNNzZoAM
	XtIHPqYdYX84zpPPK4FSzd1usTF5IlQuzl750buv4y/HbPFuqXJ2qc6Wd7YdF2x3t0zqPdV9gCFXM
	M8aSNK7IcjwHL42teOOejHzsFTsBM0SIkU2iRxTE/ibWmsP2sXgOkiP8dnkAt2XsnHd4qeXeTSUdM
	nEMnARNmP5DncNrBkefPN7jf0UkRyAJG2sys5afOqCpxeQPaEOSL1UVYwcz0Ullab4qGEhyjg/y1D
	0kUhazxKdjQGwym0gwNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got1F-0001ox-Gc; Wed, 30 Jan 2019 16:47:21 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got0h-0001cY-KA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:46:57 +0000
Received: by mail-qk1-f196.google.com with SMTP id y78so85188qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dBnBWYuLFJRbcDQmCg5Vi1CYtIFdJ7zoLkwsEYFcMg4=;
 b=mMNjvMk/+q4XMXztnyBC21UBUuAWSHgFuVfHtRfHvF9WhZDwbiq4qj2/XRcJQJyMLC
 80a5iQZkhX21syBmM8ARurtal9LJ/1yzEo0hYGgML5rVe3oXgzYgcXYWL6x8Wbask4m+
 3hZL9Kposohskbv75pqD5I/t54zJGJONb1pI6OrNPfV5ps8vLfiEz7sztgmgbkIbTkF9
 C66uBh2P7Pv7bHzXxNOMlzHH11HIpBJrIccBm/g2YIqNJoDYAcWetZWJ70LP4xKQEFbG
 faTCI8YlX1QU5roe9HGocz4aP2hM48YipdHYe9/QSIVS5difWBN+AG53wkbCwMbbNDbo
 8zPA==
X-Gm-Message-State: AJcUukc64VaZTnpsWjBaPy6q3K4LKQPMVo/spk5K+o+mkrRY+/jDGI0L
 0IHz2Yo0XaLtoG26UHulQ0QTdQrzxY+N4x8PyHg=
X-Google-Smtp-Source: ALg8bN6jYsmd+UgbwoTKJy9IxTvlceLNqrE+jWbHcGU8+0xxu59xNb7PYeU8M5gTWQX2yKZawf40fJ9yxHf3joB5Wiw=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr27015236qkf.107.1548866806420; 
 Wed, 30 Jan 2019 08:46:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:46:29 +0100
Message-ID: <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_084648_493371_84284442 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set adds charger and fuel gauge device nodes for Spreadtrum
> SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
> devices and adds nvmem cells for ADC to calibrate the ADC channel scales.
>
> Baolin Wang (4):
>   arm64: dts: sprd: Remove PMIC INTC irq trigger type
>   arm64: dts: sprd: Add ADC calibration support
>   arm64: dts: sprd: Add SC2731 charger device
>   arm64: dts: sprd: Add SC27XX fuel gauge device

I did not apply these because of the 'sc27xx' wildcard matching.

Please fix those up and resend.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
