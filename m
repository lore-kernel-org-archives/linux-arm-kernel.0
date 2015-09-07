From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 07 Sep 2015 23:26:34 +0200
Subject: [PATCH 0/5] ACPI probing infrastructure
In-Reply-To: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <3667410.80mLyhGuXy@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 04, 2015 06:06:47 PM Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
> 
> It turns out that providing such a probing infrastructure is rather
> easy, and provides a much deserved cleanup in both the arch code, the
> GIC driver, and the architected timer driver.

Since I'm not familiar with the DT probing infrastructure mentioned above,
can you please explain to me (possibly at a high level), how it is supposed
to work in the ACPI case?

Thanks,
Rafael
