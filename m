From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 10:07:29 +0100
Subject: [PATCH] perf: ARM: Record the user-mode PC in the call chain.
In-Reply-To: <20130620031706.GB27428@mozilla.com>
References: <20130613232111.GA12536@mozilla.com>
 <20130618131319.GC6801@mudshark.cambridge.arm.com>
 <20130620031706.GB27428@mozilla.com>
Message-ID: <20130620090728.GA2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 04:17:06AM +0100, Jed Davis wrote:
> On Tue, Jun 18, 2013 at 02:13:19PM +0100, Will Deacon wrote:
> > On Fri, Jun 14, 2013 at 12:21:11AM +0100, Jed Davis wrote:
> > > With this change, we no longer lose the innermost entry in the user-mode
> > > part of the call chain.  See also the x86 port, which includes the ip.
> > > 
> > > It's possible to partially work around this problem by post-processing
> > > the data to use the PERF_SAMPLE_IP value, but this works only if the CPU
> > > wasn't in the kernel when the sample was taken.
> > 
> > Thanks. I guess we need something similar for arm64 too. Could you cook a
> > similar patch please?
> 
> Done (and tested, on the ARM V8 Foundation Model).

Wow, I didn't expect you to test it. Thanks!

> It looked as if the powerpc and sparc ports might have similar issues,
> but I haven't checked on them yet.

I can extract some hardware from the pile in the corner of my flat if you
want a hand with testing.

Will
