From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 17:34:04 +0100
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment
	and rewrite original
In-Reply-To: <CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
	<1311941355.1536.529.camel@vkoul-udesk3>
	<CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
Message-ID: <20110729163404.GN25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 08:47:06AM -0700, viresh kumar wrote:
> On 7/29/11, Koul, Vinod <vinod.koul@intel.com> wrote:
> > On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> >>  /*
> >> - * Autoselect a master bus to use for the transfer this prefers the
> >> - * destination bus if both available if fixed address on one bus the
> >> - * other will be chosen
> >> + * Autoselect a master bus to use for the transfer
> >> + * - prefers the destination bus if both available
> >> + * - if fixed address on one bus the other will be chosen
> > Not sure I get it, English is not my first language :)
> 
> Nor mine either. :)
> 
> Will give some more explanation.
> 
> But before that i wanted to know the exact purpose of this
> master-slave concept here.
> Probably it is for choosing the victim for reduction of width, in case
> src and dest addresses
> are misaligned to each other.
> @Russell and Linus: Is this correct?

No idea - most of the LLI code that's in this driver came from within
ARM Ltd, and I've dared not change its behaviour in case the original
author knew something that isn't public.

In addition, as the ARM platforms I have with a PL080 on seem to have
their DMA support buggered beyond belief (that's putting it mildly),
I've not really been able to test anything more complex than single
byte DMA to a UART.  Linus W has one of the rare ARM platforms which
has a working implementation.

I'm not sure why the function is named in terms of master/slave because
those terms don't seem to have much to do with what its actually doing
(which is selecting either the source or destination to handle alignment
issues with.)  And it's not really about busses either.

If the LLI creation code can be greatly simplified and that function
killed off, that'd certainly be a great step forward.  In the mean time
I'd suggest leaving that comment as-is as long as the function exists.
