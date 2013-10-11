From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 09:11:17 -0700
Subject: [PATCH V6 02/15] ARM: OMAP2+: AM33XX: add lateinit hook for
 calling pm late init
In-Reply-To: <5256C686.6000301@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com>
 <52563BD8.1060703@ti.com> <20131010133209.GA13105@kahuna>
 <5256C5D2.9030302@ti.com> <5256C686.6000301@ti.com>
Message-ID: <20131011161116.GS29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [131010 08:31]:
> On 10/10/2013 10:20 AM, Joel Fernandes wrote:
> > 
> > Adding 6 lines of identical code for every platform seems redundant, I'd just
> > define an omap_common_late_init for all platforms for now, and then fork off for
> > the future differences. That way we save on LOC and readability in the header as
> > well. Your call.
> 
> I see a function of that name already exists. I guess you can leave your patch
> as is then and not have to do this.

Yeah but why not just call the common late_init function directly for the
cases where we know it's never needed.

If thoses will be populated in the later patches, then it's OK to add them.

In any case, Nishant, can you please squash the late_init patches into a
single patch and make sure it also applies on top of the omap-for-v3.13/quirk
branch as there's been some changes to board-generic.c there.

Regards,

Tony
