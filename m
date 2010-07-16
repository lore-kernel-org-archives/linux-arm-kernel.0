From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 16 Jul 2010 11:46:17 -0700
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <alpine.LFD.2.00.1007161439240.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
Message-ID: <AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> DOH.

Well, it's possible that the correct approach is a mixture.

Automatically do the trivial cases (recursive selects, dependencies
that are simple or of the form "x && y" etc), and warn about the cases
that aren't trivial (where "not trivial" may not necessarily be about
fundamentally ambiguous ones, but just "complex enough that I won't
even try").

Maybe a full "solver" is unnecessary, for example, but just a simple
"automatically enable the direct dependencies and scream when it's not
simple any more" would take care of 99% of the common cases, and then
warn when it needs some manual help.

So it's not a strict "one or the other" issue. The solution could be
"some of both".

                     Linus
