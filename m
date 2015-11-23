From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 17:58:46 +0100
Subject: [PATCH 07/13] bus: mvebu-mbus: provide api for obtaining IO and
 DRAM window information
In-Reply-To: <CAPv3WKeUPT2VtbvBpchOntNpOpBrpazi4YUaL6+6Yu=NOROFbw@mail.gmail.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <5746764.cNlI6PeatM@wuerfel>
 <CAPv3WKeUPT2VtbvBpchOntNpOpBrpazi4YUaL6+6Yu=NOROFbw@mail.gmail.com>
Message-ID: <13065265.iV8IxW6ybQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 22:24:01 Marcin Wojtas wrote:
> 
> 2015-11-22 21:02 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Sunday 22 November 2015 08:53:53 Marcin Wojtas wrote:
> >> This commit enables finding appropriate mbus window and obtaining its
> >> target id and attribute for given physical address in two separate
> >> routines, both for IO and DRAM windows. This functionality
> >> is needed for Armada XP/38x Network Controller's Buffer Manager and
> >> PnC configuration.
> >>
> >> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> >>
> >> [DRAM window information reference in LKv3.10]
> >> Signed-off-by: Evan Wang <xswang@marvell.com>
> >>
> >
> > It's too long ago to remember all the details, but I thought we
> > had designed this so the configuration can just be done by
> > describing it in DT. What am I missing?
> >
> 
> And those functions do not break this approach. They just enable
> finding and reading the settings of MBUS windows done during initial
> configuration. Please remember that mvebu-mbus driver fills the MBUS
> windows registers basing on DT, however it just configures access CPU
> - DRAM/perfipheral.
> 
> In this particular case only physical adresses of buffers are known
> and we have to 'open windows' between BM <-> DRAM and NETA <-> BM
> internal memory. Hence instead of hardcoding size/target/attribute, we
> can take information stored in CPU DRAM/IO windows registers.
> 
> 

Ok, got it. Thanks for the explanation.

	Arnd
