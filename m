From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Oct 2013 12:47:58 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382614439.6040.16.camel@sakura.staff.proxad.net>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com> <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
Message-ID: <1382615278.8522.72.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-24 at 13:33 +0200, Maxime Bizon wrote:
> 
> ok then how do we solve that case:
> 
>  - Marvell SOC 1 is mainlined
>  - Marvell SOC 2 is mainlined
>  - Marvell SOC 'x' is mainlined
>  - "PIO" hw crypto driver is written, working for all SOCs
>  - [1 year]
>  - SOCs bindings are marked as stable
>  - [1 year]
>  - someone rewrite the driver of hw crypto to use DMA, existing binding
> is not ok because clock 'foo' or interrupt 'bar', now required, are not
> present.
> 
> what is the process merge that driver ?
> 
> if the answer is that you need to keep PIO mode in driver so that
> existing DTBs still works with it, then this is just plain *wrong*.

If you can automatically infer the correct clock/interrupt/etc in order
to do DMA correctly, despite the fact that it wasn't explicitly spelled
out in the old DT, then the property is *not* a "required" property.
It's optional, and you have a default behaviour for when it's not
present.

(And if you *can't* automatically infer that or otherwise get away
without it, then you're asking for the impossible, surely?)

The default behaviour in the absence of these properties may be
horrendously complex, and it may be defined only for SOC [1..x] and not
newer versions; it may be *mandatory* for SOC x+1. 

But if you really want the new driver to do DMA on platforms even where
this information wasn't originally provided by the DT, what option do
you have?

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/aefaa3eb/attachment.bin>
