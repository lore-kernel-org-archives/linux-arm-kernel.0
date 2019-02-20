Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD8B2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FFq7YQOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD8B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iWNQgVKaF1EeuR5qJBIe5ttfcDD+YaFs2GX1atWxxU=; b=FFq7YQOauZkE+/
	fjGpN7Rf83xGb1fZGpGNplLolNbfawQeDF+GVXazNWJLNZVme8wtibtbe2Nwnm5Dgm8ai9AUM+ktC
	Y/+WgEq/B12eh2/J1DIiq/VFQxtxafCucBKGkqLX2NkKff/KUbxAzkK6hAwsmF0eY28TIVJjNQjAI
	q1MA4Q9u7fybXceiHnbSPnKQsoMHWUrOxEJqVUEWb5v/F+Or0guruKCgvxcglifX03FRNwz9W1Ucd
	uUIhlAcOwfj0yaVerrXpqTcSBRMDnU2jxD4Bs42Nu/uRmMZHIxidX4lKw5jFflCT9ixsEU6R3u8ov
	odpEzFrBODZriiANNuyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwOBX-00062Z-3F; Wed, 20 Feb 2019 09:28:59 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOBU-000627-Bg
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:28:57 +0000
Received: by mail-qt1-f196.google.com with SMTP id z25so4659285qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 01:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BEECWmoaxLKcflnT7o8isAvCgchnA7bQDZHOVtYr+LA=;
 b=VZ+S6IHdoXHPl0SQXBMsbXI6KvGf8mM3uuJJZwtH+PCg6t8KUYP+qY5m9ZSzL8Fpod
 L/Ht4rBdA6YloETJnMjGuo8OQrkIm68N9FmbVgas/jboIyHn0QYhi6r6CNTmkyN1qoYS
 JStp2WjQgd6CaIfb0y7jozjHZKcibuTFJ8LrDihoRipLmwCirJmHi65U2lRk6FR4Ygwx
 rCgo9FyzaI+Gnn3cP/DpQAEc7DvDEONKnzmO5XeQdXBYGSEBOQlw21tCFzrkuinflzKm
 9tAMwo2AI1yiWQGfpG8fqRTOwouhmGOtbQDKgENag9krhZ4T7piQeRRJu6zDT8c91FE+
 mGhw==
X-Gm-Message-State: AHQUAub/D0socwKCbI6gIOMFF0TXszOwBntCmSlv+ylSkE7PWwp23QDp
 UH+tENDhtCmjY7vHWo7tebW/hxxIeEA4brm/xkw=
X-Google-Smtp-Source: AHgI3IbCQZWZ+c/E7yLc81SyNeQLOF7qVFLtnoL6YpCkRNA39syiVHMEvaM4yGBe7kmZwJMviefGSO65l/xmftxb0rA=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr25804180qtb.319.1550654934224; 
 Wed, 20 Feb 2019 01:28:54 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 10:28:38 +0100
Message-ID: <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_012856_395499_9F3618EF 
X-CRM114-Status: GOOD (  14.00  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> new file mode 100644
> index 0000000..a263211
> --- /dev/null
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -0,0 +1,175 @@

I no longer see anything here that should be turned off, but you
might want to run 'make savedefconfig' and use the output of that,
to make it easier to keep it up to date.

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5bee34a..6753805 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
>  CONFIG_ARCH_KEYSTONE=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
> +CONFIG_ARCH_MILBEAUT=y
> +CONFIG_ARCH_MILBEAUT_M10V=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_375=y

I'm surprised that you don't need to enable any drivers. Does this actually
boot on your hardware?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
