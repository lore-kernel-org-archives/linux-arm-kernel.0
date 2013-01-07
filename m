From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 7 Jan 2013 16:09:18 +0100
Subject: Reboot hangs on Kirkwood ns2 boards with 3.8-rc2
In-Reply-To: <20130106083521.GO17242@lunn.ch>
References: <20130106033455.GH1357@kw.sim.vm.gnt>
 <20130106083521.GO17242@lunn.ch>
Message-ID: <20130107150918.GI1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 09:35:21AM +0100, Andrew Lunn wrote:
> On Sun, Jan 06, 2013 at 04:34:55AM +0100, Simon Guinot wrote:
> > Hi Andrew and Jason,
> > 
> > While testing 3.8-rc2 on the ns2 boards (DT based), I noticed that
> > reboot is not working. After issuing a reboot, the kernel hangs. No
> > error messages are displayed. Moreover, on my non-DT Kirkwood boards,
> > reboot is working as expected.
> > 
> > Am I the only one to experiment this issue ?
> 
> Hi Simon
> 
> No you are not the only one. There is a patch available, authored by
> me, which is identical to what you found.

Arf, it's a shame I have missed this reports. It could have spared some
time by asking at you earlier.

About the issue itself. I understand that a clock is needed by the
orion-ehci driver. But even if the clock is not provided by the DT, it
should have been fixed by kirkwood_legacy_clk_init(), isn't ? What's
wrong with this workaround ?

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/97467bf1/attachment.sig>
