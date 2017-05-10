From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 May 2017 09:38:03 +0100
Subject: [PATCH v3 3/3] arm64: Silence first allocation with
 CONFIG_ARM64_MODULE_PLTS=y
In-Reply-To: <20170508100723.GF8526@arm.com>
References: <20170427181902.28829-1-f.fainelli@gmail.com>
 <20170427181902.28829-4-f.fainelli@gmail.com>
 <20170503111814.GF8233@arm.com>
 <3af577ca-8f01-7a1c-997c-4c04914b4633@gmail.com>
 <20170508100723.GF8526@arm.com>
Message-ID: <20170510083803.ur44myyb35lqcuw7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 11:07:24AM +0100, Will Deacon wrote:
> On Fri, May 05, 2017 at 02:07:28PM -0700, Florian Fainelli wrote:
> > On 05/03/2017 04:18 AM, Will Deacon wrote:
> > > On Thu, Apr 27, 2017 at 11:19:02AM -0700, Florian Fainelli wrote:
> > >> When CONFIG_ARM64_MODULE_PLTS is enabled, the first allocation using the
> > >> module space fails, because the module is too big, and then the module
> > >> allocation is attempted from vmalloc space. Silence the first allocation
> > >> failure in that case by setting __GFP_NOWARN.
> > >>
> > >> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > >> ---
> > >>  arch/arm64/kernel/module.c | 7 ++++++-
> > >>  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > I'm not sure what the merge plan is for these, but the arm64 bit here
> > > looks fine to me:
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thanks, not sure either, would you or Catalin want to pick this series?
> 
> We'd need an Ack from Russell on the arch/arm/ part before we could take
> this series.

The first patch touches mm/vmalloc.c, so we could also merge the series
via akpm's tree. Andrew, do you have any preference?

-- 
Catalin
