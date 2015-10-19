From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2015 08:46:09 -0700
Subject: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
In-Reply-To: <5624F692.5070302@ti.com>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <561DD014.10403@ti.com> <20151014160245.GA10113@atomide.com>
 <561F5C0C.6080106@ti.com> <20151015140551.GM10113@atomide.com>
 <561FC2E9.9050805@ti.com> <20151016192300.GD24370@atomide.com>
 <5624F692.5070302@ti.com>
Message-ID: <20151019154609.GA22043@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <a0131933@ti.com> [151019 07:03]:
> 
> Since there is a big hole with in the memory space, we might also need
> to enable SPARSEMEM ?

No from what I remember that depends on section sizes and smaller
chunks of physical memory. For example, on the old Psions we had to
use DISCONTIGMEM/SPARSEMEM because of four discontiguous 8MB memory
chips.

Regards,

Tony
