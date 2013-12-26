From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 17:04:54 +0100
Subject: [PATCH 2/2] ARM: mvebu: move Armada 370/XP specific definitions
 to armada-370-xp.h
In-Reply-To: <20131226160048.GA19323@lunn.ch>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131226160048.GA19323@lunn.ch>
Message-ID: <20131226170454.79529766@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 26 Dec 2013 17:00:48 +0100, Andrew Lunn wrote:

> Just a question. How much of armada-370-xp.h is specific to just one
> of these? Things like all the SMP support is XP only. Does it make
> sense to have armada-370.h, armada-xp.h, then a shared
> armada-370-xp.h, followed by common.h?
> 
> As more SoCs move in, having a clean well defined structure is going
> to help with the merging.

As it is today, none of the contents of armada-370-xp.h are useful for
Armada 370. However, the "main" file is also named armada-370-xp.c and
handles both SoC, so it made sense to have a file named armada-370-xp.h
as well.

That said, I'm fine with moving the Armada XP SMP specific bits in a
armada-xp.h, file included in armada-370-xp.c. For now, we wouldn't
need a armada-370.h file or even an armada-370-xp.h file.

The upcoming SOCs will not be handled in armada-370-xp.c, due to quite
important differences in these SOCs compared to 370/XP.

Thanks for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
