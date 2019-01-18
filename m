Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F81420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BTlheCms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F81420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eSWyqhArNnwfHZCsRYCmfcZW62ZozME808XNBswYyaw=; b=BTlheCmsdcJk9M
	gn4IIaWiMysHyukKU09wYe5BYDvFvSD8z+7Tvv+4enhLeABpaQZeUkxGMX6Wx80pGDzjHhU0qhBPF
	T6X3MwO4Auf13SKGPoEOM+gvxPL4tlaT0qt1UoS0/YPUe2c+wNB+3NINZ7GA5Xbc9Z3Rn9/J/L7sD
	LOBfu9OufUrOikg2c5PnUwaCU2ZtnztEciUzGUtyqUY3nU7JuArWIdNgUDTFgbg6122gKHZg9cces
	adA9QIGpBsTrknkKposaq4ODXE+4FIg4SRVMEnMOwPfzlsahw5jZl/1M5FdMODX00eFuzsW84zXqy
	sUbFjILsadn2+VGU5xzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX0d-0000wM-LI; Fri, 18 Jan 2019 16:28:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWzd-00006X-DF
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:27:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B655BEBD;
 Fri, 18 Jan 2019 08:27:38 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C48DF3F557;
 Fri, 18 Jan 2019 08:27:36 -0800 (PST)
Subject: Re: [PATCH 1/3] kconfig.h: abstract empty functions with STUB_UNLESS
 macro
To: Andrew Murray <andrew.murray@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <1547827230-55132-2-git-send-email-andrew.murray@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <830dafb3-7e93-e655-464f-8cb821de8dd5@arm.com>
Date: Fri, 18 Jan 2019 16:27:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547827230-55132-2-git-send-email-andrew.murray@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082741_743519_2D762AED 
X-CRM114-Status: GOOD (  21.32  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Grant Likely <Grant.Likely@arm.com>, Dave P Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/01/2019 16:00, Andrew Murray wrote:
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This can often take up a lot of space and impact
> code readability.
> 
> Let's introduce the following STUB_UNLESS macro:
> 
> STUB_UNLESS(CONFIG_FOO, [body], prototype)
> 
> This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
> to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
> inline' followed by an empty function body. Where optional argument 'body'
> then 'body' will be used as the function body, intended to allow for simple
> return statements.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Seems like it should remove a lot of boilerplate code, so looks good to me.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  include/linux/kconfig.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index cc8fa10..216a27f 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -12,6 +12,7 @@
>  
>  #define __ARG_PLACEHOLDER_1 0,
>  #define __take_second_arg(__ignored, val, ...) val
> +#define __take_fourth_arg(__ignored, __ignored2, __ignored3, val, ...) val
>  
>  /*
>   * The use of "&&" / "||" is limited in certain expressions.
> @@ -70,4 +71,34 @@
>   */
>  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>  
> +
> +
> +/*
> + * Allow for __stub to be overloaded by making the second argument optional
> + */
> +#define __stub_overload(...)		__take_fourth_arg(__VA_ARGS__, \
> +					__stub_body, __stub_void)(__VA_ARGS__)
> +#define __stub_body(option, body, ptype) __stub(option, body, ptype)
> +#define __stub_void(option, ptype)	__stub(option, , ptype)
> +
> +/*
> + * Using the same trick as __defined we use the config option to conditionally
> + * expand to an extern function declaration or a static stub function.
> + */
> +#define __stub(option, body, ptype)	___stub( \
> +					__ARG_PLACEHOLDER_##option, body, ptype)
> +#define ___stub(arg1_or_junk, body, ptype) __take_second_arg( \
> +		arg1_or_junk __extern_ptype(ptype), __static_ptype(body, ptype))
> +#define __static_ptype(body, ptype)	static inline ptype { body; }
> +#define __extern_ptype(ptype)		extern ptype
> +
> +/*
> + * STUB_UNLESS(CONFIG_FOO, [body], prototype) evaluates to 'prototype' prepended
> + * with 'extern' if CONFIG_FOO is set to 'y'. Otherwise it will evaluate to
> + * 'prototype' prepended with 'static inline' followed by an empty function
> + * body. Where optional argument 'body' is present then 'body' will be used
> + * as the function body, intended to allow for simple return statements.
> + */
> +#define STUB_UNLESS(...) __stub_overload(__VA_ARGS__)
> +
>  #endif /* __LINUX_KCONFIG_H */
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
