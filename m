From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 4 Oct 2012 07:17:35 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for Network Space v2 and
 parents
In-Reply-To: <20121003220916.GW31897@kw.sim.vm.gnt>
References: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
 <20121003154310.GI11837@lunn.ch>
 <20121003220916.GW31897@kw.sim.vm.gnt>
Message-ID: <20121004051735.GI21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 12:09:16AM +0200, Simon Guinot wrote:
> On Wed, Oct 03, 2012 at 05:43:10PM +0200, Andrew Lunn wrote:
> > On Wed, Oct 03, 2012 at 05:14:30PM +0200, Simon Guinot wrote:
> > > This patch adds DT board setup for LaCie Network Space v2 and parents,
> > > based the Marvell Kirkwood 6281 SoC. This includes Network Space (Max)
> > > v2 and Internet Space v2.
> > 
> > Hi Simon
> > 
> > At a first look, this looks good. Also nice to see you use the new
> > gpio-fan binding.
> 
> Hi Andrew,
> 
> It is nice to have this binding. It works fine.

It good to hear that it works. There is one other board which could
use it. I plan to convert it over for 3.8.

I will take a look at other DT boards and see if there is any patterns
which might help here, for naming of a shared compatibility string.

> > Have you thought about adding a DT binding for this driver?
> 
> Yes. I am on it.

Great. Please include my CC: when you post it.

> > It would be nice if you could respin the patches for -rc1, when it
> > comes out. There are changes to Makefile.boot at least required.
> 
> OK. I will.
> 
> Note that this patch is based against the branch kirkwood/boards from
> the git repository git://git.infradead.org/users/jcooper/linux.git. Is
> that correct ?

Its a good start. However, the Makefile.boot changes were merged in in
arm-soc, and not by the Marvell maintainers in our trees. So changes
across multiple arm platforms are not in Jason's tree. -rc1 will have
all these changes, and forms the best base for a new board.

    Thanks
	Andrew
