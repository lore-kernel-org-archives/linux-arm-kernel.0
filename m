Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:54:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D510F21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ruxzSkl9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eQdv9n7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D510F21934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qYBRmNqo0lAcJILWxwj3Ged2P2H9cqCOR8+1dzLmXP0=; b=ruxzSkl9a6lpah
	wQia89x5c4IqqPnPHbilC+6Zk7HH0Fzv31CxL7V8zpPKpzxWYyLIz5ifmJUQMMoSeRdBx/3gZzldD
	TNJYY7Zx/uUapWmsa/kontuttY35n42W1w/aqmIPon8PU/2qIa9t7BrK7VmX7D9DamyKjQiPS3xZP
	V+9nyzPao8gOAcgYYOugKYAmufh7S6NLvMdFSSs3QxRv770NGCnvHjYGYvMcn1D1P/DFcCOBWh0GL
	8DbyuBarqPmyPskOXJKDbjCBpO4pRI2hMsLXmRCYCIlJWP0ivsj7NeOZj4nHXv07v+Si5K1nY/sHD
	I8i1qdNd1VslrV6yLrvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsbVx-0007I1-6A; Sat, 09 Feb 2019 22:54:25 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsbVu-0007HX-Bw
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 22:54:23 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 888515C041A;
 Sat,  9 Feb 2019 23:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549752852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlQkmw8s4mquGYq06cl4PilEa3gn5EmC0waOUU6hVHA=;
 b=eQdv9n7j+d4yR9YNPEyUqziwhfY0OpKssWKWaIXZ6MJpdm5iTUmojvYKSRt8yoO4irYrPM
 yieWNk0IQ8vxh6IlSnED8hNEPdul5mkTcTfgeZvwujrV2rShYmQ0Q8XOU8FmgWrNLAVDv8
 OSID4dda6jQCOSXzimzW9wKtwRdw2nk=
MIME-Version: 1.0
Date: Sat, 09 Feb 2019 23:54:12 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/5] ARM: use unified assembler in headers
In-Reply-To: <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch>
 <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
Message-ID: <b79145b3420212e0ff04dfa0da200790@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_145422_557380_35304B50 
X-CRM114-Status: GOOD (  12.94  )
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
 will.deacon@arm.com, julien.thierry@arm.com, ndesaulniers@google.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07.02.2019 17:10, Nicolas Pitre wrote:
> On Thu, 7 Feb 2019, Stefan Agner wrote:
> 
>> Use unified assembler syntax (UAL) in headers. Divided syntax is
>> considered depricated. This will also allow to build the kernel
>> using LLVM's integrated assembler.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/include/asm/assembler.h | 8 ++++----
>>  arch/arm/include/asm/vfpmacros.h | 8 ++++----
>>  arch/arm/lib/bitops.h            | 8 ++++----
>>  3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 28a48e0d4cca..60465b55683c 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -376,7 +376,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>>  	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
>>  9999:
>>  	.if	\inc == 1
>> -	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
>> +	\instr\()b\cond\()\t\().w \reg, [\ptr, #\off]
> 
> Similar comment here: you added a \() between \instr and b as needed, 
> but the one between \cond and \t (which was already redundant before) 
> may go.

Thanks, Nicolas, fixed this.

Also noticed that the else branch has such a null token in excess.

Furthermore, the "t" token actually needs to be before the condition
token too. It should look something like this in the end:

.if     \inc == 1
\instr\()b\t\cond\().w \reg, [\ptr, #\off]
.elseif \inc == 4
\instr\t\cond\().w \reg, [\ptr, #\off]
.else
...

--
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
