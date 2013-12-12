From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Dec 2013 21:29:26 +0100
Subject: [PATCH v4 2/4] Documentation: Add APM X-Gene SoC 15Gbps
 Multi-purpose PHY driver binding documentation
In-Reply-To: <52A9C8C5.8030809@interlog.com>
References: <1386833435-30498-1-git-send-email-lho@apm.com>
 <201312121427.20040.arnd@arndb.de> <52A9C8C5.8030809@interlog.com>
Message-ID: <201312122129.26714.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013, Douglas Gilbert wrote:
> >
> >> +- apm,tx-speed              : Tx operating speed. One set of 3-tuple for
> >> +                      Gen1 (0x1), Gen2 (0x3), and Gen3 (0x7). Default is
> >> +                      0x7.
> >
> > I'm completely confused by this description. Can you rephrase this?
> > It sounds like the only possible values are <1 3 7> for this property.
> 
> Most likely Gen1, Gen2 and Gen3 are SATA-speak corresponding to SAS's
> G1, G2 and G3:
> 
> G1   Gen1     1.5 Gbps
> G2   Gen2     3 Gbps
> G3   Gen3     6 Gbps
> G4   -        12 Gbps
> G5   -        24 Gbps
> 
> And the "7" corresponding to Gen3 is indicating backward compatibility
> with Gen2 and Gen1. The SAS-3 draft only requires backward compatibility
> two generations. Thus you can buy a SAS 12 Gbps HBA today that will
> not support the original SATA 1.5 Gbps class of disks. The corresponding
> value would be 0xe (rather than 0xf) using the tx-speed convention above.
> 
> 
> My explanation is a bit long winded to put in a device-tree bindings
> file. "RTFM: SATA drafts." should suffice.
> 
> 
> BTW Compared to some device-tree binding explanations I have had
> to wade through, the above looks pretty good.
> 

Well, the problem is that this is not a SATA device but a PHY device
that happens to support SATA among its protocols (at least PCIe
as well, possibly more but I don't have the specs). The binding
document has to cover all the possibilities or allow extensions
for the other protocols to be implemented later. Having the driver
support SATA only initially is fine, but we shouldn't plan for
breaking compatibility with an established binding just a short time
later.

	Arnd
