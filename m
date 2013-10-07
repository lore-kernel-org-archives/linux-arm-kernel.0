From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 10:06:40 -0700
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.13
In-Reply-To: <20130930154208.GG31178@titan.lakedaemon.net>
References: <20130930154208.GG31178@titan.lakedaemon.net>
Message-ID: <20131007170640.GF15413@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:42:08AM -0400, Jason Cooper wrote:
> Guys,
> 
> These are the SoC changes that didn't make it during the last merge
> window.  As with mvebu/drivers, these have been in -next since 3.12-rc1
> without issue.

I should have looked closer at this before I commented on the PCI branch.

> Sebastian Hesselbarth (2):
>       ARM: dove: switch to DT probed mbus address windows
>       ARM: dove: remove legacy pcie and clock init

It looks to me like this second patch will need to be based on the PCI branch,
or you will have broken PCI if this is applied and not the drivers/pci patches,
right? If so, you need to base this branch on top of the other one, not send
them separately -- otherwise a git bisect that lands between these two will
result in a non-booting kernel.

This also explains why you need the PCI patches through arm-soc, so I answered
my own question. :-)


-Olof
