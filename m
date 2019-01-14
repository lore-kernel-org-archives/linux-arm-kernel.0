Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C3BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:07:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599F12086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NzS+eiHN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGJNe2lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599F12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H48czu0Zxe5GjqvMn0vgEYdp6H+SZ49FfOqBpQpNV60=; b=NzS+eiHNE/Qztc
	QB4Jihr8msDFmn8Kv6yb/BSlSnwCM0Bl43Bz1rvrTBkg/mOFM2lBlz5sFpOGxxYMobq6AZOZJVVS3
	+IflMyttJacZ8BFdL5Jh8ee7qLPSHfyyMXKr8DnW6c09z3QLbZQ7AkMUNo0MmtlxnesCedHG56cRr
	wHFPRBV8g+B05DbZCcMlz8zww7+KHA9dgmGtkm8PTBaaCezOk19M5hkNBtTXwM0xoOIgglrjTfreW
	EVe5TAQqy/YL6zB1nU9HkY539grk17nXwRKmFxgT3mip9+qJBSY1HFFAEXl8a1vTCt9T3MRY1PRJD
	HrLVGowLC/dMhRo/zBuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4ll-0004Ge-Sq; Mon, 14 Jan 2019 16:07:21 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4lj-0004GA-4H
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:07:20 +0000
Received: by mail-pl1-x643.google.com with SMTP id p8so10342425plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+h1lzJes7KKjLhWN6tcanBpRno5ZRwwBz4+zRwLkCtI=;
 b=ZGJNe2lOzOp0XeX2Ok91XXVo23A7y4AuzC79cWQ/9tHsh251wOI3yCm0oj2E6re8bd
 hN4MnJbqLCVZO+z3aUmigi15Txycdhxfd00VJbKMq8nbCeEP5dHLHJdMsOSDBvvhltge
 eJQeIba4OtXvjvirJXoA4bkJ5TS3734uLzgxyyON4n4wZ2tA7XXd56c9Y09W0Z5w88lJ
 WMl20il65exhzVkXLTvKLbri0AQydVyMpxXFIqwQkw3QdmkwMxWMMKVk6rbHeAGt5s3K
 eX8l/Mr7FfHNtG9bGuJH+Is82QD0hcWpb3p4kvrJZomiQb7oS4OWiufB8o3OvesADMzz
 Uuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+h1lzJes7KKjLhWN6tcanBpRno5ZRwwBz4+zRwLkCtI=;
 b=lN0LdXb7qe5IFO/SNuB+lEqL8CWPBbpFfchomsyxJ4pp9Z09QPDanReXsCpBo69ZJE
 S/X6f1/5Gf4qcvgTu15Ey6tKGtvWBPnWXWSig0zH3mdiZKkMt1dmF0IcS2RzPxM59hl9
 rP8fa9+YDx6KXU+zSGar5Laelgx/klzb7cBeNR0e2tWaTW4xrjnXUETdA+ToP5JF+u87
 KNmGyesPKwq332bgA4rtkVuTs3TCe6ns3nWEGudnMAmjRBLQLyI3bWJKtIPssLeylQ/I
 Cz2OU6/lCSL48ExVjwMNlhDpy/LKUCJbqMMwJe/z9DZ5rptsSv5q1sVnwpeoh9EDyIUy
 QPBg==
X-Gm-Message-State: AJcUukfdEb2JznT6xITfpnqwKrNlnHYB3FnwS53xyD0RpXFG+aMWhYf7
 QRv1pKBa4f7l+Z2EEpI/6oA=
X-Google-Smtp-Source: ALg8bN73VzysWfFlrT+VyleX8zsqr66a7CwqQhbHUuPdJAnij9bArE5+ILz8dyKI/Sj8cFrEc5+MIw==
X-Received: by 2002:a17:902:43e4:: with SMTP id
 j91mr15304165pld.147.1547482038271; 
 Mon, 14 Jan 2019 08:07:18 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
 by smtp.gmail.com with ESMTPSA id w88sm2636832pfk.11.2019.01.14.08.07.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:07:17 -0800 (PST)
Date: Mon, 14 Jan 2019 16:07:16 +0000
From: Changbin Du <changbin.du@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190114160715.vfswtf6pzisbhxb4@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190114121151.GC10258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114121151.GC10258@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_080719_198225_71DEBB04 
X-CRM114-Status: GOOD (  23.26  )
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 12:11:56PM +0000, Mark Rutland wrote:
> On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> 
> This sounds more confusing than helpful, and it sounds like this has
> overlap with FTRACE_WITH_REGS functionality.
> 
Acctually this is similar to Return Probes. The kprobe has same
situation and it uses regs_return_value() to get retvalue. On x86 it is:
static inline long regs_return_value(struct pt_regs *regs)
{
	return PT_REGS_AX(regs);
}

on arm it is:
static inline long regs_return_value(struct pt_regs *regs)
{
        return regs->ARM_r0;
}
Due to lack of prototype info we cannot handle complex types.

FTRACE_WITH_REGS saves all general registers but here only one.
> > diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> > index 81b8eb5c4633..223f4ad269d4 100644
> > --- a/arch/arm64/kernel/entry-ftrace.S
> > +++ b/arch/arm64/kernel/entry-ftrace.S
> > @@ -202,6 +202,7 @@ ENTRY(return_to_handler)
> >  	stp x4, x5, [sp, #32]
> >  	stp x6, x7, [sp, #48]
> >  
> > +	mov	x1, x0			// return value
> >  	mov	x0, x29			//     parent's fp
> >  	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
> >  	mov	x30, x0			// restore the original return address
> 
> What about indirect return values? Those go via x8.
> 
> Additionally, in some cases (e.g. static functions with cross-function
> optimization), the compiler might not follow the usual PCS, so the
> return value might not be in x0 regardless. Maybe such functions aren't
> hooked by ftrace today?
I think these functions have been optimized out so ftrace will not trace
them.

> 
> Generally, I don't think that this is going to be reliable.
> 
> > +config HAVE_FTRACE_RETVAL
> > +	bool
> > +
> >  config HAVE_DYNAMIC_FTRACE
> >  	bool
> >  	help
> > @@ -160,6 +163,7 @@ config FUNCTION_GRAPH_TRACER
> >  	depends on HAVE_FUNCTION_GRAPH_TRACER
> >  	depends on FUNCTION_TRACER
> >  	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
> > +	select HAVE_FTRACE_RETVAL if (X86 || ARM)
> 
> ... but not arm64?
> 
> Thanks,
> Mark.

-- 
Thanks,
Changbin Du

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
