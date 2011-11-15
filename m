From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2011 08:52:02 +0000
Subject: [PATCH 04/41] ARM: restart: at91: use new restart hook
In-Reply-To: <20111115011610.GF15318@game.jcrosoft.org>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ic-0001Wp-7t@rmk-PC.arm.linux.org.uk>
 <20111115011610.GF15318@game.jcrosoft.org>
Message-ID: <20111115085202.GB8574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 02:16:10AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:41 Sun 06 Nov     , Russell King - ARM Linux wrote:
> > Rather than using a private function pointer, use the existing
> > arm_pm_restart function pointer instead.  We no longer need to enable
> > the I-cache in at91sam9_alt_reset() as the caches will now be on when
> > this function is called.
> > 
> > Update the function names to use the 'restart' terminology rather than
> > the 'reboot' terminology.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> I'll appply this one via at91-treee as I've patch that touch this part too in
> the queue if you do'nt mind

Which will break my patch queue.  As I said to Tony, I'm looking to
stabilize this in about a week and a half's time, at which point
you'll be able to pull these changes into your tree.
