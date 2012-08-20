From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Aug 2012 10:07:54 +0100
Subject: [PATCH v2 23/31] arm64: Debugging support
In-Reply-To: <201208170706.07821.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <20120816104748.GI31784@mudshark.cambridge.arm.com>
 <201208161249.35008.arnd@arndb.de>
 <201208170706.07821.arnd@arndb.de>
Message-ID: <20120820090754.GB25864@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 08:06:07AM +0100, Arnd Bergmann wrote:
> Sorry for the dumb question, but why do you even need PTRACE_GET_THREAD_AREA
> for 64 bit tasks? I thought the thread pointer is a GPR, or is this just
> for compat tasks?

The TLS is stored in a co-processor register which is read-only for
userspace. However, it's banked, so accessing the TLS of your child (the guy
you're ptracing) requires a system call.

Will
