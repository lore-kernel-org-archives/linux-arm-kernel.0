From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 17:59:54 +0200
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <4E55B748.1000306@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<4E5000A1.8060609@gmail.com> <4E55B748.1000306@gmail.com>
Message-ID: <201108251759.54441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011, Rob Herring wrote:
> Looking at this some more, it doesn't work too well. platsmp.c depends
> on CONFIG_SMP, but the SCU mapping is always needed even for !SMP
> because the SCU has a power mode register for each core used by the
> power controller. So putting it in platsmp.c would add ifdefs.
> 
> So I'll move out the lluart mapping, but keep SCU mapping in highbank.c.
> 

Ok, makes sense. Another alternative would be to have multiple mappings
for this: one local to the platsmp file and another one local to the
power management code. However, that is ugly for other reasons.

	Arnd
