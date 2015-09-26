From: dwmw2@infradead.org (David Woodhouse)
Date: Sat, 26 Sep 2015 16:20:51 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <20150925152848.GQ13823@e104818-lin.cambridge.arm.com>
References: <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
 <1443095558.74600.84.camel@infradead.org>
 <20150924151546.GJ13823@e104818-lin.cambridge.arm.com>
 <1443118238.74600.117.camel@infradead.org>
 <20150925152848.GQ13823@e104818-lin.cambridge.arm.com>
Message-ID: <1443280851.4674.63.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-25 at 16:28 +0100, Catalin Marinas wrote:
> 
> This only works as long as they target an existing driver with prior DT
> support (usually with reviewed bindings). If they have a new driver and
> only ACPI in mind, I'm pretty sure we'll end up with new insane things.
> That's why we need some form of _DSD properties review and "compatible"
> is one such property.

Sure, that makes a lot of sense.

My main concern is that we don't end up with gratuitously *different*
property sets for DT vs. ACPI. That way we end up with either two
separate drivers, or abstracting the core of the driver out and having
two bindings for it (much as we do for PCI vs. platform/etc for some
devices already). We don't want that pain where we can avoid it. And we
don't want people to *have* to hack the kernel driver to migrate to
ACPI, if we can avoid it.


Sometimes it might be worth being different ? if the DT binding is
utterly crap, and deserves to be thrown away. In that case, by all
means invent a new binding. But if we're going to accept the pain of
having multiple bindings, why not make the *new* one work via DT too
anyway.

I'd be happy to see the existing DT bindings put through the nascent
_DSD review process ? such as it is ? and into the database. One at a
time on a case-by-case basis as they get used, perhaps.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150926/fe7b2387/attachment.bin>
