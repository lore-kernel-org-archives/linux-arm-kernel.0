From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 28 Sep 2009 13:49:22 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928092919.GA30271@localhost>
References: <20090928092919.GA30271@localhost>
Message-ID: <20090928124922.GA19778@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Imre Deak wrote:
> Hi,
> 
> the following test app will cause an unhandled kernel paging request
> on VIPT platforms. The triggering condition is the mmap_sem held by
> thread_func while the main thread performs cache flushing.
> 
> Since the likelihood of this to trigger is relatively low, a patch will
> follow that makes similar bugs more visible.

I would expect the likelihood of triggering would be higher for at
least one of Java, Mono, Parrot or any of the modern Javascript
engines.  cacheflush is used by anything which generates code, and
mmap is used for loading libraries - things those applications do a lot.

-- Jamie
