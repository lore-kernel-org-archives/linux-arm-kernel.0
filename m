From: jld@mozilla.com (Jed Davis)
Date: Wed, 19 Jun 2013 20:17:06 -0700
Subject: [PATCH] perf: ARM: Record the user-mode PC in the call chain.
In-Reply-To: <20130618131319.GC6801@mudshark.cambridge.arm.com>
References: <20130613232111.GA12536@mozilla.com>
 <20130618131319.GC6801@mudshark.cambridge.arm.com>
Message-ID: <20130620031706.GB27428@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:13:19PM +0100, Will Deacon wrote:
> On Fri, Jun 14, 2013 at 12:21:11AM +0100, Jed Davis wrote:
> > With this change, we no longer lose the innermost entry in the user-mode
> > part of the call chain.  See also the x86 port, which includes the ip.
> > 
> > It's possible to partially work around this problem by post-processing
> > the data to use the PERF_SAMPLE_IP value, but this works only if the CPU
> > wasn't in the kernel when the sample was taken.
> 
> Thanks. I guess we need something similar for arm64 too. Could you cook a
> similar patch please?

Done (and tested, on the ARM V8 Foundation Model).

It looked as if the powerpc and sparc ports might have similar issues,
but I haven't checked on them yet.

--Jed
