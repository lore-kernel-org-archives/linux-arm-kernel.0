From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Jan 2016 12:52:11 +0000
Subject: [PATCH v2] kernel: add kcov code coverage
In-Reply-To: <CACT4Y+bvReSkPa5mtb4+Uy6GsoDiuawLzfzMPoJF++1X=H06aA@mail.gmail.com>
References: <1452689318-107172-1-git-send-email-dvyukov@google.com>
 <CAPAsAGx_0pVjtKA2RwwpStRG2-L+5X6W14QbrQaMYhdg30EeAQ@mail.gmail.com>
 <CACT4Y+bHjfkrZ4jWZf+j6FKnj2GQv1t94Y9LJm4=WFyb8C0J8w@mail.gmail.com>
 <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
 <CACT4Y+YvL_L9a2dBfoXQ0AKpKmnypfObtt7k97j_i2Qiu=wnQg@mail.gmail.com>
 <20160118141352.GM21067@leverpostej>
 <CACT4Y+ZdtKTM8Nrko_oweTDYF+SF7+A78-UG8YeoqEcreWRVwQ@mail.gmail.com>
 <CACT4Y+YTKoh+WEOT9Vr3EmLad3fcd-SPaeBPwgfGsr56OLXW-w@mail.gmail.com>
 <20160122115503.GA10370@leverpostej>
 <CACT4Y+bvReSkPa5mtb4+Uy6GsoDiuawLzfzMPoJF++1X=H06aA@mail.gmail.com>
Message-ID: <20160122125210.GA10802@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 01:15:27PM +0100, Dmitry Vyukov wrote:
> On Fri, Jan 22, 2016 at 12:55 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jan 18, 2016 at 09:09:43PM +0100, Dmitry Vyukov wrote:
> >> On Mon, Jan 18, 2016 at 8:44 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >> > Regarding KASLR and dynamically loaded modules. I've looked at my
> >> > use-case and concluded
> >> > that most of the time I can work with "non-stable" PCs within a single
> >> > VM. Whenever I need to
> >> > store PCs persistently or send to another machine, I think I can
> >> > "canonicalize" PCs using
> >> > /proc/modules and /proc/kallsyms to something like (module hash,
> >> > module offset). So kernel does
> >> > not need to do this during coverage collection.
> >>
> >> On second though, maybe it's better to just always export unsigned long PCs...
> >> Need to measure how much memory coverage information consumes,
> >> and how much slower it is with uint64 PCs. Maybe I can live with large PCs,
> >> or maybe I can make syzkaller require !KASLR and compress PCs in user-space...
> >> Need to think about this more.
> >
> > I can imagine we might keep the expanded module range even in the
> > absence of full KASLR, though I don't know how realistic that thought
> > is.
> 
> The last version of the patch just exposes PCs as unsigned longs
> without any compression. So it should not be a problem (at least for
> kernel, now it's user responsibility to make sense out of the PCs).

Ah, ok. Sorry for the noise!

Mark.
