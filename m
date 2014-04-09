From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Apr 2014 16:08:43 +0200
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <CAErSpo4BmoYzf6GxOPRni=q563zhON57s7=5Hz=2Cf-X2ft-1A@mail.gmail.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <20140409120750.GN985@e106497-lin.cambridge.arm.com>
 <CAErSpo4BmoYzf6GxOPRni=q563zhON57s7=5Hz=2Cf-X2ft-1A@mail.gmail.com>
Message-ID: <5040304.p3jyCMi26Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 08:02:41 Bjorn Helgaas wrote:
> 
> It's possible we could manage domain numbers in the core.  On ACPI
> systems, we currently we use the ACPI _SEG value as the domain.  In
> some cases, e.g., on ia64, config space access is done via firmware
> interfaces, and those interfaces expect the _SEG values.  We could
> conceivably maintain a mapping between _SEG and domain, but I'm not
> sure there's an advantage there.

I think it's a safe assumption that we will never have more than
one firmware trying to enumerate the domains, so it would be
safe to let ACPI keep doing its own thing for domain numbers,
have the DT code pick domain number using some method we come up
with, and for everything else let the architecture code deal with
it. There are probably very few systems that have multiple domains
but use neither ACPI nor DT.

	Arnd
