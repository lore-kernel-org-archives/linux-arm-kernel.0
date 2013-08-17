From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:32:59 +0200
Subject: [RFC v1 0/5] ARM: Initial support for Marvell Armada 1500
In-Reply-To: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308172132.59402.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013, Sebastian Hesselbarth wrote:
> This is a RFC adding initial support for the Marvell Armada 1500
> (88DE3100) found on various consumer devices (Chromecast, GoogleTV).
> 
> Actually, it is a two-fold RFC also raising discussions on mach-mvebu
> cleanup roadmap to allow other SoCs to hop into it. While mach-mvebu
> originally was created to add support for Armada 370/XP and merge
> existing Marvell Orion familiy into it, I am not so sure about
> Armada 1500 fits that well (the mbus has gone!).
> 
> If you are brave enough to try this on any GoogleTV, hit Google for
> instructions on how to get a unlocked u-boot and void your warranty :)
> The patches are based on v3.11-rc5 directly.
> 
> This cover letter and the separate patches have also been Cc'd to the
> respective maintainers to clear up some questions before posting a real
> patch set.

Great stuff!

Regarding the question about the directory, is there going to be any
shared code with the files present in mach-mvebu, e.g. the SMP support
that I assume is planned for a later point?

If there is shared code, it's probably best to have it in here. Otherwise
I don't care either way: We have precedent for fairly unrelated platforms
(ev2+shmobile, or the mach-bcm) being in the same directory for practical
reasons, and you can also create an almost empty directory now as we are
likely going to consolidate all "trivial" platforms in the future. Once
the l2x0 and clock init code as well as the early mapping has been
addressed, there won't be any platform code left.

	Arnd
