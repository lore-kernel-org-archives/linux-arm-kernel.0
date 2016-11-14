From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Nov 2016 18:19:38 +0000
Subject: [PATCHv2 5/6] arm64: Use __pa_symbol for _end
In-Reply-To: <20161103155106.GF25852@remoulade>
References: <20161102210054.16621-1-labbott@redhat.com>
 <20161102210054.16621-6-labbott@redhat.com>
 <20161102225241.GA19591@remoulade>
 <3724ea58-3c04-1248-8359-e2927da03aaf@redhat.com>
 <20161103155106.GF25852@remoulade>
Message-ID: <20161114181937.GG3096@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:51:07PM +0000, Mark Rutland wrote:
> On Wed, Nov 02, 2016 at 05:56:42PM -0600, Laura Abbott wrote:
> > On 11/02/2016 04:52 PM, Mark Rutland wrote:
> > >On Wed, Nov 02, 2016 at 03:00:53PM -0600, Laura Abbott wrote:
> > >>
> > >>__pa_symbol is technically the marco that should be used for kernel
> > >>symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL.
> > >
> > >Nit: s/marco/macro/
> > >
> > >I see there are some other uses of __pa() that look like they could/should be
> > >__pa_symbol(), e.g. in mark_rodata_ro().
> > >
> > >I guess strictly speaking those need to be updated to? Or is there a reason
> > >that we should not?
> > 
> > If the concept of __pa_symbol is okay then yes I think all uses of __pa
> > should eventually be converted for consistency and debugging.
> 
> I have no strong feelings either way about __pa_symbol(); I'm not clear on what
> the purpose of __pa_symbol() is specifically, but I'm happy even if it's just
> for consistency with other architectures.

At a quick grep, it seems to only be used by mips and x86 and a single
place in mm/memblock.c.

Since we haven't seen any issues on arm/arm64 without this macro, can we
not just continue to use __pa()?

Thanks.

-- 
Catalin
