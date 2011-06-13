From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jun 2011 15:10:13 +0100
Subject: [Patch v2 03/11] ARM: hwcaps: use shifts instead of hardcoded
	constants
In-Reply-To: <4DF616C4.4040709@ru.mvista.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
	<1307536233-30089-4-git-send-email-will.deacon@arm.com>
	<4DF616C4.4040709@ru.mvista.com>
Message-ID: <20110613141013.GA419@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Mon, Jun 13, 2011 at 02:55:16PM +0100, Sergei Shtylyov wrote:
> Hello.
> 
> On 08-06-2011 16:30, Will Deacon wrote:
> 
> > The HWCAP numbers are defined as constants, each one being a power of 2.
> > This has become slightly unwieldy now that we have reached 32k.
> 
> > This patch changes the HWCAP defines to use (1<<  n) instead of coding
> > the constant directly. The values remain unchanged.
> 
>     Perhaps it's better to use BIT(n) macro instead?

That has the downside of breaking userspace, unless we export linux/bitops.h
and remove the __KERNEL__ guards around the BIT macro.

Will
