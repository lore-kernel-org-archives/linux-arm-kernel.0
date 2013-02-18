From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Feb 2013 14:44:21 +0000
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <201302181439.08639.arnd@arndb.de>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <20130218134707.17303.48589.sendpatchset@w520>
 <201302181439.08639.arnd@arndb.de>
Message-ID: <201302181444.21717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013, Arnd Bergmann wrote:
> Ok, this gets rid of the warning, but I'm a bit worried about
> how it is hardwiring the fact that the SCU physical address has
> the same bit pattern as the __iomem token.
> 
> While I realize that you already rely on this in a lot of places
> in the shmobile code, I see a red light going off every time I read
> code like this, and it is not any more logical than the previous
> version.
> 
> It would be nice to keep these address spaces separate at least
> in new code, mostly in order to not confuse reviewers with code
> that is based on assumptions which are not generally true, but also
> to be more flexible with the virtual memory layout. On a related
> topic, you are using an entire 256 MB section of your virtual
> address space for sh73a0 and sh7372 and 160 MB for r8a7740. Putting
> less of that into the identity mapped area would free up space for
> vmalloc, but it's hard to prove that doing this is correct when
> you have all sorts of code using a hardcoded virtual MMIO address
> token.

To clarify my rant: I'm absolutely fine with this code going in
for now, but I'd like to see a long-term plan about what to do
with the hardcoded virtual address hacks.

	Arnd
