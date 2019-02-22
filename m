Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C47C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AA42070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XpjO7IAO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gAitKGTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AA42070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsgfXdOSuH1RfeJlAjnu+19hitMlv5pSATTdDtPwc6A=; b=XpjO7IAOnFItfh
	vwY9M+umV83x8RlkkoffWui75Ja2FwPOOKy7+2HQb0Tx8PseI3wzFhTWDAGIAdgme9i4W5aqTDuIX
	tBhh7DTZLGlmCdCFBXeYDPzdC26tR8V1TvHOtM6c80JqqdzW2ppUlT47cdeY/2OFasH53Pv3oRtoY
	N6PHD0Ap/1YsS3ewfpItC3nXJAF+Sr1Foeehzp2oBHhstg+AeLoX3vZcO0NKwXHFMI9wEZI8g4rAX
	rS5DH29fLANIorN3anrMChzORFi5bmkiO/zdB5AwQlAVP/iCwgdl/wmiN1rvGzFV1xydYLn587FwW
	o+KHRcLX2wpyg4ppcU5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKKm-0008Ob-MD; Fri, 22 Feb 2019 23:34:24 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKKj-0008O6-7Q
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:34:22 +0000
Received: by mail-lj1-x241.google.com with SMTP id w6so2987300ljd.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xEtrxitrgwVOScKKZEaL4kHo4/Jod3iOAiSvJEfNQec=;
 b=gAitKGTOMM1O5T7dNf9iE/yXjhHKAA+HTPPAX8dfV1fKtrvQrM8mkFfs5RmfKRDGdw
 HW3/pUkt2DxAsChipmx48mKN7f/yiNYsecfzYHWGEne2qiiwza9eEds7Lp+E2DzsLyqs
 ZAGpyc6Kpe4OOWub731MYXLnYr42huGsF82Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xEtrxitrgwVOScKKZEaL4kHo4/Jod3iOAiSvJEfNQec=;
 b=MkmZ1uXOVn3YySJeVVPRAanlF5Z1OLXcfXp2qck5UmXbYXyBimnAEAcAC+g1qb0eft
 GrufE8/OSx/wDiKUNyuY4JlfDomUskAccvGBBGe3lBEUF15j2qdgsnjI7R598uaJVXht
 dUk+9c/AjWMFYGoJDuflmNiAWrR0c3r2yIonbOjhzt5AquaS9au9OfrpuuXetAA8pt4A
 eTElbQf9y2iL6vGPOiwJCKvcdDAivbieecaSynCweR8tubwz6oDugnXzUpslxLRlLhTD
 DoGLBeX8ituSRB7NlvUldSWTcDt+wvrcDDLRpe6EtD6Eu0+h6hP05Un46EWUmnYTjjFF
 UDmA==
X-Gm-Message-State: AHQUAuYT0jgYE8wfeMIxZ7fe6lOJ0+I9JtwNt5XS70nars8KSQkXAw/6
 j4SD0lUeEmKGxZe0BpSrRqTFaEM+N2U=
X-Google-Smtp-Source: AHgI3IaMgCUU7sRpepmaXs9XsBzUeHWMFwk52ZwIlTjpiEzzvu7kkcMrTCWP/ip7x8ei2kgGtUxUvA==
X-Received: by 2002:a2e:974a:: with SMTP id
 f10-v6mr2430968ljj.61.1550878457951; 
 Fri, 22 Feb 2019 15:34:17 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id n25sm839522lfe.70.2019.02.22.15.34.16
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 15:34:17 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id g80so2990671ljg.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:34:16 -0800 (PST)
X-Received: by 2002:a2e:6e09:: with SMTP id
 j9-v6mr3598767ljc.118.1550878456116; 
 Fri, 22 Feb 2019 15:34:16 -0800 (PST)
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
In-Reply-To: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 15:34:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHS_Dk2A7NPWi1KWGf5Ds1Yha_LnsjrWSF84+TyG54xA@mail.gmail.com>
Message-ID: <CAHk-=wiHS_Dk2A7NPWi1KWGf5Ds1Yha_LnsjrWSF84+TyG54xA@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153421_274686_289AD13B 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
 Brian Gerst <brgerst@gmail.com>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So find the below patch -- which spotted fail in ptrace.c
>
> It has an AC_SAFE(func) annotation which allows marking specific
> functions as safe to call. The patch includes 2 instances which were
> required to make arch/x86 'build':

Looks sane enough to me.

Can you make it do DF too while at it? I really think AC and DF are
the same in this context. If you call an arbitrary function with DF
set, things will very quickly go sideways (even if it might work in
practice as long as the function just doesn't do a memcpy or similar)

              Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
