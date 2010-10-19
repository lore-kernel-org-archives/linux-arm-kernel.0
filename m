From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 19 Oct 2010 15:32:23 -0400 (EDT)
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
In-Reply-To: <20101019190533.GA11893@jirafa.cyrius.com>
References: <20101019190533.GA11893@jirafa.cyrius.com>
Message-ID: <alpine.LFD.2.00.1010191529100.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Oct 2010, Martin Michlmayr wrote:

> I noticed that 2.6.36-rc no longer boots on my QNAP TS-209.  I get
> some output but then the machine resets.
> 
> I've bisected it down to the patch "orion/kirkwood: reset PCIe unit on
> boot".  I remember this patch was controversial when it was proposed.
> Looks like it breaks at least one orion5x machine.  Maybe the patch
> should be reverted for now or only be called on kirkwood.

According to the log, you did agree with that patch at the time.

Keeping it causes breakage.  Removing it causes breakage too.  So I'd 
much prefer if a solution to solve both breakages was merged instead.

> I remember that Marvell was looking into this issue.  Saeed, have you
> had a chance to investigate this more in the meantime?  See
> http://marc.info/?l=linux-ide&m=124822863706181&w=2 for the original
> problem.

Nicolas
