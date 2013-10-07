From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Oct 2013 14:13:54 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.13
In-Reply-To: <20131007170640.GF15413@quad.lixom.net>
References: <20130930154208.GG31178@titan.lakedaemon.net>
 <20131007170640.GF15413@quad.lixom.net>
Message-ID: <20131007181354.GC5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 10:06:40AM -0700, Olof Johansson wrote:
> On Mon, Sep 30, 2013 at 11:42:08AM -0400, Jason Cooper wrote:
> > Guys,
> > 
> > These are the SoC changes that didn't make it during the last merge
> > window.  As with mvebu/drivers, these have been in -next since 3.12-rc1
> > without issue.
> 
> I should have looked closer at this before I commented on the PCI branch.

No problem. :)

> > Sebastian Hesselbarth (2):
> >       ARM: dove: switch to DT probed mbus address windows
> >       ARM: dove: remove legacy pcie and clock init
> 
> It looks to me like this second patch will need to be based on the PCI branch,
> or you will have broken PCI if this is applied and not the drivers/pci patches,
> right? If so, you need to base this branch on top of the other one, not send
> them separately -- otherwise a git bisect that lands between these two will
> result in a non-booting kernel.

Hmm, I'd like to avoid the branch dependency if possible.  I'll just
move the patch over from mvebu/soc to mvebu/drivers.  There might be a
trivial merge conflict later on, but I seriously doubt it.

v2 on it's way...

thx,

Jason.
