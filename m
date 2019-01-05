Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA7BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7DF2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPe0bcVz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBjqCOFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7DF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Ik9C5UgS3e9dq1+80a8WUxsn+MOy3FJxuKYwmKHtyI=; b=bPe0bcVzyidoRk
	EVlYlJEKE+stA0AMnXeRu5zHBVMAQ/7Sxo24M5UTcMHJgsbpKry+LEO4Glh2b9kFTqc4Hd8Nkazzz
	8ufr0RXAmMBvyQqalan/uVkDhkgeeVWHig4bgMrY4sZkP0eg+US4BbzTCbJGVKuhWNpK/MM12iXS0
	nuB9bmzDRlVd+cUg0OlM8WP/SbcZYk8/iHg4lowogFs+I5rz9S5VyPvPjjz7VL6TP5LwDHcTj63n5
	9zfSk/WagifL3zdu2wKvEDOfR+Q0iqart8ELLpg/wJJulYk7qTyrCReSOwkGaqQhgvwXmaJ4DZ0Ym
	PFG5jACQ/E0+7MpZH8mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfoZw-00021Z-IZ; Sat, 05 Jan 2019 16:13:40 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfoZq-00020k-D6
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 16:13:38 +0000
Received: by mail-qt1-x841.google.com with SMTP id d19so43522282qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 05 Jan 2019 08:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=wJQD+3taV+2dRWcSlIQEBzhFTwRN7ox4H4SOm0Qzovw=;
 b=iBjqCOFozSEyig3gjqV151FE6BJi1rXa1LokArmqdy3Ch48OVYicb/RHA1FKaS3aac
 Vrx1Rw4rUblUPUu7BfyjwQp0yA5WGixKY1XoyhAj75K+5jHdUj1MaUF70ptI7fG54wfc
 CR4p7ft9x5KviGXEUqm568EHrLYHmdZWt8YYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=wJQD+3taV+2dRWcSlIQEBzhFTwRN7ox4H4SOm0Qzovw=;
 b=hs34u/9qjgEltk1QpbOBi1E+XJkSolTKEbsjQQxUTkoei9NEtHh2yf1qSqwJ3NN0zI
 XnT4Bwbc1hfnk1BGTU4lW+HWUl2wY3uw6p+1vG3Zhd0Dgi43UKvTcB9lKnei8WHm43op
 uM+fBVwqRcpQ6MX49LX84UXX0bJbaFr/B7Yt6W9FftgGnkzTnc1w/KUqkpOr/IaeKLy3
 V8xjIYbogs7IPNAPmqWY0m7CymfaFkPCySbbdl26mOnYB7zfOCgs+EeIFMT61Bn9GR4w
 xyjQ48WLRQdvkNj9koEbleEP+XouhjijkzXNK6Rf41fzFygmf2cit5P9cOZ6GIS2Fwei
 cqLw==
X-Gm-Message-State: AA+aEWYxN6NNPcWBT/z9RtDsECiRV2KZbKi7PgyGG7heLmMqJK0YKt/J
 Z6Dg60z+F6H/le1YmtG3n2FMnw==
X-Google-Smtp-Source: AFSGD/XfVuLl5QnAXyQyf/EkTyBh9c4XiLRnWbd6xX5742752HW3EiwVQ1Vx31lj4wg1NDfLXm4m+w==
X-Received: by 2002:ac8:2b99:: with SMTP id m25mr53867090qtm.36.1546704813228; 
 Sat, 05 Jan 2019 08:13:33 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id q54sm31019163qtb.64.2019.01.05.08.13.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 05 Jan 2019 08:13:32 -0800 (PST)
Date: Sat, 5 Jan 2019 11:13:30 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 3/3] ARM: spinlock: use unified assembler language
 syntax
In-Reply-To: <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1901051112560.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch>
 <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_081334_699907_B4AC0EF3 
X-CRM114-Status: GOOD (  14.93  )
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
Cc: mark.rutland@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
 peterz@infradead.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019, Stefan Agner wrote:

> Convert the conditional infix to a postfix to make sure this inline
> assembly is unified syntax. Since gcc assumes non-unified syntax
> when emitting ARM instructions, make sure to define the syntax as
> unified.
> 
> This allows to use LLVM's integrated assembler.

Same comment as for patch 2/3.


> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Explicitly use unified syntax for inline assembly
> 
> 
>  arch/arm/include/asm/spinlock.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index 099c78fcf62d..8f009e788ad4 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -210,11 +210,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
>  
>  	prefetchw(&rw->lock);
>  	__asm__ __volatile__(
> +"	.syntax unified\n"
>  "1:	ldrex	%0, [%2]\n"
>  "	adds	%0, %0, #1\n"
>  "	strexpl	%1, %0, [%2]\n"
>  	WFE("mi")
> -"	rsbpls	%0, %1, #0\n"
> +"	rsbspl	%0, %1, #0\n"
>  "	bmi	1b"
>  	: "=&r" (tmp), "=&r" (tmp2)
>  	: "r" (&rw->lock)
> -- 
> 2.20.1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
