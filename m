From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 18 Mar 2016 12:56:00 +0000
Subject: [PATCH v15 1/6] efi: ARM/arm64: ignore DT memory nodes instead
 of removing them
In-Reply-To: <CAKv+Gu8STa=tF0o1qje6LorYxzBon704Q_O2U=cvigg9v53hZw@mail.gmail.com>
References: <1457481587-8976-1-git-send-email-ddaney.cavm@gmail.com>
 <1457481587-8976-2-git-send-email-ddaney.cavm@gmail.com>
 <20160318122609.GS2619@codeblueprint.co.uk>
 <CAKv+Gu8STa=tF0o1qje6LorYxzBon704Q_O2U=cvigg9v53hZw@mail.gmail.com>
Message-ID: <20160318125600.GT2619@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Mar, at 01:31:59PM, Ard Biesheuvel wrote:
> 
> Typically, the UEFI memory map is more restrictive, since it does not
> only describe where the memory lives, but also which parts of it the
> firmware has claimed for its own use. So if both memory nodes and the
> UEFI memory map are available, we must use the latter anyway, and so
> it makes sense to ignore the former. Alternatively, we could sanity
> check the memory nodes against the memory map, but it is simpler just
> to ignore them.
> 
> However, that caused some problems in the past, since discovering the
> memory nodes occurs before the EFI entry point is invoked, and so it
> was decided that we strip the memory nodes rather than ignore them.

Thanks Ard.

Once you've stripped the memory nodes as represented in memblock,
there's no way for the memory nodes to re-appear in one form or
another after that point, right? The EFI memory map is the sole memory
layout either via memblock or if it's queried directly?
