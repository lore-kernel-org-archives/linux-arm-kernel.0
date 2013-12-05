From: rob@landley.net (Rob Landley)
Date: Wed, 04 Dec 2013 20:37:08 -0600
Subject: [PATCH] Documentation/Changes: update binutils version
 requirement for ARMv7 builds
In-Reply-To: <528A733A.6040304@nvidia.com> (from pwalmsley@nvidia.com on Mon
 Nov 18 14:06:18 2013)
Message-ID: <1386211028.1974.314@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 02:06:18 PM, Paul Walmsley wrote:
> Hi Rob,
> 
> On 11/17/2013 10:50 AM, Rob Landley wrote:
>> On 10/30/2013 11:27:07 AM, Paul Walmsley wrote:
>>> ARMv7 builds now make use of the pldw opcode and the  
>>> ".arch_extension
>>> mp"
>>> pragma.  These aren't supported in binutils prior to 2.21.  So,  
>>> update
>>> Documentation/Changes accordingly.
>> Annotating the global Documentation/Changes with every per-arch
>> requirement... not sure that's the right place for it.
> 
> It doesn't matter to me where it's documented in the kernel  
> documentation, but we should document it.

Agreed, I'd just rather not add target-specific information to a file  
that currently has target-agnostic information.

A new file under Documentation/arm describing the build requirements  
for that platform would be nice. At some point I want to collate the  
target-specific directories under a Documentation/arch (so  
Documentation/arch/arm and Documentation/arch/m68k and so on, mirroring  
the source layout), but that's unrelated to this.

> And we should expect folks who post patches with new toolchain  
> constraints to also
> send patches for that documentation...

Agreed.

>> Noting armv7 requirements in
>> an arm-specific file makes sense. Annotating the top level one raises
>> the question of why not to do that for arc, unicore, openrisc,  
>> tile...
> 
> Yes - it's the following x86-specific text in Documentation/Changes  
> that inspired
> the patch:
> 
> -----
> Linux on IA-32 has recently switched from using as86 to using gas for
> assembling the 16-bit boot code, removing the need for as86 to compile
> your kernel.  This change does, however, mean that you need a recent
> release of binutils.
> -----

(Sigh, define "recent". Bisection search time, I suppose...)

> But we can move that to Documentation/x86/ also.

Agreed. Also the mcelog stuff looks x86-specific (or at least is  
currently documented as such). Also, I posted patches to remove the  
perl requirement but didn't remove the mention of perl from  
Documentation/Changes. I should fix that.

Also, Documentation/Changes is a weird name for the file describing the  
build environment requirements, but it's sort of grandfathered in at  
this point. That sort of implies I should add a  
Documentation/x86/Changes with the moved material, and the new arm file  
should be Documentation/arm/Changes. I suppose if the 00-INDEX  
clarifies that this describes the build environment requirements...

Which is worse, renaming a top level file that's been there for  
decades, or propagating the inaccurate name into subdirectories? Sigh,  
damned if you do...

Rob
