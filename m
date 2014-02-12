From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 12:03:11 +0100
Subject: [PATCH v3 1/6] arm64: Add ftrace support
In-Reply-To: <CAB5YjtCr2KL_q1FF8kO_VKe+feg7f9qFRKtwf3xj2h0ENwuB5g@mail.gmail.com>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
 <201402101603.21791.arnd@arndb.de>
 <CAB5YjtCr2KL_q1FF8kO_VKe+feg7f9qFRKtwf3xj2h0ENwuB5g@mail.gmail.com>
Message-ID: <201402121203.11657.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014, Takahiro Akashi wrote:
> > If I build a large "randconfig" kernel or "allyesconfig", the kernel image
> > size exceeds 32MB, which means I can no longer link callers with a 26
> > bit signed immediate argument like the "bl _mcount" here. For any other
> > function calls, "gcc -mlong-calls" can be used to work around this, but
> > this particular instance is created by inserting assembly statements
> > into the output without considering the long-call options. Is there
> > a way to get the kernel to link anyway?
> 
> I hope that this won't happen on arm64 because a branch offset range is
> +/- 128MB.

Yes, we should be safe for the next decade on arm64. My question was really
about arm32 here, hoping someone has an idea.

> > > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >
> > Here, again, you an remove the #ifdef by making the entire file built
> > only for CONFIG_FUNCTION_GRAPH_TRACER.
> 
> You're right as far as patch [1/6] is concerned, but once patch [2/6] is
> applied,
> this file (ftrace.c) may be compiled even if CONFIG_FUNCTION_GRAPH_TRACER
> is not enabled. (That is CONFIG_DYNAMIC_FTRACE.)
> Sorry for any confusion by poorly-divided patchset.

No, that was my fault. I saw it later after I had already sent out the
message.

	Arnd
