From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Dec 2010 18:04:14 +0530
Subject: [PATCH V3 39/63] GIC: Added dummy handlers for
	PowerManagementSuspend Resume
In-Reply-To: <20101220122858.GE28157@n2100.arm.linux.org.uk>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<674f9b1ab90602072d7adcd856453380ed21872b.1292833229.git.viresh.kumar@st.com>
	<20101220111056.GB28157@n2100.arm.linux.org.uk>
	<4D0F3EC1.5030207@st.com>
	<20101220114948.GC28157@n2100.arm.linux.org.uk>
	<53375b410d360c4155c4c4e978be9d78@mail.gmail.com>
	<20101220122858.GE28157@n2100.arm.linux.org.uk>
Message-ID: <3f7fa8ffdb0ccbbdd018360e6e334b85@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, December 20, 2010 5:59 PM
> To: Santosh Shilimkar
> Cc: viresh kumar; Rajeev KUMAR; Armando VISCONTI; Vipin KUMAR; Shiraz
> HASHIM; Amit VIRDI; Vipul Kumar SAMAR; Deepak SIKRI; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH V3 39/63] GIC: Added dummy handlers for
> PowerManagementSuspend Resume
>
> On Mon, Dec 20, 2010 at 05:50:37PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org
[mailto:linux-arm-
> > > kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM
> > Linux
> > > Sent: Monday, December 20, 2010 5:20 PM
> > > To: viresh kumar
> > > Cc: Rajeev KUMAR; Armando VISCONTI; Vipin KUMAR; Shiraz HASHIM; Amit
> > > VIRDI; Vipul Kumar SAMAR; Deepak SIKRI; linux-arm-
> > > kernel at lists.infradead.org
> > > Subject: Re: [PATCH V3 39/63] GIC: Added dummy handlers for Power
> > > ManagementSuspend Resume
> > >
> > > On Mon, Dec 20, 2010 at 05:02:17PM +0530, viresh kumar wrote:
> > > > On 12/20/2010 04:40 PM, Russell King - ARM Linux wrote:
> > > > > And still this patch gets reposted a few more times despite my
> > > > > objections:
> > > > >
> > > > >
> > >
> >
>
http://lists.arm.linux.org.uk/lurker/message/20100920.150749.c97eda0d.en.h
> > > tml
> > > >
> > > > Russell,
> > > >
> > > > Actually, when we discussed all this, we didn't came to any
> > conclusion,
> > > > and so i asked you: should we go ahead with this patch or drop it?
> > >
> > > Yes, I didn't bother replying any further because it seemed that no
> one
> > > was listening to me.
> > >
> > > I think over the four or five emails my position on the patch was
> pretty
> > > clear: I do _not_ like it one bit, and I still do not like it.
> > >
> > > It is a hack, plain and simple.  You're adding code to misrepresent
> what
> > > the hardware can do.  You're fooling the system into thinking that
the
> > > GIC can control wake-up sources, when in fact the GIC has zero
wakeup
> > > capabilities what so ever.
> > >
> > > As I pointed out in the message above, if you do this, then drivers
> have
> > > NO WAY to detect whether the interrupt controller they're connected
to
> > > is wake-up capable or not.
> > >
> > >
> >
>
http://lists.arm.linux.org.uk/lurker/message/20100920.134808.634d6ea1.en.h
> > > tml
> > >
> > > I still don't know what your driver code looks like, yet I've given
> you
> > > a suggestion to solve your problem in a subsequent reply (see the
URL
> > > at the top of this message) which never really got a reply from you.
> > >
> > > It seems to me that as soon as I asked for driver code, ST lost all
> > > interest in discussing the issue any further, as there was no
further
> > > technical discussion coming from _any_ ST people.
> > >
> > Just for information, we did found a serial driver BUG
> > is similar aspect. Below is the thread.
> > http://ns3.spinics.net/lists/linux-omap/msg41240.html
>
> So, the serial_core layer isn't properly tracking whether
> enable_irq_wake()
> succeeded, and is then calling disable_irq_wake().  That's a bug in
> the serial_core layer which needs fixing.
Patch is already posted for this on serial list.

http://www.spinics.net/lists/linux-serial/msg03156.html
