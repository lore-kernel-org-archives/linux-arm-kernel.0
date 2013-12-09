From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 17:35:04 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <52A5C024.5050702@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <20131209115050.GA19163@arm.com> <52A5C024.5050702@linaro.org>
Message-ID: <201312091735.05014.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Hanjun Guo wrote:
> On 2013-12-9 19:50, Catalin Marinas wrote:
> > On Mon, Dec 09, 2013 at 04:12:24AM +0000, Hanjun Guo wrote:
> >>
> >> I think the concern here is that ACPI is only for server platform or not.
> >>
> >> Since ACPI has lots of content related to power management, I think ACPI
> >> can be used for mobile devices and other platform too, not only for ARM
> >> servers, and with this patch, we can support both requirement.
> > 
> > 'Can be used' is one thing, will it really be used is another? I don't
> > think so, it was (well, is) difficult enough to make the transition to
> > FDT, I don't see how ACPI would solve the current issues.

Exactly. In particular we don't want people to get the wrong idea about
where we are heading, so making it possible to use this code on embedded
systems for me is a reason *not* to take the patch.

> > I see ACPI as a server distro requirement and there are indeed benefits
> > in abstracting the hardware behind standard description, AML. Of course,
> > this would work even better with probe-able buses like PCIe and I'm
> > pretty sure this would be the case on high-end servers. But even if a
> > server distro like RHEL supports a SoC without PCIe, I would expect them
> > to only provide a single binary Image with CONFIG_PCI enabled.
> > 
> > This patch is small enough and allows ACPI build with !CONFIG_PCI for
> > the time being but longer term I would expect such SoCs without PCI to
> > be able to run on a kernel with CONFIG_PCI enabled.
> 
> Yes, we will support PCI in ACPI in the long run, and we just make PCI
> optional for ACPI in this patch.

Do you mean there is a problem running your code with PCI /enabled/ at the
moment? If so, I'd suggest fixing that instead since you will have to fix
it anyway.

	Arnd
