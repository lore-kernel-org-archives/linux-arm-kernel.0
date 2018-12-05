Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD005C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:07:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC62D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1M2nlvk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcOpq+zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC62D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKjFF+K87t8XK/z8oLyXZrXQ1alPngmnDkdqotKl8r0=; b=Q1M2nlvkAc5bk2
	c3Lqja9X3lyULfqJnI/vqog88mLUCxdzNFyQoEzh2a2Qbm/xqRCqfoHY8DM5I38PTsuX3d5v0iQVC
	A/DDTW19O1fKJeTZDgQOD8gBf6etRyKIfhRsfLBlQh3Qvp8mBxtotjTtJGKrd+A4uPykFj50OUWlA
	InI9EaPe51N1gDtvglGtlBeB81C0dy4Jo0r997DOOhNkdT4BXjtEdqZV15cPO6iAACsIrDzwANTOa
	pFw2IrYoqTBNqDcGekD7k9ITgjz7jkikx7kuHtACdb5E9K/G1rz6TQUh8XVj56Ccf281HT6pwPbOM
	sTFXHSOrkd/Y5EXPGmIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSD1-00013a-FA; Wed, 05 Dec 2018 08:07:03 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSCy-00012G-5E
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:07:01 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so18602150wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=a6VDonw4av4hjUtnSBSuhI19+KE7SKuGQ2Y5YPedPEY=;
 b=gcOpq+zvoZWrh6ylR6Wl0B8LS0grXz7X/VR2LiwvI/6syP8QQCqIx8BqU6eQ9FMExb
 Y4YzSoVcur9GwmiVDCaJdbQFlO8c3TBlukHTWOXx0CJXJ4NfZu4eXU3Iky1dDQruGUYT
 WGXBdQY2Zmy7Pra/Y58jH4NfAmbFspJK9I7kixHgHyFQJVtTNy4J1ClMtripPUC//Haq
 IGq2HZhd6U4V80PQJA4cvjHnjmoMiQLPiKf4rACSYkDnNrCNMMYTUp2thHs/g7C5pTgy
 UO0AoqAHk9z005MQpz+prY3mG2T5lPQIM/5uZmtnDyo5j9tKJjbJeosPqJQBFOOGTAYm
 oavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=a6VDonw4av4hjUtnSBSuhI19+KE7SKuGQ2Y5YPedPEY=;
 b=VxYfXdOyoI21Li9QyfiPgl3Z53woOiT1LmSRfD+nf0DTHmcOoxckpmF+vrmZVYGFog
 VEdvkEBDZG4c4JlLBwhO6ie8HKsK2tlrq/mT/ZDTkd3fu72R8zug4N7n1nQ4uBns1aEZ
 eRcpM7+rndXzjaDtE6VOJE5SOc1+uv23gLTGTFt3dFIT2oKmdXMZURRcwblrpsEFci1C
 s2Tl27geyPfOZC7NlURIQoVuA096twiaQNDa3MNSi+UGRD1PHkPqLf6x9DqnGxdaHGHm
 5OxxcHKK/Rk9hxzMcYFfD+pc1VnU1NHpUGc7Qo34n3RQOUz1W8HlNUj6tmA1fB9imkEy
 BPsw==
X-Gm-Message-State: AA+aEWZH7UsNQ8ai8Ixf/BT72Rgm1LDhDNpz819mbDhc4Ol0hvDAANhA
 BOoK+mhQcm1l1fCytInTeUk=
X-Google-Smtp-Source: AFSGD/XHlADWM+krT9wUpaP6H69TrePZsTw12eQEeDomFxRu8PTo8M1udxGQiwSlWz0+Z2QwfijdOA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr19415285wre.94.1543997207251; 
 Wed, 05 Dec 2018 00:06:47 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id k15sm13371734wru.8.2018.12.05.00.06.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 00:06:46 -0800 (PST)
Date: Wed, 5 Dec 2018 01:06:45 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Message-ID: <20181205080645.GA11936@flashbox>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_000700_250942_3DF28D39 
X-CRM114-Status: GOOD (  20.06  )
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
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > This flag is not supported by lld:
> >
> >     ld.lld: error: unknown argument: --pic-veneer
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Hi Nate,
> 
> Does this mean ld.lld is guaranteed to produce position independent
> veneers if you build kernels that are bigger than the typical range of
> a relative branch?
> 

Hi Ard,

Honestly, I'm not quite sure. I saw your commit that introduced this
flag and I wasn't quite sure what to make of it for lld. What
configuration would I use to verify and what would I check for?

Additionally, I have filed an LLVM bug for the lld developers to
check and see if this is a flag they should support:

https://bugs.llvm.org/show_bug.cgi?id=39886

Thanks for the quick reply,
Nathan

> > ---
> >  arch/arm/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index e2a0baf36766..4fab2aa29570 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -10,7 +10,7 @@
> >  #
> >  # Copyright (C) 1995-2001 by Russell King
> >
> > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> >  LDFLAGS_vmlinux        += --be8
> >  KBUILD_LDFLAGS_MODULE  += --be8
> > --
> > 2.20.0.rc1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
