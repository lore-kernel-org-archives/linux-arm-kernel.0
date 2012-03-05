From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Mar 2012 15:24:07 -0500 (EST)
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <201203011825.44049.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201203011352.36067.arnd@arndb.de>
 <20120301140817.GG7363@n2100.arm.linux.org.uk>
 <201203011825.44049.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1203051520080.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Arnd Bergmann wrote:

> For Kirkwood and Dove, an easy way out would be to extend the I/O
> space window to 2MB right away and just map both as before, but we
> can also try just using the two lower 64k windows in each and see what
> breaks, as those seem to be widely available for testing still.

The Kirkwood/Dove hardware I have may accommodate 3V PCI cards only, and 
none of the the 3V PCI cards I have make use of the I/O space.  this is 
therefore a pretty much underused feature anyway.  So I think we should 
just go ahead with the cleanup in this case.


Nicolas
