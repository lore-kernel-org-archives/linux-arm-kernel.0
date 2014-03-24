From: robert.daniels@vantagecontrols.com (robert.daniels at vantagecontrols.com)
Date: Mon, 24 Mar 2014 16:37:20 -0600
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <201403242121.58705.marex@denx.de>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
Message-ID: <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Marek Vasut <marex@denx.de> wrote on 03/24/2014 02:21:58 PM:

>
> I think the UDP test might be lossy, can you try with TCP test please ?
>
> Best regards,
> Marek Vasut

Yes, I tried with TCP and there were no problems.
I then tried my same test with a crossover cable: no problems.
Then I started testing some different network configurations:

1. Desktop & i.MX53 both connected to the same router: no problems.
2. Desktop & i.MX53 both connected to the same hub: packet loss but no tx
timeout
3. Desktop connected to router, hub connected to router, i.MX53 connected
to hub: packet loss + tx timeout

So, the packet loss is due to the hub, not the fec driver.
I'm not sure why I'm getting the tx timeout.  My router is a Cisco
ValetPlus and the hub is a Netgear DS108.
The router and desktop are gigabit and the hub is 10/100.

I assumed that the tx timeout should not be happening - is this an
incorrect assumption based on my setup?

Thanks,
- Robert Daniels

This email, and any document attached hereto, may contain
confidential and/or privileged information.  If you are not the
intended recipient (or have received this email in error) please
notify the sender immediately and destroy this email.  Any
unauthorized, direct or indirect, copying, disclosure, distribution
or other use of the material or parts thereof is strictly
forbidden.
