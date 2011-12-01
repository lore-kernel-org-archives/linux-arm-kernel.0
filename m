From: tixy@yxit.co.uk (Tixy)
Date: Thu, 01 Dec 2011 07:40:55 +0000
Subject: [PATCH] ARM: kprobes: Restrict probing SWP instructions to
 ARMv5 and below
In-Reply-To: <20111130235618.GX9581@n2100.arm.linux.org.uk>
References: <1322396080.2408.5.camel@computer2>
 <20111130235618.GX9581@n2100.arm.linux.org.uk>
Message-ID: <1322725255.2352.8.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 23:56 +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 27, 2011 at 12:14:40PM +0000, Tixy wrote:
> > The SWP instruction is deprecated on ARMv6 and with ARMv7 it will be
> > UNDEFINED when CONFIG_SWP_EMULATE is selected. In this case, probing a
> > SWP instruction will cause an oops when the kprobes emulation code
> > executes an undefined instruction.
> > 
> > As the SWP instruction should be rare or non-existent in kernels for
> > ARMv6 and later, we can simply avoid these problems by not allowing
> > probing of these.
> 
> Is this something for -stable stuff?

It affects 3.1, though in practice I doubt there are any SWP
instructions to probe in an ARMv7 kernel with CONFIG_SWP_EMULATE
enabled. It was only the test code, added to 3.2, that tested the
emulation of SWP instructions and showed up the problem.

-- 
Tixy
