From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Jul 2011 23:57:08 +0100
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment
	and rewrite original
In-Reply-To: <CAKnu2MrWbm5w6QsBzj=Fd=f7SfE=4_7bHMBBdQiN2bCnbeV-eg@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
	<1311941355.1536.529.camel@vkoul-udesk3>
	<CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
	<CAKnu2MrWbm5w6QsBzj=Fd=f7SfE=4_7bHMBBdQiN2bCnbeV-eg@mail.gmail.com>
Message-ID: <20110730225708.GB17570@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2011 at 12:32:55AM +0200, Linus Walleij wrote:
> 2011/7/29 viresh kumar <viresh.linux@gmail.com>:
> > Nor mine either. :)
> >
> > Will give some more explanation.
> >
> > But before that i wanted to know the exact purpose of this
> > master-slave concept here.
> 
> The PL08x has two bus mastering interfaces. They can be
> connected to two separate busses and two adress spaces
> even, usually that is not the case though.

This is not what the function is about... that's done by my
pl08x_select_bus() function.

This function (pl08x_choose_master_bus) does something completely
different, and has to do with how the LLIs are laid out.  I think
it's to do with whether we use the source or destination for
alignment purposes.

It really has nothing to do with choosing busses.
