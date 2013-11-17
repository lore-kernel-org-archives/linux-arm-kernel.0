From: rob@landley.net (Rob Landley)
Date: Sun, 17 Nov 2013 12:50:21 -0600
Subject: [PATCH] Documentation/Changes: update binutils version
 requirement for ARMv7 builds
In-Reply-To: <alpine.DEB.2.02.1310300923080.12006@tamien> (from
 pwalmsley@nvidia.com on Wed Oct 30 11:27:07 2013)
Message-ID: <1384714221.1974.276@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 11:27:07 AM, Paul Walmsley wrote:
> 
> ARMv7 builds now make use of the pldw opcode and the ".arch_extension  
> mp"
> pragma.  These aren't supported in binutils prior to 2.21.  So, update
> Documentation/Changes accordingly.

ARMv7 support didn't _exist_ in the minimal binutils version, and ARMv8  
support is newer still. Hexagon, microblaze, they've all shown up in  
newer versions than the one that will build older architectures.

Annotating the global Documentation/Changes with every per-arch  
requirement... not sure that's the right place for it.

I also note that the FSF's toolchain seems to be losing steam again,  
and this time around EGCS is called LLVM. Now that http://ellcc.org is  
self-hosting (and can even build native toolchains as of  
http://ellcc.org/blog/?p=251) all they need is http://lld.llvm.org to  
catch up and I think they've got a complete non-gnu toolchain capable  
of building a linux system. (It already contains musl-libc.org, I'm  
banging on toybox to provide a public domain busybox replacement...)

So there are larger issues in motion here. Noting armv7 requirements in  
an arm-specific file makes sense. Annotating the top level one raises  
the question of why not to do that for arc, unicore, openrisc, tile...

Rob
