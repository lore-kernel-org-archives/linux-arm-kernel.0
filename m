Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F45C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pV2pctAA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VoqfxPQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4SRX7e+kg6PVAIkEkteqpz5gzNrkA1Gjv47L+J/51r4=; b=pV2pctAA2dz9jX
	+LgN/EH2JivV8ut87Bzc4PUTaVCIqkn/UzFHn4J4CMZrjeC8QNGlXfBD1Ovruktfs6U2DkPwbb43O
	KiN8oSjsJmNPLAxQc2iuPQmVfDVPd1+Sl+AyyqDbfQKPYVvAWxuCYP0FJlouMgqEvVsPtI+y+w9QM
	AnV64eKoFVkGSMDZFZgct9P5Tu2jlkINjHptXxKtR9E33ADNfAtSLNjKwW5o1CC4WunDF/IXhlnQF
	MQAQ+y3Bzvc1tC9gXpo2k/bV2gwWf8Oi6OvzUUtmZMn1i357595Gi2CjSK07Nd01WmbNOpx0lUWnC
	CWTAOeMxvPGbq9ZeCN8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjA88-0004lQ-M8; Mon, 14 Jan 2019 21:50:48 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjA85-0004kb-HD
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 21:50:47 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so254988plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14YDRVDAISmz9dZZlQeYueBmLlhpYfy7IbOGqRyiihc=;
 b=VoqfxPQkIcuUU7OdfNYcqqc1DgxfgBeIUKF430kGGMvIxflJasgqb9ssflHaCHwyDW
 qIWwDCB5SXtn4HddNK0hFtT2husYotSKng8l1dclotJIPf5cdDQEag/1SU3PraQypc2M
 Y4JHEWhUds+k/hdxB+uHacrx1p1u0cBAO8CkSk088eF13mByhadQLyIMku+HOsAoDocf
 z6FxKUVvH8zAGcnzQlOpUCfu0b+HDoww7/qoWgvPks8hmyIDJ8+/eFNQZcaCzslZfXe+
 Lh2aXHvvq9DV43UXqam3ZbqQGVPCVv6g26e8DMYYJoAIWJACJNVjI6KnYA+SUWxU/mX6
 yUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14YDRVDAISmz9dZZlQeYueBmLlhpYfy7IbOGqRyiihc=;
 b=UPhVwafu1RmKtiYJPKzkoI47Lr39XGIv/Bak5cvlF0wp1+cNq0j7If1zZ1uoquwdjb
 TemTjhCtERMQe/6k7Qk0JcGbaWhuHEiyxP5SrIrzqW1ew3yxAElNhjQ1e8LXnV1/KBFl
 BoS6xEiWu3M7iz3WJBcSzlXw+tDNLAAGzPdPp3/XRDmYwAZ5dz0jxvu9BPI2DuLO6b8E
 0D7Mp4mP6Ud2qmepFGOOGNLcLRNoN/+Sit9pd/la1QSBxXkbPpXJF/04pEgjuJF9a/Pn
 Kzk9xdFe5XTndLUnz0AuC1lWvqrC+lvJzZLDoX9dUpAQrpI4YLOSQeqLPiY89TP3wfml
 5bhw==
X-Gm-Message-State: AJcUukcExwg6y/iByGC1AOeElDwF2+ubZlKbulPmffxQ0sYPgNpx/7MM
 LX//HGEUi2KjjLAW07mfHayOmhfi/dv9bYGESo5m1w==
X-Google-Smtp-Source: ALg8bN5WYwfKFNo18jusVOkbUyBtHW3XDnco3uLejxkDKuqe5av9U6hYhrAv0zmazg/Uh0xxqKFxA8L5rQ+6wM5Tf7k=
X-Received: by 2002:a17:902:4464:: with SMTP id
 k91mr627699pld.13.1547502640507; 
 Mon, 14 Jan 2019 13:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20181210223133.22667-1-ndesaulniers@google.com>
In-Reply-To: <20181210223133.22667-1-ndesaulniers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 14 Jan 2019 13:50:29 -0800
Message-ID: <CAKwvOdnZcHdV6H1H74mRGbVayYwbpU0AmX0nwhEJHYmKVuvo5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
To: Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_135045_568987_13ADD32E 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 2:32 PM <ndesaulniers@google.com> wrote:
>
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/arm/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
>
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index f4efff9d3afb..8f2fac5acbc8 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -11,7 +11,7 @@ ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
>  VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
> -VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
>  VDSO_LDFLAGS += -nostdlib -shared
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> --
> 2.20.0.rc2.403.gdbc3b29805-goog
>

Bumping for review.  This option has been removed from all other architectures.

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
