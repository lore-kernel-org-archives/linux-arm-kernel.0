From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 19 Mar 2010 01:49:06 +0000
Subject: [PATCH 1/1] [RFC] arm: add half-word __xchg
In-Reply-To: <20100318135008.GA11800@Krystal>
References: <20100318123223.GA6855@Krystal>
	<1268919221-2748-1-git-send-email-virtuoso@slind.org>
	<20100318135008.GA11800@Krystal>
Message-ID: <20100319014906.GC14108@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Desnoyers wrote:
> But.. thinking about it. It's bad to have a 2-byte xchg primitive that
> only works on UP and breaks the build on SMP. We should instead
> implement a workaround based on __cmpxchg4 to perform the 2-byte xchg().

This exposes why there should be __cmpxchg_bool() versions, which do
not loop, preferably in the generic kernel API, because the workaround
using __cmpxchg4 has to add yet another pointless loop nesting to all
cmpxchg users.

--- Jamie
