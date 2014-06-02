From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 21:15:46 +0200
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <2F6515B1-48FE-4ED6-908E-CC1CAD7AF403@codeaurora.org>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <20140602162306.4AB0FC40476@trevor.secretlab.ca>
 <2F6515B1-48FE-4ED6-908E-CC1CAD7AF403@codeaurora.org>
Message-ID: <4495090.ktpdXEyibD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 13:09:08 Kumar Gala wrote:
> > However, what do we do with the 2 cases that exist in upstream that
> >> are using ranges for cfg space?
> > 
> > Ignore them in the core code? Make the specific host controller handle
> > them I would think.
> 
> I just meant, should we ?break? their DTs and move them from using ranges to reg?

dw-pcie is used on a lot of systems, I think we should make the common
part of that driver always handle config space in a common way, and
move out the part that parses the ranges property into the individual
soc-specific glue drivers that want to keep optional backwards compatibility
with existing dtbs.

Which one is the other driver?

	Arnd
