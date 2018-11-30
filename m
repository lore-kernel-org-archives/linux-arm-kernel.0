Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4663C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705752146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sAvS0Ylt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705752146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AgT6EQP4IAKUN6Q1UOfVIl5G9ubD7RD0c5eGP1UeCUY=; b=sAvS0YltYNLVeK
	XpgB5TcdwR7rqnT2VIS0jxlseKu/yirm9HAVOMonl6Z31t0FxwBj2XkcE15TgzR3OY3lkH6KM6edN
	tun07ZrQFzTvbhCVvbWoGw+jU6/KA9PWAIJdnIX6KuzTm9zO6fEG6n72f34RNWgWHFSKaasZ+oMPP
	gLFjg+LOQHhNJmwsR/Eyou880E/+dNeg0BOK8ZnlrhThcBg555xxbzPI0Bh+Dn01nb+j+P68vn7gu
	UF6giQcXgnVvmBs1irOnJculGw8wIfHELjHKxxDLesz2B7lSIXq0rkKYqGrqFcN/BBte++QRIvVtu
	P2OjZ9WWyzVhE4fcQXkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeDp-0008HB-KX; Fri, 30 Nov 2018 08:32:25 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeDI-0007tq-Rt
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:31:55 +0000
Received: by mail-ed1-f67.google.com with SMTP id z28so4129918edi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 00:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PAwLI8BVj1J9LsaQ30t5cKZmbwB1RAtw/ugevLNd0Lk=;
 b=AiKBUCajJ2ABFFykjP5VkfbRfLGCraoO4WmqjgGRLqhj3cnwI+3HzJgqg7Fv/uZVNz
 CS27felc0N7e8WUFhvqRf3cVCH2DRnoinQmI2s63aXogG+/BMJpP4UHKXluQstwd8Tlr
 dR+jB0IlskHuSFQS2OPewB5yvd4HjuflwXCDN94pmPGogGD/bRWgvrS+AlVU8Mgyy6T9
 AlFbRZmueLVuJqqNvUXLFRCfgEcTv7hysvtBKzsQ5ID3CBQS6cJ8jt/c4AtIfpofWD/y
 9mu6rdyjwYG88Rloy8dXCFajS6BRnLqd+IwRJzMpHE3dK6yfLovHeadxK7VtcadaJtyp
 fHvg==
X-Gm-Message-State: AA+aEWbc+51nAQ7KNXE5Y7AbBUhxJkFdNOFdGJixzRdJEKd8aLDAyHcB
 vGF05qDoM+to9vo9hAcHYk5BHyLPrQI=
X-Google-Smtp-Source: AFSGD/WpEVM1l6tztYFzFPOqd/ibS+MdUp29J4ZTP9GpE3HVrDbjsvSUYl2ZzOYndK/F/85FVOoDDw==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr4310754edx.177.1543566700671; 
 Fri, 30 Nov 2018 00:31:40 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id t21-v6sm709522ejk.33.2018.11.30.00.31.40
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 00:31:40 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id q26so4763743wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 00:31:40 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr4539936wmd.111.1543566699694; 
 Fri, 30 Nov 2018 00:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net>
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Nov 2018 16:31:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Message-ID: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 oskari@lemmela.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_003152_912174_2CB2914B 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Quentin Schulz <quentin.schulz@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP813 AC power supply support with input current and
> voltage limiting support.
>
> AXP803 AC and battery power supply support.
>
> Changes in v6:
> * Collected tags
> * Rebase to master
> * Dropped AXP803 compatible patches
>
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
>
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
>
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit
>
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c
>
>
> Oskari Lemmela (7):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
>
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies

Since this series has been fully reviewed, and the devices it
adds/enables aren't critical, i.e. won't cause the system to fail
if the drivers are missing, I've merged the dts patches for 4.21.

Hopefully Sebastian and Lee will get around to merging the driver
patches.

Thanks.
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
