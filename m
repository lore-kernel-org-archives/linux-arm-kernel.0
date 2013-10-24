From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Oct 2013 09:55:26 +0100
Subject: [PATCH] Simple NX lowmem mappings
In-Reply-To: <20131024084502.GT4994@outflux.net>
References: <20131024071258.GB16735@n2100.arm.linux.org.uk>
 <20131024084502.GT4994@outflux.net>
Message-ID: <20131024085525.GE16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 01:45:02AM -0700, Kees Cook wrote:
> Hi,
> 
> Thanks for starting this work!
> 
> Russel said:
> > -#define MT_MEMORY      9
> > [...]
> > + MT_MEMORY,
> > + MT_MEMORY_NX,
> 
> Instead of these names, let's more fully describe the protections. "NX"
> doesn't say anything about RO vs RW. Instead, how about:
> 
> MT_MEMORY_RWX (to replace MT_MEMORY)
> MT_MEMORY_RW  (as the new "NX" in use for this patch)
> 
> for the first change? Then as we move forward, we can add:
> 
> MT_MEMORY_R
> 
> At which point we'll have the three states.

Yes, we can.  We have a few others which should be changed in the same way.
