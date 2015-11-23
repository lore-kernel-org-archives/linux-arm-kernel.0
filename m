From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 13:16:53 -0800
Subject: [RFC/PATCH 3/3] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <yw1x1tbgsag7.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-4-git-send-email-sboyd@codeaurora.org>
 <yw1xd1v3d117.fsf@unicorn.mansr.com>
 <20151123204955.GC19156@codeaurora.org>
 <yw1x1tbgsag7.fsf@unicorn.mansr.com>
Message-ID: <20151123211653.GF19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, M?ns Rullg?rd wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
> 
> > On 11/21, M?ns Rullg?rd wrote:
> >> 
> >> These functions are rather similar.  Perhaps they could be combined
> >> somehow.
> >> 
> >
> > Yes. I have this patch on top, just haven't folded it in because
> > it doesn't reduce the lines of code.
> 
> I don't see any reason to split it anyhow.  The end result isn't any
> harder to understand than the intermediate.

Yep.

> 
> > ----8<----
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > Subject: [PATCH] consolidate with module code
> >
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  arch/arm/include/asm/setup.h |  3 +++
> >  arch/arm/kernel/module.c     | 16 +++++--------
> >  arch/arm/kernel/setup.c      | 54 +++++++++++++++++++++++++++-----------------
> >  3 files changed, 42 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> > index e0adb9f1bf94..3f251cdb94ef 100644
> > --- a/arch/arm/include/asm/setup.h
> > +++ b/arch/arm/include/asm/setup.h
> > @@ -25,4 +25,7 @@ extern int arm_add_memory(u64 start, u64 size);
> >  extern void early_print(const char *str, ...);
> >  extern void dump_machine_table(void);
> >
> > +extern void patch_uidiv(void *addr, size_t size);
> > +extern void patch_idiv(void *addr, size_t size);
> 
> Why not call things sdiv and udiv like the actual instructions?
> 

Sure. I'll fold this into v2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
