From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 19:22:33 +0100
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230
 and mv78260
In-Reply-To: <87y551bdnx.fsf@natisbad.org>
References: <cover.1383681717.git.arno@natisbad.org>
 <87y551bdnx.fsf@natisbad.org>
Message-ID: <20131106192233.3599d256@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Wed, 06 Nov 2013 19:14:42 +0100, Arnaud Ebalard wrote:

> > As a side note, Thomas, I noticed one more thing, this time in mv78460
> > .dtsi when comparing it w/ mv78230 and mv78260 ones. The first address
> > of "assigned-address" property varies in the former for each pcie
> > node:
> >
> > $ grep assigned-address armada-xp-mv78230.dtsi 
> >          assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
> > $ grep assigned-address armada-xp-mv78260.dtsi 
> >          assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x84000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x88000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x8c000 0 0x2000>;
> >          assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
> > $ grep assigned-address armada-xp-mv78460.dtsi 
> >          assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
> >          assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
> >          assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
> >          assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
> >          assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
> >          assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
> >          assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
> >          assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
> >          assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
> >          assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
> >
> > I took at Documentation/devicetree/bindings/pci/mvebu-pci.txt but
> > failed to find an answer. Can you explain where the difference comes
> > from?
> 
> Sorry to bother you again with the one above (it was in the cover
> letter) but the difference looks quite odd for someone not familiar
> with the syntax and the semantic.

I do still have this question in mind, I wanted to reply to it today
but just hadn't had the time to do it. I'm adding Jason Gunthorpe in Cc
because he knows better than me the precise meaning of
assigned-addresses. If it doesn't reply, I'll try to have a look
tomorrow. This is the kind of stuff I can't answer without
concentrating for a bit of time to re-understand again how it all fits
together :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
