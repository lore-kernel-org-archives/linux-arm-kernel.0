From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 16 May 2017 11:27:19 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170515232825.GX22219@n2100.armlinux.org.uk>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
Message-ID: <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

2017-05-16 1:28 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
>
> On Tue, May 16, 2017 at 01:28:32AM +0200, Marcin Wojtas wrote:
> > This patch adds following improvements to Armada 8040
> > MachiatoBin:
> >  * Add 'chosen' node with stdout-path assignment
> >  * Enable 1G sgmii port
> >  * Enable SDHCI controllers on AP and CP HW blocks
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Please check my repository at:
>
>         git://git.armlinux.org.uk/~rmk/linux-arm.git mcbin
>
> I'm currently in the big post-merge window rebase, but that branch has
> almost complete support for the board, including work in progress for
> upgrading phylib for 10G support.
>

I do not intend to interfere your work at all. I took a look on your
branch, and my patch does not seem to be really colliding with it. The
board is starting to get really popular and a lot has been happening
around it recently - missing bits like 'chosen' node or the interfaces
is pretty annoying. Therefore I think, the earlier such things get
merged into the tree, the better (we can also enable &cpm_pcie0, just
tested it), since with current kernel it's no-cost, quick DT update.

I have no problem if you insist to use your own DT patches - if so
could you possibly submit them, so that there may be still some chance
that they reach v4.12? I can see some significant work ahead on your
branch (e.g. transition from out-of-tree network driver to mvpp2), so
better not be blocked by this.

Best regards,
Marcin
