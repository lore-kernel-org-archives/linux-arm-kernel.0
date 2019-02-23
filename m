Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BAAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E7720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URciRMvd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c5WT/13v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E7720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ac6E/nM6+UpS4Sg19d4sjrvwRHkbUdjCBaJ5OvAZ/Ig=; b=URciRMvdS/KADw
	RfmVrq3/dbMd3dZh6E0CLgFycCZeiUCs9n075DjlqkW2lTNZhZUx3E3nBs/Pb+4s0R6q9tgM/jvEW
	9Gv8R/RAnAFGOzw3Yg6IC/QotJAT34SufC6iXDwSlYtVEF/oWDGFTlAACyMbWVLYIXg18ObYOB0SB
	xGL5XEBK/DKwVJCrhYwPB735QktpYyz82+UU3ihuFDSOd3ni46/WPtjJK3wSV1vnfUgYH4iGsJzDT
	w5VnpLRpYQ3evR2xeVon8aVQFS/p0U8/avMKtR8mXjq9bQTIHww+gaEPdZQXSW+wjF8uoDNNj4Wht
	d/q2OCpiyKrVk91rU8EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxMCL-0001UZ-1A; Sat, 23 Feb 2019 01:33:49 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxMCI-0001UD-0Y
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 01:33:47 +0000
Received: by mail-lj1-x244.google.com with SMTP id l5so3145957lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xQrTZV50/Bgg7212a/45Y9EdOSbPZgi+4d9Y0GVvGEw=;
 b=c5WT/13vLhi3PqGKRGbFwslWRp9pu5UMMwRtgAqHJk58mB6kxFjBKqr1SuePbM8JkL
 nXyQGf75Il/C6LcZFRzjjzXcfEJj9CMgETh25TySxBCb9yK/fgSmXCiq6PTLWEU3oYVR
 XTVcgiwcW0BbV9xNhCvYTXrfERGN3AryKzPos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xQrTZV50/Bgg7212a/45Y9EdOSbPZgi+4d9Y0GVvGEw=;
 b=ZSnbHZMBNrFNCFPiCu0kPRESIWOB5I1iVMUGWYiCrO5saUlr7jgWwMI+XdfTVWVYmy
 zLSi8OKTKeRpx4KvZnNJF4QRIjclNPsNZyA5x3t/jGehpV4jrrVKMUyyhw3q6yLOwbl3
 KGXsXoz7nA73aQOvvobr0EonkkuULbdaQNBMD+JUVrHxauB1HNaJKceUp+YDlAedw3TP
 gCIwFAmncJgblfntmPaBJ1UAMxfszsx0X3KOE+wmU6LQoYkxwuoKts/5Ni5dVOunRiiw
 8AeQcKw6lRcm6fO+zOzECggjVeqHvy2w8+iaLoc6s4xSZQRrfyIDEdFpXP/PA69fIeZP
 Op9A==
X-Gm-Message-State: AHQUAuYSLd492eAahEVB6B72kAlMKb7Hv6FRnl0TgAT2g+jB+KggA44d
 D1kAR2bo2MJJ6IJcPqZMKBwcfOweOgE=
X-Google-Smtp-Source: AHgI3IZ0Aub98gtcueeOS2DMmLZBLI3wnyVViKD0avvR4VxHvzxJNGSkKOU/ZMcXDjezGU1URERXqw==
X-Received: by 2002:a2e:6309:: with SMTP id x9mr3722021ljb.75.1550885622065;
 Fri, 22 Feb 2019 17:33:42 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173])
 by smtp.gmail.com with ESMTPSA id e25sm946009lfc.13.2019.02.22.17.33.40
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 17:33:40 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id v10so3140821lji.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:33:40 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr3745506ljg.94.1550885619751; 
 Fri, 22 Feb 2019 17:33:39 -0800 (PST)
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
Date: Fri, 22 Feb 2019 17:33:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=who4OcP6UrYX94ANLPnNjkEDh-sbgE=c2tvWpBpDP_PSQ@mail.gmail.com>
Message-ID: <CAHk-=who4OcP6UrYX94ANLPnNjkEDh-sbgE=c2tvWpBpDP_PSQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_173346_067112_2F12D9B6 
X-CRM114-Status: UNSURE (   8.27  )
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
> What I meant was: a potentially large grab bag of ways to help turn a
> bug into an exploit.

Well, apparently there's only one place, and that one looks pretty harmless.

Of course, I don't think PeterZ said what his config was. Maybe it was
a very minimal config and only found that one case because all the
truly scary cases were configured out ;)

                   Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
