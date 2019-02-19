Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66377C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F00121738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kttVfARE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BKQ5k3rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F00121738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+u+DaiyFOSNMYQapiLuLtPvahZnuPRb/GTVm3SVi1XY=; b=kttVfAREdQXY6i
	KcfOWOjqVLWmYX4AbU8wvLxG7MomRA5X7iDuBI5CcysS/odX/b9JBphxGw104MQzeWSAS5SrKh8LM
	cH0u+n/pFtJNvs2dHv4pOferbd63LTib+EQlg8asNg8SxbVF2D2LY6ZB0rZukr36diA+O8ZIzrmkm
	Aq19dnQAgbrpEjVJVop1Bwaeqzg7tHByBsr4lw4emZQBOTxt+Oatkmd3ptSZeu2dt4+hCz13Bb68o
	/qqzbR3g+/lPjsmKpH1CfH7FVwUI+HmFcJ1rDbJLo8Ppr7UNUIYZfZJk6koReg834O/nn7tUCM9xt
	FsqQ23AHOxf5hyWzpkmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvtDU-0000EW-NA; Tue, 19 Feb 2019 00:24:56 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvtDQ-0000Dn-W1
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 00:24:54 +0000
Received: by mail-lf1-x142.google.com with SMTP id n23so13611526lfl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 16:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wWtVNlWHc7fMabRJchZACsoQQvMj00mpuBH8OR27Rrs=;
 b=BKQ5k3rx3PKMMa2Z8P74CHG3KZv3WpJQaUKxrWr5339afGy0C4a1nOr2Fvp87bTD2l
 h3zzPJ7Kf71J9HwhI+rsPQEAJE3rWVzUKH4K7K8Gk4FfNwmubeZHzem+zRVFunpaMSG3
 i1muoIcRoYoZ6nHfy2PLOvTpJfoRTlDSYhUUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wWtVNlWHc7fMabRJchZACsoQQvMj00mpuBH8OR27Rrs=;
 b=l8MCzmSUSvh6Q4jxySFGcqaGrlaMHw8GnhDdlZQGGo44wqH+u2mEyT8viQLg9b6nEo
 Hi8lOKmcRfc9FMP6lpNh3rLKtpr2CKB5/1oAsZBUi+GebW9je/aNc1cj9EORqae/LO13
 XvNJAHTGBtXFnM6a63UAraWnB5ap+9RPDHHg1GTz+aR+l3nBFIPQS9nM1ZOl7SCK34oL
 jnZs+g7UNSI98mAdG0aufzVeCzyQ66xyNCTmuvtyP2iMf8mfm4diDUe2NTd1nXtiWx8L
 9kCh8VyrcdVMfxCXb1rDEp6G5j+ekq84QUwinDPRwXMH7sZFKLg4j08PkfxyE9JpRj0A
 tKXA==
X-Gm-Message-State: AHQUAuZEXMyBFuJ0vSoSUlUqcp8wuyc4gb0wDHAGL3Ys8p1y6OS/tNfu
 hzf4MyA7106V8Go7yyuBiNvXJnNmQew=
X-Google-Smtp-Source: AHgI3IZlbsEtgbYg5txW+si+LLkS0FpdN7rzToZ20/04CZEtJXeLUIPmojBWGLWxCqjg12uYHTt6Ag==
X-Received: by 2002:a19:2242:: with SMTP id i63mr3902878lfi.39.1550535887697; 
 Mon, 18 Feb 2019 16:24:47 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180])
 by smtp.gmail.com with ESMTPSA id g68sm4180941ljg.53.2019.02.18.16.24.46
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 16:24:46 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id f24-v6so15905017ljk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 16:24:46 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr13676200ljg.94.1550535886008; 
 Mon, 18 Feb 2019 16:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
In-Reply-To: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Feb 2019 16:24:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Message-ID: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: "H. Peter Anvin" <hpa@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_162453_041093_3FCFDA6A 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> The question is what "fix it" means. I'm really concerned about AC escapes,
> and everyone else should be, too.

I do think that it might be the right thing to do to add some kind of
WARN_ON_ONCE() for AC being set in various can-reschedule situations.

We'd just have to abstract it sanely. I'm sure arm64 has the exact
same issue with PAN - maybe it saves properly, but the same "we
wouldn't want to go through the scheduler with PAN clear".

On x86, we might as well check DF at the same time as AC.

              Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
