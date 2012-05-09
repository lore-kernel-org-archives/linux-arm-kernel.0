From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 May 2012 09:59:56 -0400 (EDT)
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <201205091345.34404.arnd@arndb.de>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <201205091212.08239.arnd@arndb.de> <4FAA6DE6.3040001@arm.com>
 <201205091345.34404.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205090955520.21030@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2012, Arnd Bergmann wrote:

> FWIW, I would actually prefer merging the 'struct arm_soc_desc', 'struct
> arm_soc_smp_init_ops' and 'struct arm_soc_smp_ops' structures into a
> single 'struct smp_ops' for simplicity.

You can't easily validate correct usage of __init marked code from the 
rest if everything is pulled in the same struct.  This is why I asked 
they be split.


Nicolas
