From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 11 Feb 2014 15:31:29 -0500 (EST)
Subject: [PATCH v2] ARM: asm: rename logical shift macros push pull into
 lspush lspull
In-Reply-To: <CAA3XUr3rhbooaTjDwhXVgWxnKV3-1fFNHGVTGsyAjpJrbxiQRQ@mail.gmail.com>
References: <1392063589-24111-1-git-send-email-victor.kamensky@linaro.org>
 <1392063589-24111-2-git-send-email-victor.kamensky@linaro.org>
 <alpine.LFD.2.11.1402101607120.17677@knanqh.ubzr>
 <20140211155437.GC3035@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1402111159230.17677@knanqh.ubzr>
 <20140211173754.GE3035@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1402111253160.17677@knanqh.ubzr>
 <CAA3XUr3Q8tr9-CzYHq_sfbFKSjNbrYYE8_H1-9ypnXo8HgUe2A@mail.gmail.com>
 <CAA3XUr3rhbooaTjDwhXVgWxnKV3-1fFNHGVTGsyAjpJrbxiQRQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1402111528470.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014, Victor Kamensky wrote:

> On 11 February 2014 11:36, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> > On 11 February 2014 09:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Tue, 11 Feb 2014, Dave Martin wrote:
> >>
> >>> On Tue, Feb 11, 2014 at 12:09:35PM -0500, Nicolas Pitre wrote:
> >>> > On Tue, 11 Feb 2014, Dave Martin wrote:
> >>> >
> >>> > > On Mon, Feb 10, 2014 at 04:30:01PM -0500, Nicolas Pitre wrote:
> >>> > > > On Mon, 10 Feb 2014, Victor Kamensky wrote:
> >>> > > >
> >>> > > > > Renames logical shift macros, 'push' and 'pull', defined in
> >>> > > > > arch/arm/include/asm/assembler.h, into 'lspush' and 'lspull'.
> >>> > > >
> >>> > > > I don't have any fundamental objection to the idea, except maybe for the
> >>> > > > actual names.  I just can't come up with anything better though.
> >>> > >
> >>> > > For consistency with the get_byte_ stuff, how about:
> >>> > >
> >>> > >   push -> towards_byte_0
> >>> > >   pull -> from_byte_0
> >>> > >
> >>> > > That may make the purpose a little clearer, too.
> >>> >
> >>> > I don't know if
> >>> >
> >>> >     mov     r0, r1, from_byte_0 #8
> >>> >
> >>> > is that much clearer though.
> >>> >
> >>> > > (Assuming I've got them the right way around...)
> >>> >
> >>> > As you later noticed you got it wrong.  :-)
> >>> > Most likely because "full from" and "push towards" are common english
> >>> > constructs.
> >>>
> >>> No more so than "pull towards" and "push from".
> >>
> >> OK.  I'll trust you on that account.
> >>
> >>> I'll blame it on the fact that the get_byte_ macros have wrong-
> >>> endian numbering, which I didn't look at carefully enough ;)
> >>>
> >>> But I think we proved that my suggestion didn't really make things
> >>> easier to understand...
> >>
> >> What about:
> >>
> >>         push -> next
> >>         pull -> prev
> >>
> >> ?
> >>
> >> That would make:
> >>
> >>         mov     r0, r1, next #8
> >
> > I am not native English speaker, so subtle details of your
> > discussion go above my head :). For me those tokens
> > were just symbols with specific meaning of logical shifts
> > and selected endianness. I'll do as you decide. Quick
> > grep over .S files under arch/arm seems 'next' and 'prev'
> > will be OK and I did build that confirms that.
> 
> Forgot to mention one detail. There is a case in
> ./nwfpe/entry.S file where 'next' is used as label name. I guess,
> it should work if macro would rename it into lsl or lsr label
> name. And/or we could rename the label.
> 
> Wondering ... whether idea to have those macros
> name in way that coincides with English words would lead
> us to some conflict earlier or latter. With this respect lspull
> and lspush IMHO are somewhat better because they are
> sort of abbreviations.

Agreed.  I think it was worth exploring  different alternatives, but 
nothing really better came out.


Nicolas
