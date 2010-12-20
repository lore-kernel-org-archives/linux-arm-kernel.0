From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 11:49:48 +0000
Subject: [PATCH V3 39/63] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <4D0F3EC1.5030207@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<674f9b1ab90602072d7adcd856453380ed21872b.1292833229.git.viresh.kumar@st.com>
	<20101220111056.GB28157@n2100.arm.linux.org.uk>
	<4D0F3EC1.5030207@st.com>
Message-ID: <20101220114948.GC28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 05:02:17PM +0530, viresh kumar wrote:
> On 12/20/2010 04:40 PM, Russell King - ARM Linux wrote:
> > And still this patch gets reposted a few more times despite my
> > objections:
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20100920.150749.c97eda0d.en.html
> 
> Russell,
> 
> Actually, when we discussed all this, we didn't came to any conclusion,
> and so i asked you: should we go ahead with this patch or drop it?

Yes, I didn't bother replying any further because it seemed that no one
was listening to me.

I think over the four or five emails my position on the patch was pretty
clear: I do _not_ like it one bit, and I still do not like it.

It is a hack, plain and simple.  You're adding code to misrepresent what
the hardware can do.  You're fooling the system into thinking that the
GIC can control wake-up sources, when in fact the GIC has zero wakeup
capabilities what so ever.

As I pointed out in the message above, if you do this, then drivers have
NO WAY to detect whether the interrupt controller they're connected to
is wake-up capable or not.

http://lists.arm.linux.org.uk/lurker/message/20100920.134808.634d6ea1.en.html

I still don't know what your driver code looks like, yet I've given you
a suggestion to solve your problem in a subsequent reply (see the URL
at the top of this message) which never really got a reply from you.

It seems to me that as soon as I asked for driver code, ST lost all
interest in discussing the issue any further, as there was no further
technical discussion coming from _any_ ST people.
