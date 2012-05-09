From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 14:13:37 +0000
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <alpine.LFD.2.02.1205090955520.21030@xanadu.home>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <201205091345.34404.arnd@arndb.de>
 <alpine.LFD.2.02.1205090955520.21030@xanadu.home>
Message-ID: <201205091413.37664.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Nicolas Pitre wrote:
> On Wed, 9 May 2012, Arnd Bergmann wrote:
> 
> > FWIW, I would actually prefer merging the 'struct arm_soc_desc', 'struct
> > arm_soc_smp_init_ops' and 'struct arm_soc_smp_ops' structures into a
> > single 'struct smp_ops' for simplicity.
> 
> You can't easily validate correct usage of __init marked code from the 
> rest if everything is pulled in the same struct.  This is why I asked 
> they be split.

Ah, I see. However, in version 6 of the patch set, each platform
was marking both structures as __initdata, which seems to make
your argument pointless because we don't actually validate the
sections.

	Arnd
