From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 2 Nov 2015 13:26:08 -0500
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <5633077C.3050000@huawei.com>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
 <20151029150922.GE3440@arm.com> <5633077C.3050000@huawei.com>
Message-ID: <20151102132608.59e16994@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Oct 2015 14:00:28 +0800
libin <huawei.libin@huawei.com> wrote:

> It is a bug in nop_mcount:
> ...
> if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
>         if (make_nop) {
>                 ret = make_nop((void *)ehdr, shdr->sh_offset + relp->r_offset);
>         }
> ...
> 
> shdr->sh_offset and welp->r_offset should handle endianness properly as _w(shdr->sh_offset)/
> _w(relp->r_offset). I will post a patchset including this patch soon.
> 

Has this been fixed yet?

-- Steve
