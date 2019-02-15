Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AEDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CF02192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t9AE2AoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CF02192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yabvrDIWdgpj9+4yFRN1LjsiykOa+DuVUnHt6L1p16U=; b=t9AE2AoPZZEyUR
	OZOrTaj7RdPM7n7rKwO/Kd8kkWWLbdai35FwFggoYP9hAMTv/pivYiTG3OKZZ5GoGHaoP5uTtEwx9
	LMuVQVABSQC+gAwxBH5bM9F97XDRksecPPAETjv6sNBJLE8aCfliuHF0WTp5OI16q5gG5wx7Md9bp
	qmXx+OK4UXJ1YO5gZffvUueazLa+UHtgwR4yqyiuHew8t0+Ikbzxwu4MctPtxkgRPsLQ+4JgAgD4a
	ELcjRhkh8xYugvcJNsnv9Biw+biYFkg8YuOK9N3HCG4tgawmdqbJ64dZomXo/68nNC8vxSnFYo4Pb
	Uro/JS8wG7VljF0NBtbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueVf-0006XZ-J4; Fri, 15 Feb 2019 14:30:35 +0000
Received: from mail-qk1-f180.google.com ([209.85.222.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueVb-0006XA-To
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:30:33 +0000
Received: by mail-qk1-f180.google.com with SMTP id m9so5783367qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=crf+JUyr8fTTsIGB5rrbJzl7dn6XCII14Dmad+YcRCk=;
 b=H+/3Q8HxIuqKNneSRFPBDpMsQfKbhSJ1FNrNhnwGDJAFdtEQMrcrCJoxKBRMvxAJTR
 qg30DtuPIY8EHnZPG+JjykkWWuxm70zq8UvBAtW5jhGirqr1h9S8qdw6iBQZ/gjb9GwC
 QTmf4BNsFJraxdAX59Ccfu/IZsiA6/1ae3H9Q/VUqFtZm549GKJAZhQrPmjBiafJgWQV
 7fg/I5OWA9X8rLBBc2zW/Rg33jjZYeRqqe5XQ+AvQQj/d5m9gbciCNV2LlC3IiOOu84w
 +aihyQbi8sSF4/EQi/7BNJ/M7cmf1jJ7P124DKpwGQFVRQ2pxRohXHn0kNPIgYAIbvjK
 Sfqg==
X-Gm-Message-State: AHQUAuYqSwhRxLHxqC+F2VEYVls8w3S+wWtOlHbyLH55ibEQnB5snEf0
 IiOEuyHJez6rPHCueyUAHb/ZhoutoM1dtJEzcEuODA==
X-Google-Smtp-Source: AHgI3IZVPjr6r1vEEhh7Ky+4DAmR5Sgc8tLzga0Vzw3uOQ16i6sRimhhLDr95TkwJMAcYN25UwaIEsc4rjLzLElomu8=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr6877675qkf.107.1550241030493; 
 Fri, 15 Feb 2019 06:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20190203212936.17053-1-vz@mleia.com>
 <20190203212936.17053-2-vz@mleia.com>
In-Reply-To: <20190203212936.17053-2-vz@mleia.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:30:14 +0100
Message-ID: <CAK8P3a0PX3ceCuoXkt3TOTLnuD6SCT44rKPQauKpLezwvpEnuQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] ARM: dts: NXP LPC32xx and LPC18xx/LPC43xx changes
 for 5.1
To: Vladimir Zapolskiy <vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_063031_963629_E59D16C2 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 10:29 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
> Here are the changes for ARM NXP LPC32xx and ARM NXP LPC18xx/LPC43xx
> devicetree files:
>
> * added dts file for MYIR Tech MYD-LPC4357 development board,
> * two missing properties are added to LPC32xx keypad controller device
>   tree node, this fixes a long-standing problem with its initialization,
> * LPC32xx PL11x LCD controller device node got corrected properties,
>   which allows to use it with a new PL11x DRM driver,
> * output voltage level on one of Phytec phyCORE-LPC3250 fixed regulators
>   is corrected, the fix is needed to remove duplicating platform data,
> * Phytec phyCORE-LPC3250 board gets a description of a kit LCD panel,
>   this completes setup of CLCD device tree node for the board,
> * added unit addresses to memory device nodes on EA and Phytec boards,
> * fixes of ordinary warnings in dts formatting like leading zeroes,
>   unused address and size cell properties and so on.


Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
