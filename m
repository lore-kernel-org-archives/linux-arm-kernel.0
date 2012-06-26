From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2012 17:28:02 +0100
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <4FE9DC95.30408@gmail.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
 <4FE8DA7E.5040105@codeaurora.org>
 <20120626104944.GE27996@mudshark.cambridge.arm.com>
 <20120626155448.GQ27996@mudshark.cambridge.arm.com>
 <4FE9DC95.30408@gmail.com>
Message-ID: <20120626162802.GS27996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 05:00:21PM +0100, Rob Herring wrote:
> On 06/26/2012 10:54 AM, Will Deacon wrote:
> > The reason this is slightly problematic is due to gas's inability to
> > represent unsigned constants -- namely that the 'U' suffix causes it to
> > barf. I can fix it with the diff below, but please let me know what you
> > think.
> 
> [snip]
> 
> > +#ifndef __ASSEMBLY__
> > +
> 
> 
> > +#define UDELAY_MULT_HZ	2199023U
> > +#else
> > +#define UDELAY_MULT_HZ	2199023
> 
> Doesn't UL() macro do what you need?

Indeed, thanks for pointing that out as I'd failed to spot it.
I'll include this change for v2.

Will
