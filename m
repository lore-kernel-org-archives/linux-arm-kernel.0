Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C106C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F736206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nqq/QY3A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="INy8o/ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F736206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0HqgKn1+CIJJY8/meuV0o32X8xSm/ZIRfoTtfJyTRc=; b=Nqq/QY3A4YeoCx
	7Vcy7PxGGHe4YVp4xvK8ozLSihwplQ1c1pKNU3zueiB70KA5Q9u+lvhXdQv9rxE3HAIjoCP7gBI1t
	40ePY6X9gVd5U3zf96nev4nCDwwJCVcWT12Cm3d0ZWDeF+b89e9b/Sg+4+vPSYnc1+CPrFL3BmyPh
	E4XwCL1w6UHKKxR7Ud2sXjpMSK/xWUG347Ba+b1MbAepL7EiYlC+JQnodUhVVJRFOArmRkkH41M7i
	wGs15HIERAEH0exBcuLyKsJWqShp6mB4WrmFoPSZQFQNZoJ+7ornRljDjyJ+0V5/fTN3ruMgsx1Gp
	YZsG5VFsHnRib2F2UOjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxMJf-0004W8-VI; Sat, 23 Feb 2019 01:41:23 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxMJc-0004Vm-05
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 01:41:21 +0000
Received: by mail-lf1-x143.google.com with SMTP id u21so3129192lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P49xMeyF5J6dkhgL0eq+Y26r/h/xwT05CxEGNqvL/4M=;
 b=INy8o/ctFmmbqOrqZN9kIUgR+Q2DsO2pa06gc+yFao5qEROjrtaO++RsOBiLOhCdd7
 KsgBwhiuBEnyS3h9Eo4/Uze9Zpgztba47Pajs1Dy+nZJ8KEhIL9ton73Djz8SoQUJb1X
 uoXjoI7Iqy+aLM9iF0i+RFWAtinLP9K2KATJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P49xMeyF5J6dkhgL0eq+Y26r/h/xwT05CxEGNqvL/4M=;
 b=j1xNnS/kc5V4KuvmzEHed1JZNVgyVfwYcEhz+HCqIyHkcytTJ64wYmN5aYs9BdAUKk
 /6Kpk2VCmLSXIkgD7ZGvsIA3587pNELOl/ndumucGJh2pKk4X8rtOV6r41pRo/sLq3Oo
 a6O17q0VNTUSA/urU4BnLct8Vu6CE7qe73R/g/+rbf/dGXwpjrwduTH8P/hxO3y2TdBP
 NtBIRwOS5mxI6ayZ2SLy/7RBRswBgP04LmKLlMheETNxQIYQ7lsWKfxhrv/PCarfHKtZ
 mOqgbGcNueCuArzajA0YeUJibklAlnvJBdLd6ho3LcypSwZUMbPcM9jWzMCxDDoRrT2V
 +GvQ==
X-Gm-Message-State: AHQUAuabJoxJ6HaoaKQWWbZUGKoJj2KyuRCZqeKkp7c1MJbHtlgIJ7x/
 XNRSMBfswv8oAqZc2l/h+taB3GvtK+g=
X-Google-Smtp-Source: AHgI3IbkK1khMbFAaBOLNXuhp7nlk6/DAbxQ+XoEJ4omYNFc2ytd4yVbhLH4PMlUahxhr8hmAoe96Q==
X-Received: by 2002:a19:4ac4:: with SMTP id x187mr436620lfa.166.1550886076377; 
 Fri, 22 Feb 2019 17:41:16 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id m26sm802670lji.22.2019.02.22.17.41.14
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 17:41:15 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id q12so3122382lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:41:14 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr4408793lfi.62.1550886074294; 
 Fri, 22 Feb 2019 17:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
 <CAHk-=wjmp0UugFnD2KaXyGO8RprfgULwMhseDhAxQQMqqL1Eiw@mail.gmail.com>
 <CALCETrXX1cWxp7m7WVL7VWj4BKriEePxhj0noEFeHtAXvm8Dow@mail.gmail.com>
In-Reply-To: <CALCETrXX1cWxp7m7WVL7VWj4BKriEePxhj0noEFeHtAXvm8Dow@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 17:40:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6JtGsQQe6v3OiHMmhsT_LtpwsrbM8=_GeV3ejforUvw@mail.gmail.com>
Message-ID: <CAHk-=wg6JtGsQQe6v3OiHMmhsT_LtpwsrbM8=_GeV3ejforUvw@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_174120_044329_EEA45892 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 5:17 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I don't have commit access :)  But I shall email it out once I test it a bit.

Btw, looking at it, with that change every user of __put_user_size()
now passes in the properly type-cast value in 'x'.

Which means that you could remove the odd typecast in the 8-byte case:

        case 8:                                                         \
                __put_user_goto_u64((__typeof__(*ptr))(x), ptr, label); \

and make it match all the other cases:

        case 8:                                                         \
                __put_user_goto_u64(x, ptr, label);                     \

but that's just from looking at the patch, and maybe I'm missing something.

                  Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
