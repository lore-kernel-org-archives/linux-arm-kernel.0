From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 14 Sep 2009 02:44:04 +0100
Subject: LDREX/STREX and pre-emption on *non*-SMP hardware
In-Reply-To: <1252877053.16083.5.camel@pc1117.cambridge.arm.com>
References: <20090913194938.GA30195@shareable.org>
	<1252877053.16083.5.camel@pc1117.cambridge.arm.com>
Message-ID: <20090914014404.GE30621@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> > But what about a single CPU system?
> 
> With two or more threads, you can have something like below, even on UP
> systems:
> 
> T1			T2
> LDREX
> 			LDREX
>  			STREX (succeeds)
> 			LDREX
> STREX (succeeds)
> 			STREX (fails)
> 
> Thread T2 perform two successive atomic modifications but the context
> switch happens during the second one, so STREX in T1 should not succeed.

That's very convincing, and you are right of course.  Thanks!

-- Jamie
