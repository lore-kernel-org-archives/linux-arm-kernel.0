From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jan 2015 09:59:19 +0000
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <20150115070730.GA23621@pek-khao-d1.corp.ad.wrs.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <3138622.1rQcFu1jAj@wuerfel> <20150114114827.GH4050@arm.com>
 <2438951.7KFuXx85Hp@wuerfel>
 <CAKv+Gu-E=0Fm7woFSWcdBLfmxB+5diGtO91c2zy-t2M1_NTNeg@mail.gmail.com>
 <20150114133742.GI4050@arm.com>
 <20150115070730.GA23621@pek-khao-d1.corp.ad.wrs.com>
Message-ID: <20150115095918.GA23475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 07:07:30AM +0000, Kevin Hao wrote:
> On Wed, Jan 14, 2015 at 01:37:42PM +0000, Will Deacon wrote:
> > On Wed, Jan 14, 2015 at 12:52:49PM +0000, Ard Biesheuvel wrote:
> > > IMO libgcc.a cannot be used at all in the kernel, as it is not built
> > > with -mgeneral-regs-only so we have no guarantee that it will leave
> > > the NEON registers alone.
> > 
> > That's a very good point. In which case, we'd need to extend this patch
> > to implement the bitops that we currently rely on the __builtins for.
> 
> Sorry, I am not sure I get what you mean. These builtin functions for bitops
> are not implemented in the libgcc, they are inlined in compiler. So why do
> we need to reimplement these bitops when removing the link with libgcc?

I'm just relaying what the tools guys told us. Namely, that they don't
guarantee that they are inlined and could generate a branch to a libgcc
function. As Ard says, they could also use fpsimd registers, so whether
or not they are inlined is moot anyway.

Will
