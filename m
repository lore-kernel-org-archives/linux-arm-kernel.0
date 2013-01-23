From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 23 Jan 2013 11:49:16 +0100
Subject: [PATCH] clk: Add axi-clkgen driver
In-Reply-To: <20130123102755.GP23505@n2100.arm.linux.org.uk>
References: <1357755120-32735-1-git-send-email-lars@metafoo.de>
 <20130122175552.24671.27893@quantum> <50FFB4D8.5060801@metafoo.de>
 <20130123102755.GP23505@n2100.arm.linux.org.uk>
Message-ID: <50FFC02C.9000109@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 11:27 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 23, 2013 at 11:00:56AM +0100, Lars-Peter Clausen wrote:
>> I think I read somewhere at some point that ioread{8,16,32} is preferred
>> over write{b,h,l} in new code.
> 
> But... there's *no* point using ioread*() if you don't only use the
> ioremap() interface.
> 
> ioread*() is there to allow PC IO and PC MMIO accesses through one
> accessor depending on the cookie.  ioremap() only ever returns cookies
> for MMIO accesses.

So your point is, if you know that it is MMIO memory only ever use readl and
friends?

- Lars
