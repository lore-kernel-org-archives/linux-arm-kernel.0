From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 15:39:46 +0000
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349796958.21847.219.camel@zakaz.uk.xensource.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
 <1349796958.21847.219.camel@zakaz.uk.xensource.com>
Message-ID: <201210091539.46274.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Ian Campbell wrote:
> > * The tmem hypercall is not available on ARM
> > 
> > * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> 
> missing the end of this sentence?

Right, I meant to say 

* ARMv6 does not support cmpxchg on 16-bit words that are used in the
  Xen grant table code, so we must ensure that Xen support is only built
  on ARMv7-only kernels not combined ARMv6/v7 kernels.

This should be fixed differently in the future.

	Arnd
