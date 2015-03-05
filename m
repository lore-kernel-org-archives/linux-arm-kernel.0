From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 5 Mar 2015 13:47:33 +0000
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <54F8582B.80703@marvell.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
 <54F6EF32.7080306@marvell.com>
 <20150304143527.GA5653@e103592.cambridge.arm.com>
 <54F732DA.2050004@marvell.com>
 <20150305122606.GC3612@e103592.cambridge.arm.com>
 <54F8582B.80703@marvell.com>
Message-ID: <20150305134733.GE3612@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 02:20:43PM +0100, Lino Sanfilippo wrote:
> On 05.03.2015 13:26, Dave Martin wrote:
> 
> >>
> >>So this is indeed a compiler bug, right?
> >
> >It certainly looks like the compiler is causing the issue somehow.
> >
> >Whether this is a bug, a bug-like feature, a configuration issue,
> >or a combination of these is not clear.
> >
> >If you know where to find the toolchain source, it might be worth
> >taking a look.
> 
> The toolchain can be found here:
> http://www.plugcomputer.org/405/us/gplugd/tool-chain/arm-marvell-linux-gnueabi.tar.bz2

Source code?  That just looks like binaries to me.

> But since it turns out to be a compiler issue I dont know if its
> worth to be investigated further. I think the best solution to avoid
> that structure alignment problem is to simply use another toolchain.

Maybe not.  Could be worth revisiting if other people report the
same problem -- a build-time check that 

> Dave, I thank you very much for your help and efforts to clarify
> that this is actually not a bug in the kernel.

No probs.  I have wondered whether it's really valid to assume
that the linker can paste sections from different objects into a valid
array like this.

There are other things that already work this way though -- such
as the way .init_array/.fini_array are created when building
a shared library.

Cheers
---Dave
