From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 11 Sep 2012 06:43:53 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
In-Reply-To: <CAMQu2gyXOEs3Zbo=JrPwN2LmUNyYVc35iPWwGZqXCE3BCsn7xg@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
 <20120910185535.GC1303@atomide.com>
 <CAMQu2gxUES=s8fMpwJ77tnY1wz4b_T=yustj+C+WNkEMmEOx4w@mail.gmail.com>
 <alpine.DEB.2.00.1209110636310.23042@utopia.booyaka.com>
 <CAMQu2gyXOEs3Zbo=JrPwN2LmUNyYVc35iPWwGZqXCE3BCsn7xg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1209110643010.23042@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:

> On Tue, Sep 11, 2012 at 12:07 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 11 Sep 2012, Shilimkar, Santosh wrote:
> >
> >> On Tue, Sep 11, 2012 at 12:25 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
> >> >>
> >> >> Will you able to pick up these couple of wakeupgen fixes from  here or
> >> >> do you want me to send you a pull request for 3.6-rc5/6
> >> >
> >> > I can pick them into fixes-noncritical. But if the second one is
> >> > a major bug for the -rc series, the patch should be describe what
> >> > breaks (regression? oops?).
> >> >
> >> Fixes non critical is fine. No major issue without these patches.
> >
> > There's an ordering constraint though: Santosh's patch needs to go in
> > first, then mine.
> >
> Its other way round ;-)
> Mine I created after applying your change.

The problem is that if my patch is applied first, then there will be a 
point after my patch where the AUXCOREBOOT1 register won't be saved, which 
might break PM.  So the patches may need to be updated.

- Paul
