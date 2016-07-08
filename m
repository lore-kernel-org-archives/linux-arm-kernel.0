From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 8 Jul 2016 10:46:39 +0200
Subject: [PATCH 0/9] mm: Hardened usercopy
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Message-ID: <20160708084639.GA4562@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> - I couldn't detect a measurable performance change with these features
>   enabled. Kernel build times were unchanged, hackbench was unchanged,
>   etc. I think we could flip this to "on by default" at some point.

Could you please try to find some syscall workload that does many small user 
copies and thus excercises this code path aggressively?

If that measurement works out fine then I'd prefer to enable these security checks 
by default.

Thaks,

	Ingo
