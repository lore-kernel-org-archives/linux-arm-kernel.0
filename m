Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01176C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13022146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GlYvKJ95";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu8aan8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13022146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hvdEk1NRKgCCDygfifr/aPJy6lBDixO5LArLXVQXVoc=; b=GlYvKJ95ymp1pg
	YeKwr3qY9z+j8DF38YEyr90UmbixtUKtJDYsftRKFLEDpJHeAh8c11O9WyBI4C7R4d3G77V7rtpIe
	176FNIxZoMKSA+c8q+l5fJfhlPw5vfKYKQ0oGsA37mY4foGkXYfTGFd3VPSb7bba7+yYBlz4wWjA1
	hm1HVReCJKETkob6pMCvrQydAMQR5WTgh0YtXLbfm9bNRNxKdsvzjvKY9f28UbAbaBosW7gIyqy7W
	ur8WP5noYuc1f3enDLm59EgZZDEihiZTSXOxPOL4gkcWvBm+0cE4Gg0uxhns2YvgxwmEfCttJ2UIc
	1+lslWFKrcnXpi2yu67Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqeq-0007Rf-9j; Thu, 07 Feb 2019 20:52:28 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqem-0007Qy-G6
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:52:25 +0000
Received: by mail-pl1-x644.google.com with SMTP id f90so278224plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pKTL/VUO2v+cmiF0gtxjbJiV47KA6awqYyKIrFSUDqc=;
 b=Nu8aan8qIfY42IqTNRslSjIE3HNHTa1HXz5Ii/eUGTQiwta1KIwOchyhIa+ylL6AFf
 px2rYcK4Dit+DWHb0PjEgSD3SFiFoL+kAR6DMc9thZq85MMCAeJz8NRyaV+HGufOlXLu
 xRwZqCMghe9/MRtydm3N4jfKK5hxTpp4+curaxffw+YfsRqTMx73ADEvsFM8Z2kULRZN
 Ad4IfzQicG9qXthFT9ssPDfi84hoLP7kbW6K2Y4qS/pFD6H8K0zrvCR+ES051wSom0Ti
 LuiijfqPy1pbOL6GhPs5HCtmq7OvEJGFeKRFKgiZ50xs7zBzjg8nEgTd8aoK/3dZ4MUW
 +3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pKTL/VUO2v+cmiF0gtxjbJiV47KA6awqYyKIrFSUDqc=;
 b=Bhb9nls5vTVMJsYYZ6fH7DOM8HeGJHxRHpBzi5U0pR7O8oWePm4rVMWGh1YGIulOBe
 kuJtHf1faudJFztiDjYJ3ctsHCOVAwJeVfwx4JAB+6YcGoJ77lF3M9z7iPi7PUn8/Z4e
 SFkePD8UmPcQfxE+33gfFmJ5nUsDkH7W+bGUU+oo15OjHejKEJCKa05xoJln4/S5rj4p
 d/yo7GlbPjXOEZNrc3atGwbcnjY1ogIa6T9RA/v3haK52cwJHqDkWgVTr1PaX/t7cLZS
 d/VHfBhffxnhMjj687iS2ZZr/ynQVaLJNWt7y7bakMHj3cJXdeUl+M+1AFoprjpf/7dn
 dM+g==
X-Gm-Message-State: AHQUAuZRMbGdKabxYmHZO3UABz+SgqB1UaAHKR9O4ycR/JMewWuo1Y+V
 7Q5DSOISXZrooLNYx5++cBO3/DUb14gRwAGQGXLTVQ==
X-Google-Smtp-Source: AHgI3IZKwz8iogrrII4x6WBjKdp9oBL6psLrJYaoA3GW7KKugenPXAsega03xFSIOdTn5h1oq1iBrNlnM1L4cMSPj5A=
X-Received: by 2002:a17:902:4464:: with SMTP id
 k91mr18808462pld.13.1549572740234; 
 Thu, 07 Feb 2019 12:52:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch>
 <c44f25a2d9e2f64fe41d910b09868c0f6ec3a3c9.1549532513.git.stefan@agner.ch>
In-Reply-To: <c44f25a2d9e2f64fe41d910b09868c0f6ec3a3c9.1549532513.git.stefan@agner.ch>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Feb 2019 12:52:09 -0800
Message-ID: <CAKwvOd=j_xA-dTm098un2qRnzir-9FZNv3K=5vpNT7prgMpvbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: warn if divided syntax assembler is used
To: Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_125224_556196_80252C98 
X-CRM114-Status: GOOD (  15.29  )
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

On Thu, Feb 7, 2019 at 1:46 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag to make sure the GNU
> assembler warns in case non-unified syntax is used.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Good idea, thanks for unifying the syntax.

> ---
>  arch/arm/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a0d08a3c9d33..811498e16673 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,9 +112,6 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> -

Shouldn't you also remove the references to the now gone AFLAGS_NOWARN
on lines 120 AND 127?

>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
>  CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
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
