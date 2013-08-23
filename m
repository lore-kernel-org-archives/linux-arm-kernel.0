From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Aug 2013 10:15:37 +0100
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if
 UP system
In-Reply-To: <alpine.LFD.2.03.1308230049230.14472@syhkavp.arg>
References: <20130712121023.GB27430@codeaurora.org>
 <51E71249.4050200@codeaurora.org>
 <alpine.LFD.2.03.1307171830170.14924@syhkavp.arg>
 <51E71C78.6080604@codeaurora.org>
 <alpine.LFD.2.03.1307171849180.14924@syhkavp.arg>
 <51E7236D.3010700@codeaurora.org> <20130822184312.GE23960@codeaurora.org>
 <alpine.LFD.2.03.1308221458320.14472@syhkavp.arg>
 <20130823043527.GG23960@codeaurora.org>
 <alpine.LFD.2.03.1308230049230.14472@syhkavp.arg>
Message-ID: <20130823091537.GL6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 12:51:59AM -0400, Nicolas Pitre wrote:
> Blah.  OK then, just send it to Thomas.
> 
> Initially this code was written and committed by RMK which is why I 
> suggested you send him the fix.

It _should_, because the author of the file presumably knows how the
driver is supposed to work much better than the maintainer of the
subsystem.  So driver authors _should_ always be involved in the
handling of the patch.

Unfortunately, that rarely happens, and I've given up any hope of the
old kernel process(es) remaining where authors were responsible for the
code they wrote.  Somehow, kernel maintanence has been perversed so that
subsystem maintainers get to decide whether patches to drivers that they
don't have hardware for are to be applied irrespective of whether the
driver author has any input to it.
