From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Apr 2011 07:08:08 -0600
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <BANLkTi=jcb8Piki6RrijGOQG=wJ=ULv5Gw@mail.gmail.com>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<BANLkTi=jcb8Piki6RrijGOQG=wJ=ULv5Gw@mail.gmail.com>
Message-ID: <BANLkTim68Fy5r7AvTwoqMqH2B+n2DYKEVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 7:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Apr 29, 2011 at 4:26 AM, Tony Lindgren <tony@atomide.com> wrote:
>> We could do it based on estimated BSS size in uncompress code,
>> or based on the real BSS size in __mmap_switched before BSS
>> gets reset.
>
> How about telling the wrapper what the final size will be by scraping
> the __bss_end value out of System.map?

er, make that __bss_stop

g.
