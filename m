Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE13321927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E1cTAWW/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZPnbWkIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE13321927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vXMLxSC9XSWKUTha8n7AcNEkxAuT0T28xQzKp8CMoo4=; b=E1cTAWW/OqRCSw
	QdOZYKfINkpQNwgJhABMaT+TzJmMO9Z97+Tk/mL4izrKyPaEwEY9lKwRScIoFUEJWO8Qc+tVtYwun
	HCMnkgu9BS0K5eZ3dqIDfIN1CoQDaiLZintsKHRA942k8+UePCB6kb/2CQohBpbpzrFRuF3wLP/t0
	w27fYqHJexCUWJq0k6Y7TEKbuFbZzU+FYESC4+lv8z3G8FB5giOj3VKqJ5sv2Rk49G8cUhUmxeA6r
	/kblwvP/pX+tI/3qnPHkYaXmz7cyHnjTfg4Yg8dUz5BHHa03ghu4rre00SUjgY/De+DgBiIeeAou+
	JmmujaPVKFByMjbrkjhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLZY-00028r-SV; Thu, 14 Feb 2019 18:17:20 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLZV-00028Y-ES
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:17:18 +0000
Received: by mail-lf1-x141.google.com with SMTP id h10so5032809lfc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
 b=ZPnbWkIaLF1fPpbhVu5fqt9VoWAh7zq9mqH5LmbreMaS/dFp/ga9ADBd1bUPfLNZVt
 9cmIVEyoT/T8O5y3yiREHXO6gcW+3HJveD69ZJigOCRdO+OvsnNK66RwV3oR7F6BHY0m
 nx+fInfaHOtcGNGfeA3vdOANp4vbwtRzlSmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
 b=guHAKst7csuFc//861rlEQOyCzuaflB/VVt6TkJYQU9LBbhgK4OEOgeD5lSVLEG1FE
 Edld/vF6bAMCQP7629MwphwZuTSAfv5ykdCCQwOFz1RBKvcHrBxsOZorZZWALhqzEqDR
 PhT4ygwALt9DqQf7z17n573JCu4gdslfLFIGp1fNb+ugGycSA3kL1A/5z6hI5HY+ciWA
 V4OREq+2d/qV9cwBIVyphXXU75RMhgNzy8DDDnuF3CXO1dLrNM97Jz/oVMFtGlAJ9cMx
 TYbI5eaiy+8dNe/hHfTD8bV2jbyOazuxzuoj8C/kGSM+PqdDIziVQUwEP+lf6EFsEBB9
 9Bmg==
X-Gm-Message-State: AHQUAuZIkwRg8vf/R79DL/sOoWOcxJIfQttd4ekJw9bRCp5XHhoA4eXJ
 6BGUvX6wzJV4EpDA1FmWtZlONfzDrVk=
X-Google-Smtp-Source: AHgI3IYSls4bug/Urp/SMmjrfR89ToHP78CVgvFRVQS+mam3fZva2jAh+lokM+8rkegxZ3VxVxJW+w==
X-Received: by 2002:ac2:510e:: with SMTP id q14mr2855286lfb.106.1550168234676; 
 Thu, 14 Feb 2019 10:17:14 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id g68sm592191ljg.53.2019.02.14.10.17.14
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 10:17:14 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id l7-v6so6081228ljg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 10:17:14 -0800 (PST)
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr2287389ljg.185.1550167800344; 
 Thu, 14 Feb 2019 10:10:00 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
 <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
In-Reply-To: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 10:09:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_101717_491268_2768EC2D 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The arm64 numbers scaled horribly even before, and that's because
> there is too much ping-pong, and it's probably because there is no
> "stickiness" to the cacheline to the core, and thus adding the extra
> loop can make the ping-pong issue even worse because now there is more
> of it.

Actually, if it's using the ll/sc, then I don't see why arm64 should
even change. It doesn't really even change the pattern: the initial
load of the value is just replaced with a "ll" that gets a non-zero
value, and then we re-try without even doing the "sc" part.

End result: exact same "load once, then do ll/sc to update". Just
using a slightly different instruction pattern.

But maybe "ll" does something different to the cacheline than a regular "ld"?

Alternatively, the machine you used is using LSE, and the "swp" thing
has some horrid behavior when it fails.

So I take it back. I'm actually surprised that arm64 performs worse. I
don't think it should. But numbers walk, bullshit talks, and it
clearly does make for worse numbers on arm64.

               Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
