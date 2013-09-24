From: rob@landley.net (Rob Landley)
Date: Tue, 24 Sep 2013 16:23:48 -0500
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <yw1xpprywhad.fsf@unicorn.mansr.com> (from mans@mansr.com on
 Tue Sep 24 07:11:38 2013)
Message-ID: <1380057828.1974.73@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 07:11:38 AM, M?ns Rullg?rd wrote:
> Rob Landley <rob@landley.net> writes:
> 
> > On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
> >> During 3.12-rc, Will Deacon introduced code into arch/arm that
> >> requires binutils 2.22.
> >
> > Um, my toolchain is using the last gplv2 snapshot of binutils out of
> > git, which is just past 2.17 and can build armv7 (but not armv8).
> >
> > Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some
> > thought to have gone into that? Possibly a mention of it?
> 
> I seriously doubt that 2.12 still works at all (I doubt it can even be
> built on a modern system).  In my experience, binutils older than 2.19
> or so rarely works properly for ARM.

I've been building every kernel release with 2.17 for several years, on  
a bunch of different architectures. Toolchain releases after that are  
GPLv3* and I can't distribute those binaries, so I can't ship prebuilt  
binary toolchains.

(Lots of other people produce cross compilers, but nobody else seems to  
produce prebuilt statically linked _native_ compilers. It would be nice  
if they did.)

> What value is there in maintaining compatibility with a truly ancient
> binutils version anyway?

What value is there in requiring the new toolchain? From what I could  
see of the commits it was micro-optimizations around memory barriers.

*shrug* I can revert the patch locally, or patch the extra instruction  
into my toolchain. But I do object to changing the documentation  
globally for every architecture because one architecture did something  
they apparently never thought through (or they'd have commented in the  
commit that it requires a big toolchain version jump; pretty sure they  
didn't actually notice).

Rob

* The Free Software Foundation got so pissed that MacOS X and BSD and  
such were sticking with the last GPLv2 release of binutils that they  
deleted the binutils tarball off their website and replaced it with one  
including GPLv3 source code. Check the FTP site if you don't believe  
me. Some of us have it snapshotted though. In my case, I actually  
fished the last GPLv2 version out of source control, right before the  
license change was committed, because I wanted armv7 support.
