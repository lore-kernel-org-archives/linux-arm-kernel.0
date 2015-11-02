From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Nov 2015 18:28:37 +0000
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <20151102132608.59e16994@gandalf.local.home>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
 <20151029150922.GE3440@arm.com> <5633077C.3050000@huawei.com>
 <20151102132608.59e16994@gandalf.local.home>
Message-ID: <20151102182836.GM29657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 01:26:08PM -0500, Steven Rostedt wrote:
> On Fri, 30 Oct 2015 14:00:28 +0800
> libin <huawei.libin@huawei.com> wrote:
> 
> > It is a bug in nop_mcount:
> > ...
> > if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> >         if (make_nop) {
> >                 ret = make_nop((void *)ehdr, shdr->sh_offset + relp->r_offset);
> >         }
> > ...
> > 
> > shdr->sh_offset and welp->r_offset should handle endianness properly as _w(shdr->sh_offset)/
> > _w(relp->r_offset). I will post a patchset including this patch soon.
> > 
> 
> Has this been fixed yet?

  http://lkml.kernel.org/r/1446193864-24593-1-git-send-email-huawei.libin at huawei.com

I see you're playing "chase the patches" at the moment ;)

Will
