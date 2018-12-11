Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:29:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895CD20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjJ7Uwjf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqkFX09o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895CD20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/bqYd/o9o9nMJgFMz8XfUJ6k8N8kX6xRkluZNx/DpKo=; b=fjJ7UwjfI/U2v5
	vdCFMkxKt34ucsfRz36dHM1cIhJA3tYU82i1UxXX5hQrQdk0zQDOadeSJlXvHMv/17sJdIkBsSrgE
	X4S1PGX7tHNDqgbpuFlkgVRs3bPuPY9EFj5O3ZnJ6B7tWpQbjeXq2hAFvlNfhC6zxRxiQpBgMJNmn
	l2+ycy+1tMwwpM1eiCnnDB8RFL/97NNV2hXaRRJpNC9yUs0YgzGb1wB7wyplihoWsexLCQn4Ez9pO
	4Rg9gmTfYLkzmtxnZRYrGyO0Udtgex2rVFrnv8LJ5m1125zYXG2SqMmjL6dlaC1MicrHxipua93CT
	0em8vhdf96aClc/t6WTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjxz-0000lX-NA; Tue, 11 Dec 2018 15:28:59 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjxw-0000l7-TB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:28:58 +0000
Received: by mail-ed1-x542.google.com with SMTP id b3so12879319ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7awNY4ymdO+RNLil9JDwL8hY7iyonw/4hjSQTrtkG0Y=;
 b=aqkFX09os53Wz8YPHEdNH1j5+XhWVQIwp4/1t7QqAnq09NQZ5e/Ky2kExZjNmuh902
 e34RcDqx9Bcd7WGqugCvaM19UgoHlvAJedvAcVHCklkbsS9E+sUh3dq/AaOeV/G7d4VJ
 NMMjLK4OB/FNgxLrxjz+gG1+6HQZH6YEkdoSOBQTYiLHbHcbQNJNAIikT8/hkI7TKUlo
 zmjpB1hxadWqk9OSQcbe50BYSJyS0J3m6h2ktvi6uQnTu5UpfYTd4ql3CyieH/c1fYtq
 4XdF4z3ZgPhQICWWhjDZd8OeRpD2npwa749bXI3aGBLAfC76dkIpAVbMI+JWgXRJ/Wk+
 cXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7awNY4ymdO+RNLil9JDwL8hY7iyonw/4hjSQTrtkG0Y=;
 b=qD/S2xy1X00Cphv2An9qfPXazGRLHBbh+7R5IYgOh7q+YaSHj714TsNUoKz9G/FT8b
 JVRY2DDmrQ2KhoLBKzV9JKE70bCf/SdF+unsn8B3Lr4VErgSWVjzxXs1ml2GxpbuOXVP
 X6PXg9g6ULK5aAIPrN9SjqBO14pd7MV8DYL2xJyLwRVC2ZKrraXqJeYSDgy9LThg0rLT
 IM2eERF39iBtp/yuqfOIuHCKGt5RjlvMZJqSqDV59GWu1sVa9iOzxYTdvQA1JLgpsLnp
 aKx6C7IaCy/0LWo6N8NoDxmoOXJXq/apoJoJWn+R86MKLRn62zE+wvJqbWw/IH9EjrlS
 jEeQ==
X-Gm-Message-State: AA+aEWaTtm30Do0/wiJDnJwco1hpKbyH4g0Va2+WZmhewz4BWeUE93iN
 nzCthXbl31wwLr2JesYTyuU=
X-Google-Smtp-Source: AFSGD/UlCY20XFFFIWP/ONk+SiZ5SXRAj4sT17yb2VOnwB4TwhH8KbE0Q44Yz3HZvzUVGYBLANHO/w==
X-Received: by 2002:a50:a6cf:: with SMTP id f15mr15192704edc.97.1544542124463; 
 Tue, 11 Dec 2018 07:28:44 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:450b:7efe:59a0:ccfd])
 by smtp.gmail.com with ESMTPSA id t11sm3981662eds.34.2018.12.11.07.28.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 07:28:43 -0800 (PST)
Date: Tue, 11 Dec 2018 16:28:41 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v13 05/25] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
Message-ID: <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
References: <cover.1544099024.git.andreyknvl@google.com>
 <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
User-Agent: NeoMutt/20180622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_072856_962714_3FB2F681 
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev@googlegroups.com, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 01:24:23PM +0100, Andrey Konovalov wrote:
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 3e7dafb3ea80..39f668d5066b 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -16,9 +16,13 @@
>  /* all clang versions usable with the kernel support KASAN ABI version 5 */
>  #define KASAN_ABI_VERSION 5
>  
> +#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
>  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
> -#if __has_feature(address_sanitizer)
>  #define __SANITIZE_ADDRESS__
> +#define __no_sanitize_address \
> +		__attribute__((no_sanitize("address", "hwaddress")))
> +#else
> +#define __no_sanitize_address
>  #endif
>  
>  /*
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..5776da43da97 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -143,6 +143,12 @@
>  #define KASAN_ABI_VERSION 3
>  #endif
>  
> +#if __has_attribute(__no_sanitize_address__)
> +#define __no_sanitize_address __attribute__((no_sanitize_address))
> +#else
> +#define __no_sanitize_address
> +#endif

Not really important but it's the name with leading and trailing
underscores that is tested with __has_attribute() but then it's
the naked 'no_sanitize_address' that is used in the attribute.

-- Luc

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
