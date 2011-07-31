From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Jul 2011 10:06:19 +0100
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment
	and rewrite original
In-Reply-To: <CAKnu2MpzFK1HHhs7F5PV1EsbCG9y1Htbu5KM7x0OC2_9U=vovA@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
	<1311941355.1536.529.camel@vkoul-udesk3>
	<CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
	<CAKnu2MrWbm5w6QsBzj=Fd=f7SfE=4_7bHMBBdQiN2bCnbeV-eg@mail.gmail.com>
	<20110730225708.GB17570@n2100.arm.linux.org.uk>
	<CAKnu2MpzFK1HHhs7F5PV1EsbCG9y1Htbu5KM7x0OC2_9U=vovA@mail.gmail.com>
Message-ID: <20110731090619.GA30888@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2011 at 01:37:46AM +0200, Linus Walleij wrote:
> 2011/7/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sun, Jul 31, 2011 at 12:32:55AM +0200, Linus Walleij wrote:
> >> The PL08x has two bus mastering interfaces. They can be
> >> connected to two separate busses and two adress spaces
> >> even, usually that is not the case though.
> >
> > This is not what the function is about... that's done by my
> > pl08x_select_bus() function.
> 
> To be clear, I was explaining what I percieved as a
> question from Viresh about what the comment in this hunk of
> the patch was about:

Yes, and the comment and function name are wrong for what it's doing.
I repeat: it has nothing to do with selecting an AHB bus.

> As for the LLI code, all of it's weird complexity comes from the fact
> that the DMAC cannot let a single element pass across 1KB (0x400)
> boundaries, which is one more than a little insane hardware
> restriction, and I have no clue where that limitation actually comes
> from, likely strange VHDL code.

Viresh's discussion with ARM Ltd indicates that this is not the case,
and that restriction comes from misunderstanding of the documentation.
