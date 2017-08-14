From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 14 Aug 2017 16:53:25 +0100
Subject: [PATCH 02/30] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <CAKv+Gu83nTRAqqT_AzQZubPVCt69tUdHy1oK7bPaYvHFmnihkw@mail.gmail.com>
References: <20170814125411.22604-1-ard.biesheuvel@linaro.org>
 <20170814125411.22604-3-ard.biesheuvel@linaro.org>
 <20170814153213.GU6321@e103592.cambridge.arm.com>
 <CAKv+Gu83nTRAqqT_AzQZubPVCt69tUdHy1oK7bPaYvHFmnihkw@mail.gmail.com>
Message-ID: <20170814155325.GW6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 04:40:55PM +0100, Ard Biesheuvel wrote:
> On 14 August 2017 at 16:32, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Mon, Aug 14, 2017 at 01:53:43PM +0100, Ard Biesheuvel wrote:

[...]

> >> So use the above to implement the macros mov_l, adr_l, adrm_l (using ldm
> >
> > I don't see adrm_l in this patch.
> >
> 
> Oops (2)
> 
> Nico already mentioned that, and I failed to fix the commit log. I
> added it at some point, but it wasn't really useful

Thought it might be something like that.

> >> to load multiple literals at once), ldr_l and str_l, all of which will
> >> use movw/movt pairs on v7 and later CPUs, and use PC-relative literals
> >> otherwise.
> >
> > Also...
> >
> > By default, I'd assume that we should port _all_ uses of :upper16:/
> > :lower16: to use these.  Does this series consciously do that?  Are
> > there any exceptions?
> >
> 
> There aren't that many. Anything that refers to absolute symbols will
> break under CONFIG_RELOCATABLE and I haven't noticed any issues (I
> tested extensively with Thumb2)
> 
> I don't mind open coded movw/movt for relative references in code that
> is tightly coupled to a platform that guarantees v7+ so I didn't do a
> full sweep. Also, I started with 50+ patches and tried to remove the
> ones that are mostly orthogonal to the KASLR stuff.

OK, that sounds reasonable.

Cheers
---Dave
