From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 9 Oct 2012 17:10:35 +0100
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <201210091539.46274.arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
 <1349796958.21847.219.camel@zakaz.uk.xensource.com>
 <201210091539.46274.arnd@arndb.de>
Message-ID: <1349799035.21847.222.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-09 at 16:39 +0100, Arnd Bergmann wrote:
> On Tuesday 09 October 2012, Ian Campbell wrote:
> > > * The tmem hypercall is not available on ARM
> > > 
> > > * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> > 
> > missing the end of this sentence?
> 
> Right, I meant to say 
> 
> * ARMv6 does not support cmpxchg on 16-bit words that are used in the
>   Xen grant table code, so we must ensure that Xen support is only built
>   on ARMv7-only kernels not combined ARMv6/v7 kernels.
> 
> This should be fixed differently in the future.

Is this is a build time failure because gcc/gas/etc refuses to generate
these instructions if it is configured for v6?

I ask because if it is only a runtime issue then we can reason that if
we are running Xen specific grant table code, then we must be running on
Xen and therefore must necessarily be running on a v7 (because Xen only
support v7+virt extensions) even if the kernel happens to be capable of
running on v6 too.

Ian.
