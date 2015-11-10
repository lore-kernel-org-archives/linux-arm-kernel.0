From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Tue, 10 Nov 2015 08:41:24 +0100
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <20151106162109.GT6087@arm.com>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
 <20151106160501.GR6087@arm.com>
 <247F438B-3EEA-4550-970E-A649D0E604ED@gmail.com>
 <20151106162109.GT6087@arm.com>
Message-ID: <20151110074124.GB6672@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:21:10PM +0000, Will Deacon wrote:
> On Sat, Nov 07, 2015 at 12:11:16AM +0800, yalin wang wrote:
> > i just enable it on ARM64,
> > and it can work,
> > i don?t see some special requirement to enable this config .
> 
> Right, so why does HAVE_LATENCYTOP_SUPPORT exist?

If I remember correctly then the only dependency was that an architecture
must have implemented save_stack_trace_tsk().
See git commit a3afe70b83fdbbd4d757d2911900d168bc798a31.

So the name of HAVE_LATENCYTOP_SUPPORT is surely a not well chosen, and I
think I introduced it back then. Oh, well.

And looking through the kernel there is at least avr32 which would break
at build time if the config option would be removed completely.

So.. renaming it to STACKTRACE_TSK_SUPPORT would be a good idea.

Will do when time permits, unless somebody else volunteers.
