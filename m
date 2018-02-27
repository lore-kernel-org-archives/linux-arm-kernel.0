From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Feb 2018 19:59:19 +0000
Subject: =?utf-8?B?562U5aSNOiBbUkZDIHBhdGNoXSBp?= =?utf-8?Q?oremap?=
 =?utf-8?Q?=3A?= don't set up huge I/O mappings when p4d/pud/pmd is zero
In-Reply-To: <1519763686.2693.2.camel@hpe.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
 <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
 <1519175992.16384.121.camel@hpe.com>
 <etPan.5a8d2180.1dbfd272.49b8@localhost>
 <20180221115758.GA7614@arm.com>
 <32c9b1c3-086b-ba54-f9e9-aefa50066730@huawei.com>
 <20180226110422.GD8736@arm.com>
 <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
 <1519763686.2693.2.camel@hpe.com>
Message-ID: <20180227195919.GA5348@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 07:49:42PM +0000, Kani, Toshi wrote:
> On Mon, 2018-02-26 at 20:53 +0800, Hanjun Guo wrote:
> > On 2018/2/26 19:04, Will Deacon wrote:
> > > On Mon, Feb 26, 2018 at 06:57:20PM +0800, Hanjun Guo wrote:
> > > > Simply do something below at now (before the broken code is fixed)?
> > > > 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index b2b95f7..a86148c 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -84,7 +84,6 @@ config ARM64
> > > >         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> > > >         select HAVE_ARCH_AUDITSYSCALL
> > > >         select HAVE_ARCH_BITREVERSE
> > > > -   select HAVE_ARCH_HUGE_VMAP
> > > >         select HAVE_ARCH_JUMP_LABEL
> > > >         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > > >         select HAVE_ARCH_KGDB
> > > 
> > > No, that actually breaks with the use of block mappings for the kernel
> > > text. Anyway, see:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15122ee2c515a253b0c66a3e618bc7ebe35105eb
> > 
> > Sorry, just back from holidays and didn't catch up with all the emails,
> > thanks for taking care of this.
> 
> I will work on a fix for the common/x86 code.

Ace, thanks. I'm more than happy to review any changes you make to the core
code from a break-before-make perspective. Just stick me on cc.

Cheers,

Will
