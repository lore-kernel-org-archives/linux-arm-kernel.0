From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jun 2016 13:31:22 +0100
Subject: [PATCH] arm64: mm: fix location of _etext
In-Reply-To: <CAKv+Gu9wq+MjV2W0XkEK1xkYNCsJNfdpbKcF08HN-ACMywOtHQ@mail.gmail.com>
References: <1466678792-7971-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160623114006.GB8836@leverpostej>
 <CAKv+Gu9wq+MjV2W0XkEK1xkYNCsJNfdpbKcF08HN-ACMywOtHQ@mail.gmail.com>
Message-ID: <20160623123122.GC8836@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 01:49:05PM +0200, Ard Biesheuvel wrote:
> On 23 June 2016 at 13:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jun 23, 2016 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> >> @@ -232,7 +232,7 @@ void __init setup_arch(char **cmdline_p)
> >>
> >>       sprintf(init_utsname()->machine, ELF_PLATFORM);
> >>       init_mm.start_code = (unsigned long) _text;
> >> -     init_mm.end_code   = (unsigned long) _etext;
> >> +     init_mm.end_code   = (unsigned long) __init_begin;
> >
> > Why does this need to be __init_begin?
> >
> > We don't have code in .rodata, the exception tables, or notes, so
> > shouldn't this be left pointing at _etext if we're tightening things up?
> >
> 
> You are right, and I am happy to change that in the same patch.
> Strictly speaking, it is a separate change, but that applies equally
> to not updating the _etext references in kaslr.c

Ok. FWIW, with that and the comment fixup:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
