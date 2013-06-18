From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jun 2013 14:13:19 +0100
Subject: [PATCH] perf: ARM: Record the user-mode PC in the call chain.
In-Reply-To: <20130613232111.GA12536@mozilla.com>
References: <20130613232111.GA12536@mozilla.com>
Message-ID: <20130618131319.GC6801@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 12:21:11AM +0100, Jed Davis wrote:
> With this change, we no longer lose the innermost entry in the user-mode
> part of the call chain.  See also the x86 port, which includes the ip.
> 
> It's possible to partially work around this problem by post-processing
> the data to use the PERF_SAMPLE_IP value, but this works only if the CPU
> wasn't in the kernel when the sample was taken.

Thanks. I guess we need something similar for arm64 too. Could you cook a
similar patch please?

Will
