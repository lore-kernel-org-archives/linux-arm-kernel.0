Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:51:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4E82089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2fUzr75";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YraNo2eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4E82089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d2SZTS7Ign206JItYY1oLfqAvy4rDmNw6QwCN7tz178=; b=u2fUzr75nRdZ5l
	l0SoXJqr7aiQqzbi5BWQsjUI1AVvdR409K8nS9xMM9tnTXuPbw8Wur0TSLerEkU2ljT3Qfj0ImojK
	q+Wy9bUVWXy42T2eEea239hn+uPaB/+s2/iYy9NxMeIP2ZtOU7LPZUvuyByrpO8bur7ZNgey8gzeZ
	aziIKIxzAzC4DZ4oO7yR4X6u40D9tlcVxgS4ax41yxjLkib5lx9yyzguKqyUdIdsejGMfuO0lSGym
	Tn2pTDOFfaKcp+qR/PiXMABPz5bNyHFx2qXxaHk045P+9l6PqbC88AU1HF8XorUm67d7Ea1V59jov
	AMqsna5qiHi8emJ68zog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggcnQ-0004Kl-Qu; Mon, 07 Jan 2019 21:50:56 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggcnL-0004KL-28
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 21:50:54 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id AC5C15C1536;
 Mon,  7 Jan 2019 22:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546897841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psMMRwMe3dh8O9dmvDsVPlF676cuwlu4ZsKyROzhdTw=;
 b=YraNo2eFRUxtwPvLHDJfsgXzwGw/y95mPvGUakQiaJZH8MUYogQwjHJ56BkWcGErBQkvpQ
 46SFYUt6hkou4ZRertpFf1Av2fPyjHcDtbHpBDbI5gHIZwoSU3z+YAZFhEz8uvQAysFvXw
 T0vrHTu/h/yjoZldgGiXhP1VN6goR1c=
MIME-Version: 1.0
Date: Mon, 07 Jan 2019 22:50:41 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: uaccess: use unified assembler language syntax
In-Reply-To: <nycvar.YSQ.7.76.1901051106410.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch>
 <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1901051106410.1783@knanqh.ubzr>
Message-ID: <3f615e62b2d3eefab0b1c17fe19bf1d2@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_135051_308810_E731DAC1 
X-CRM114-Status: GOOD (  15.76  )
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

On 05.01.2019 17:12, Nicolas Pitre wrote:
> On Thu, 3 Jan 2019, Stefan Agner wrote:
> 
>> Convert the conditional infix to a postfix to make sure this inline
>> assembly is unified syntax. Since gcc assumes non-unified syntax
>> when emitting ARM instructions, make sure to define the syntax as
>> unified.
>>
>> This allows to use LLVM's integrated assembler.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v1:
>> - Explicitly use unified syntax for inline assembly
>>
>>
>>  arch/arm/include/asm/uaccess.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
>> index 6390a40f16e7..a50f9b4e2574 100644
>> --- a/arch/arm/include/asm/uaccess.h
>> +++ b/arch/arm/include/asm/uaccess.h
>> @@ -86,7 +86,8 @@ static inline void set_fs(mm_segment_t fs)
>>  #define __range_ok(addr, size) ({ \
>>  	unsigned long flag, roksum; \
>>  	__chk_user_ptr(addr);	\
>> -	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
>> +	__asm__(".syntax unified\n" \
>> +		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
> 
> Instead of sprinkling ".syntax unified" around, you could consider 
> including <asm/unified.h> when needed.

This seems not to help in this case. When I include <asm/unified.h> at
the beginning of uaccess.h GCC still seems to emit ".syntax unified".

I guess this is since we are dealing with inline assembly. As far as I
understand its really gcc which emits a ".syntax divided" by default
when compiling ARM mode. There is an option "-masm-syntax-unified" which
according to the gcc man page should do what we need, but it seems
broken, see also: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

I agree this patch is not particularly pretty, but it is the only
solution I found to make this inline assembly work with gcc and Clang.

--
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
