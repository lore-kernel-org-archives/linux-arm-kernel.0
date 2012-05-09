From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 20:47:06 +0000
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <37e096905f891fc6abdccf8977bd7447@localhost>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <201205092027.50059.arnd@arndb.de>
 <37e096905f891fc6abdccf8977bd7447@localhost>
Message-ID: <201205092047.06852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Marc Zyngier wrote:
> Ah, I see what you mean. But these registers and interrupt are actually
> only visible on the hypervizor side. The guest shouldn't see any of this.

Rihgt, that makes sense.

> I suppose we could have a "arm,has-virt-extensions" property in devices
> that implement the virtualization extensions (GIC, timers...).
> 
> What do you think?

Sounds good. I don't have a strong preference whether that should be a
property like you suggest or a separate "compatible" value, maybe Rob or
Grant can comment on what they prefer.

On the guest side, is it guaranteed that the virtual GIC looks like
a real GIC without those extensions? If the actual behavior depends on
the hypervisor, it might still make sense to add another flag in there
to tell that it's virtual, even if we don't require it for now.

	Arnd
