From: rob@landley.net (Rob Landley)
Date: Wed, 04 Dec 2013 20:26:31 -0600
Subject: [PATCH] Documentation/Changes: update binutils version
 requirement for ARMv7 builds
In-Reply-To: <528A46C7.6090303@wwwdotorg.org> (from swarren@wwwdotorg.org on
 Mon Nov 18 10:56:39 2013)
Message-ID: <1386210391.1974.313@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 10:56:39 AM, Stephen Warren wrote:
> On 11/17/2013 11:50 AM, Rob Landley wrote:
> > On 10/30/2013 11:27:07 AM, Paul Walmsley wrote:
> >>
> >> ARMv7 builds now make use of the pldw opcode and the  
> ".arch_extension mp"
> >> pragma.  These aren't supported in binutils prior to 2.21.  So,  
> update
> >> Documentation/Changes accordingly.
> >
> > ARMv7 support didn't _exist_ in the minimal binutils version, and  
> ARMv8
> > support is newer still. Hexagon, microblaze, they've all shown up in
> > newer versions than the one that will build older architectures.
> >
> > Annotating the global Documentation/Changes with every per-arch
> > requirement... not sure that's the right place for it.
> ...
> > So there are larger issues in motion here. Noting armv7  
> requirements in
> > an arm-specific file makes sense. Annotating the top level one  
> raises
> > the question of why not to do that for arc, unicore, openrisc,  
> tile...
> 
> Documenting some of the requirements in the top-level file and some  
> in a
> per-arch file seems bad though. If we move the docs to a per-arch  
> file,
> we need to actively remove the top-level documentation since it will
> conflict.

No, you just need to document arch-specific deltas in arch-specific  
files.

You can build Linux with gcc 3.4. There was no ARMv7 support in gcc 3.4  
(let alone 64 bit arm), but that doesn't change the fact that you can  
build Linux with it. Which is why it says "Upgrade to at *least* these  
software revisions".

If you're going to build Linux with llvm, you'll need a different  
version. If pcc manages to build linux (development of that's stalled  
but not stopped), then there's another one. If tinycc restarts...

> What's wrong with a single table in the top-level document?

So we haven't needed one for 20 years now, but your target is special?

The minimal requirements are the versions needed to build Linux at all,  
on any target, because there are generic features missing in earlier  
versions. Building Linux for a specific target often has more specific  
requirements.

> The answer to missing requirements for the other arch seems to be to
> encourage the relevant maintainers to document them, not too disallow
> the ARM requirements to be documented there.

There's a Documentation/arm directory but arm-specific documentation  
can't go there, it has to go at the top level even though other  
architectures haven't previously done this. The alternative is that any  
global documentation that does NOT apply to arm must be deleted to  
avoid confusing arm.

Is this really your position?

One of the 8 gazillion todo items I have queued up is moving  
Documentation/zorro.txt to the Documentation/m68k directory. That's not  
the same as deleting the file because its existence might confuse ARM  
developers. I honestly think most of them are smarter than that.

Rob
