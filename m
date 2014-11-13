From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 16:02:01 +0100
Subject: [PATCH 4/5] ARM: mvebu: adjust ethernet aliases according to
 U-Boot requirements for A38x
In-Reply-To: <CAPv3WKdjaMF--GQTF42Zk=kYOYpyvBONrOALG3nnhh25a0_72w@mail.gmail.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
 <1415835600-97188-5-git-send-email-mw@semihalf.com>
 <20141113091427.31113495@free-electrons.com>
 <CAPv3WKdjaMF--GQTF42Zk=kYOYpyvBONrOALG3nnhh25a0_72w@mail.gmail.com>
Message-ID: <20141113160201.2c426ba2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 15:55:31 +0100, Marcin Wojtas wrote:

> 2014-11-13 9:14 GMT+01:00 Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com>:
> > Dear Marcin Wojtas,
> >
> > On Thu, 13 Nov 2014 00:39:59 +0100, Marcin Wojtas wrote:
> >> The vendor bootloader provided for Armada 38x boards expects an
> >> alias for the ethernet nodes, which is used to fixup the MAC address.
> >> The alias format naming is strict.
> >
> > I believe this needs a bit more explanation: why would we care about
> > the "vendor bootloader" ? What are expecting the mainline versions of
> > popular bootloaders like U-Boot and Barebox ? What are other platforms
> > supported in the mainline doing ?
> 
> In order to update MAC address entry in Device Tree both mainline U-Boot
> (in function fdt_fixup_ethernet) and Barebox (in function eth_of_fixup)
> accept same (and the only one) format of eth aliases, which is 'ethernetX',
> where X stands for interface number.

Yes, I know this, I had a look when I saw your patch.

> Other platforms in the mainline Linux, that comprise ethernet references in
> '/aliases' node (like various flavours of imx or sunXi), follow the naming
> scheme described above.
> Is this explanation sufficient? Do you think I should extend the commit log?

Yes, that's what I meant: in the commit log, taking as a justification
for the change a "vendor bootloader" is probably the worst possible
justification. Taking the mainline version of bootloaders and other
platforms supported in the kernel is a much stronger justification for
the change you're proposing.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
