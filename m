From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 18 Nov 2013 12:06:18 -0800
Subject: [PATCH] Documentation/Changes: update binutils version requirement
 for ARMv7 builds
In-Reply-To: <1384714221.1974.276@driftwood>
References: <1384714221.1974.276@driftwood>
Message-ID: <528A733A.6040304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 11/17/2013 10:50 AM, Rob Landley wrote:
> On 10/30/2013 11:27:07 AM, Paul Walmsley wrote:
>> ARMv7 builds now make use of the pldw opcode and the ".arch_extension
>> mp"
>> pragma.  These aren't supported in binutils prior to 2.21.  So, update
>> Documentation/Changes accordingly.
> Annotating the global Documentation/Changes with every per-arch
> requirement... not sure that's the right place for it.

It doesn't matter to me where it's documented in the kernel 
documentation, but we should document it.

And we should expect folks who post patches with new toolchain 
constraints to also send patches for that documentation...

> Noting armv7 requirements in
> an arm-specific file makes sense. Annotating the top level one raises
> the question of why not to do that for arc, unicore, openrisc, tile...

Yes - it's the following x86-specific text in Documentation/Changes that 
inspired the patch:

-----
Linux on IA-32 has recently switched from using as86 to using gas for
assembling the 16-bit boot code, removing the need for as86 to compile
your kernel.  This change does, however, mean that you need a recent
release of binutils.
-----

But we can move that to Documentation/x86/ also.


regards,

- Paul
