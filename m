From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 11:45:28 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612153536.GL10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<201106121615.24059.arnd@arndb.de>
	<20110612143428.GI10283@n2100.arm.linux.org.uk>
	<201106121701.22418.arnd@arndb.de>
	<20110612153536.GL10283@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106121144080.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:

> On Sun, Jun 12, 2011 at 05:01:22PM +0200, Arnd Bergmann wrote:
> > Of course it should override the device tree, I'm not arguing that.
> > All I'm saying is that we don't need to special-case this or support
> > both formats once the kernel is there as long as we move the information
> > into appropriate DT-representation of the same data.
> 
> You're arguing for it to be parsed by whatever fragment of assembly code
> we have to place around the zImage to merge it into DT.
> 
> And yes, it's going to have to be assembly code because we don't have a
> C environment at that point which can run in a relocatable way.

The prototype patch translating ATAGs into DT defer that processing to C 
code.  Doing that in assembly is of course madness.


Nicolas
