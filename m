From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 Jan 2014 10:50:30 -0700
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140122174539.GD27273@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <20140122174539.GD27273@localhost>
Message-ID: <20140122175030.GU18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:45:40PM -0300, Ezequiel Garcia wrote:
 
> Agreed. So, let's assume we can guarantee that request_irq() does the
> job of clearing the cause register (clearing pending irqs).
> 
> So, your suggestion is to put request_irq() in the watchdog start()?
> 
> Otherwise, we can ensure a watchdog full stop at probe(), before
> requesting the IRQ. Both solutions should work, uh?

Right, I would keep the request_irq in probe, just because that feels
more idiomatic..

Jason
