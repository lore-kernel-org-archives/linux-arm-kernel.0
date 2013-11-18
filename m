From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 09:56:39 -0700
Subject: [PATCH] Documentation/Changes: update binutils version requirement
 for ARMv7 builds
In-Reply-To: <1384714221.1974.276@driftwood>
References: <1384714221.1974.276@driftwood>
Message-ID: <528A46C7.6090303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2013 11:50 AM, Rob Landley wrote:
> On 10/30/2013 11:27:07 AM, Paul Walmsley wrote:
>>
>> ARMv7 builds now make use of the pldw opcode and the ".arch_extension mp"
>> pragma.  These aren't supported in binutils prior to 2.21.  So, update
>> Documentation/Changes accordingly.
> 
> ARMv7 support didn't _exist_ in the minimal binutils version, and ARMv8
> support is newer still. Hexagon, microblaze, they've all shown up in
> newer versions than the one that will build older architectures.
> 
> Annotating the global Documentation/Changes with every per-arch
> requirement... not sure that's the right place for it.
...
> So there are larger issues in motion here. Noting armv7 requirements in
> an arm-specific file makes sense. Annotating the top level one raises
> the question of why not to do that for arc, unicore, openrisc, tile...

Documenting some of the requirements in the top-level file and some in a
per-arch file seems bad though. If we move the docs to a per-arch file,
we need to actively remove the top-level documentation since it will
conflict. What's wrong with a single table in the top-level document?
The answer to missing requirements for the other arch seems to be to
encourage the relevant maintainers to document them, not too disallow
the ARM requirements to be documented there.
