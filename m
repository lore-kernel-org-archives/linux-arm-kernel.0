From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Feb 2016 17:09:52 +0000
Subject: [PATCH v3 1/4] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <CAKv+Gu_OGJG0i9T=ecFVQM-P8KRpasJ+h6L4onJgpaED07Q8Jg@mail.gmail.com>
References: <1455289046-21321-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455289046-21321-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160222164958.GJ31168@arm.com>
 <CAKv+Gu_OGJG0i9T=ecFVQM-P8KRpasJ+h6L4onJgpaED07Q8Jg@mail.gmail.com>
Message-ID: <20160222170952.GM31168@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 05:56:40PM +0100, Ard Biesheuvel wrote:
> On 22 February 2016 at 17:49, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Feb 12, 2016 at 03:57:23PM +0100, Ard Biesheuvel wrote:
> >> Since architectures may not yet have their linear mapping up and running
> >> when the initrd address is discovered from the DT, factor out the
> >> assignment of initrd_start and initrd_end, so that an architecture can
> >> override it and use the translation it needs.
> >>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  drivers/of/fdt.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > Mark, Rob, any comments on this?
> >
> 
> Already acked by Rob, and pulled into -next by Catalin ...

Weird, I don't see that in my inbox or on the list archives. Where should
I be looking?

I'd certainly like to see some performance measurement of the BUG_ON
in PHYS_ADDR that is introduced later in the series too.

Will
