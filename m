From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 23 Jan 2014 08:10:51 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <52E0591E.6030009@gmail.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
 <52E0591E.6030009@gmail.com>
Message-ID: <20140123111049.GB6065@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 12:49:50AM +0100, Sebastian Hesselbarth wrote:
[..]
> > Notice that Ezequiel has added an IRQ handler that just calls panic,
> > so a spurious interrupt call is VERY VERY BAD.
> 
> And I understand that he now clears watchdog's register before
> requesting an irq. All that is missing is bridge_irq driver clearing
> CAUSE register after masking all irqs, right?
> 

Are you sure clearing the CAUSE register after masking the IRQs will be enough?

AFAICS, until now nobody unmasks the watchdog IRQ (at least the orion_wdt
driver didn't request the interruption) but *still* the CAUSE register is set
upon watchdog expiration. So I would guessed a masked interrupt still raises a
bit in the CAUSE register.

Although I'm no sure I'm making sense here or just noise...
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
