From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 15 Feb 2016 12:47:46 -0500
Subject: [PATCH] branch tracer: fix freak link error
In-Reply-To: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
References: <1455312410-1058841-1-git-send-email-arnd@arndb.de>
Message-ID: <20160215124746.44e8c2d0@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Feb 2016 22:26:42 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> In my randconfig tests, I came across a bug that involves several
> components:
> 
>

[..]

> 
> This patch avoids the problem by changing __trace_if() to check
> whether the condition is known at compile-time to be nonzero, rather
> than checking whether it is actually a constant.
> 
> I see this one link error in roughly one out of 1600 randconfig builds
> on ARM, and the patch fixes all known instances.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ab3c9c686e22 ("branch tracer, intel-iommu: fix build with CONFIG_BRANCH_TRACER=y")

Want me to pull this into my queue? I have another patch I need to send
to Linus and I can add this in that pull request.

-- Steve
