Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA03C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B17C21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rCvHz2EF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5mJE4Hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17C21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p/BJSJepjozM6Uoz8JnMPODqqjFBwjXOnjfZSoYY/6c=; b=rCvHz2EFV6Lca+
	N3EBd5dmOLLYwO8Npd78IpnBZIBBvtYmGyPrBQs4eh4YDV4UhDA5/2OBjt2RT+8bhDTmRaXym1Hd8
	+yUEfuWc3YEOrP1/qkMn2bjs2mxD2Cp8rFExv9pHQNBWb1fJ9PSCKZL7GFlymdD6qiNK6jFWyzIwr
	zszwUGiM4HXVmr6Fx0x22flpbG4n12yINrfhE12FUXRhVl7PfFPIT1P0zyJDD/w8KTnqW+XiCQW9F
	/zRBe42HsGt5e9qzrikncN7BleuKnsCDCTZoxaQTOScEGasgCRf63K6Qll8S6bqBbQjR9wB/bd+TH
	mO1kln/uuniHjHhOOa9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtFvR-0002Lq-Hs; Mon, 11 Feb 2019 18:03:25 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtFvO-0002Kk-3B
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:03:23 +0000
Received: by mail-pf1-x442.google.com with SMTP id n74so4358252pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VN9lMObigACayjQrnw+MxyNXVTrGHWEO023JUJZyDtw=;
 b=Y5mJE4Hlvmlo7ZrYp9pIIKiVimHuvDGDVYBEhL/mpTIvBlW9tNh1OwsvsKWUlkjUs3
 IhUkbPeEVsiO0oUrIVrysnrn/w0zqh5DkNSCeBBwkZygEkivT29VQpGWsHT+pYLmcX7T
 7UhxY5Du61zbL5Wpkea5Sa+VUexIe5qpS12wC9fJLq8Lz2B164Fm+Hs9LSR9zbw9XDVD
 51A+n2MJ8CW8uZxo0oFXwNB4yi+OpK1RJWLtxRxG074VYzSyoGj+63IoT82/S45hD3IG
 hoPQcuiaemqiHngdl0OuthYWoGeAsc9gNFlft499bmKBHnq43fqKS5LkSM6GFyDW++r6
 YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VN9lMObigACayjQrnw+MxyNXVTrGHWEO023JUJZyDtw=;
 b=AooV71XEyZNOu1HcyaS2yjhiBbQwTsVh4FiIMbdd6QMd1Y1aA6hBfA/R0W/qR/GOJE
 13HVB+AfsrJ7o0/xgzob7ANe6HPMk6fUyVtfIwU/NlkTkRlEoCmHcSDvUknXpvMnZUXG
 1KSfC0X2sr5eu6TsacLM4PWJUcpGnemSkCrAyTWE8zGgaFyO/qhFUsYgC5OGlRN7Jv8z
 VF/N03bjG8N2AZlK9KwkHQ/LrUW/dqmGjEqX647eFxN+R+wXCeCNu+QGiH/pwvqmLXOH
 MrU+IgFjzCGVdp18ajQmBH7kzuFFnKA1cfRRcpLj4k6CucfjPRAPmrNd52D5LDGKwias
 sCAQ==
X-Gm-Message-State: AHQUAuYC6paLQp69Kmuy7gg7SnVhDz8KNYInA4hhRiSZBLExurAWBYOp
 Ib4TXIDdKq30SdzmWXYeRE21G/oW4NmXTpdUrXKYAA==
X-Google-Smtp-Source: AHgI3IZ8teRC3nkNZG6nK2xKOxvdQ/41PAYVhPH+IbTMvhTd1LJH8ZExzvTnGSN54AXYbllQgmmtblPijGVl42G6mJQ=
X-Received: by 2002:a62:2c81:: with SMTP id
 s123mr37497384pfs.174.1549908196720; 
 Mon, 11 Feb 2019 10:03:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549753425.git.stefan@agner.ch>
 <668a4c10c2731ddb572e8ddd3f0816904436d7ae.1549753425.git.stefan@agner.ch>
In-Reply-To: <668a4c10c2731ddb572e8ddd3f0816904436d7ae.1549753425.git.stefan@agner.ch>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Feb 2019 10:03:05 -0800
Message-ID: <CAKwvOdmqj449m6jTKrbdd3GHwE+uTzfkXV_8-5sUtRcL7+f2qg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: warn if divided syntax assembler is used
To: Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_100322_166007_60897401 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, julien.thierry@arm.com,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 9, 2019 at 3:09 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag to make sure the GNU
> assembler warns in case non-unified syntax is used.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Remove AFLAGS_NOWARN from CFLAGS_ISA

Thanks for making this requested change.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/arm/Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a0d08a3c9d33..9561325c5201 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,19 +112,16 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> -
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
> -CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT)
>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>  # Work around buggy relocation from gas if requested:
>  ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
>  KBUILD_CFLAGS_MODULE   +=-fno-optimize-sibling-calls
>  endif
>  else
> -CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=$(call cc-option,-marm,)
>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>  endif
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
