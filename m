From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 16:00:21 +0200
Subject: [PATCH 5/5] irqchip: armada-370-xp: document the overall driver
 logic
In-Reply-To: <1445347435-2333-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20151020160021.374725f3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 20 Oct 2015 15:23:55 +0200, Thomas Petazzoni wrote:

> +/*
> + * Overall diagram of the Armada XP interrupt controller:
> + *
> + *    To CPU 0                 To CPU 1
> + *
> + *       /\                       /\
> + *       ||                       ||
> + * +---------------+        +---------------+
> + * |               |	 |               |

Things are a bit off here.

> + * |    per-CPU    |	 |    per-CPU    |
> + * |  mask/unmask  |	 |  mask/unmask  |
> + * |     CPU0      |	 |     CPU1      |
> + * |               |	 |               |
> + * +---------------+	 +---------------+
> + *        /\                       /\

and here. So I can fix that up in the next version.

If we're doing ASCII art, let's do it properly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
