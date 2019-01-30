Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A0320882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mt9n8olu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4HY0tE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A0320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PnPB9iRLgxDoidsLHPZKw/73JldLqdzJ8HamAWizlC4=; b=mt9n8olu0P6UP/
	Nq8ZGQt4OGzicXbX3b02/eXxBJ+iuPU/96g97u2rnIhoBCdwkOFDV1kYKXTb/6S5jKVsR994CYafu
	I8/Eo431nLEme5PSLHMTEKY9JzzQV/mRP2LfjYlBT1zH4B6WqyjhrCDIgQdCy3EYqVdbADbS8Gd06
	x+gxvMHIXlD487QTfe0vhw2E1oQ09YqJOF0FfBbn0DomaKggHVGuYcK71UN0GNwXE8BUtG0lZiVVU
	7oC3UQ4gv4lBXujYtgV8oOPlo8tQ2AKJTQraN3skwiJYXm48nvmfIcV+D35I9fQ4v2RE1ydGmfEiI
	FLoU5GJbv1OU+DB/3E4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom3I-0008Mh-Hi; Wed, 30 Jan 2019 09:21:00 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom1l-0005ro-39
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:19:56 +0000
Received: by mail-io1-xd42.google.com with SMTP id l14so18779497ioj.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PhvCaN4Kv7vm7G6iA7saM9KjT4UB8mVq8grjhF2dBy4=;
 b=e4HY0tE+qHmSaKLgA4INHl4e+AgXVkiwSq7KR/BFdSRXM28li1IHnkT/yaqqVEuleF
 PWzms/8pP0XziQAjvJmHFbQVuvPlCrqN7Tc43z89fLJTahu4NzLfiiiYz+boqcS8eRi5
 1YRdv0rMxGrFvt6TLA62gKg0v+BmK8Yt9TuWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PhvCaN4Kv7vm7G6iA7saM9KjT4UB8mVq8grjhF2dBy4=;
 b=qUQFRGAZ0a7FvR6juihPBxKt1Pb433bELt5rmpNKhDGfNfRBjGr7dIvBBBnK3CI2Kg
 0Y19mZtVIfpWZA6NtzolEuqaOF7f0kokqArBBu9YNn8h9OodIiqw3UIyS/tYdSg2cTvG
 elAAfRUiyIq8ZSeZM0jvZ2hb44gV9q1qgSFtpyFVh/0SvKqpEzO/dh+E0+IEJKPZ1fk3
 fdmyvmw0KUnDkE/gHcCX5hEBp0Gq8mZbMvnVXF4sc5ojb3I4L8pvnHCdfmV6ZsGVUGbd
 zQ8qkhjrzsTJ41gE1wKOQsd569paYx7JxEAvrasA95E/O6+jshHvZOQXJX8mC6LOwS2t
 bavg==
X-Gm-Message-State: AHQUAuY+zl2036s2UaPI0AgPamdv3tkyE4fu8usRwgEzhW8icm8b6Qh6
 6JuUt66uSSxK2IB7The0pYqBrRgUhBr+sfnU4cDYBA==
X-Google-Smtp-Source: AHgI3IYsJJbYy2Zb+/BCEA0T7MAjCosJLSEg4zJR49yRfHTeNdEsmgC6azsTd813JhRiW1IfihrfCFfSl60l+Fvprog=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr559462ion.173.1548839964162; 
 Wed, 30 Jan 2019 01:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
 <20190130091332.gbcce2oyb24ienu2@gondor.apana.org.au>
In-Reply-To: <20190130091332.gbcce2oyb24ienu2@gondor.apana.org.au>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Jan 2019 10:19:10 +0100
Message-ID: <CAKv+Gu8NL+J0NncuyKEjo-K5Z_qXwRRuGMvm1227Q6s2rTGQ3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] crypto: crct10dif assembly cleanup and
 optimizations
To: Herbert Xu <herbert@gondor.apana.org.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011925_744815_4FFD33C1 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: Eric Biggers <ebiggers@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 10:13, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Jan 30, 2019 at 09:33:57AM +0100, Ard Biesheuvel wrote:
> >
> > So what remains is the way these implementations are encapsulated by
> > the crct10dif() library function, which is raster nasty, making
> > CRC-T10DIF an excellent use case to discuss whether we can make any
> > improvements to address some of the concerns that were also raised in
> > the zinc discussion. I threw some code together a while ago [0] (and
> > posted it as well, IIRC). In the mean time, a 'static call'
> > infrastructure is being proposed that could be used in a similar way
> > to avoid function pointers. I'm also interested in hearing opinions on
> > whether the indirect call overhead is actually significant in use
> > cases such as this one.
>
> I think even if the overhead wasn't significant it would still make
> sense to make the move just for the sake of simplicity.
>

Agreed, we should simplify this if we can.

However, my question is whether in this particular case, a simple
indirect call via a function pointer is /so/ much worse than a direct
call that relies on code patching techniques that are different on
every arch (and may rely on objtool or GCC plugins) that the extra
complexity is justified.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
