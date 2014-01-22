From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 15:03:58 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140122175030.GU18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <20140122174539.GD27273@localhost>
 <20140122175030.GU18269@obsidianresearch.com>
Message-ID: <20140122180357.GF27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 10:50:30AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 02:45:40PM -0300, Ezequiel Garcia wrote:
>  
> > Agreed. So, let's assume we can guarantee that request_irq() does the
> > job of clearing the cause register (clearing pending irqs).
> > 
> > So, your suggestion is to put request_irq() in the watchdog start()?
> > 
> > Otherwise, we can ensure a watchdog full stop at probe(), before
> > requesting the IRQ. Both solutions should work, uh?
> 
> Right, I would keep the request_irq in probe, just because that feels
> more idiomatic..
> 

Done. Baking v4...
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
